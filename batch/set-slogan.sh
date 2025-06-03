#!/bin/bash

# Recherche le fichier de config
CONFIG_FILE="$(find .. -maxdepth 2 \( -name 'hugo.toml' -o -name 'config.toml' \) | head -n 1)"
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "❌ Fichier hugo.toml ou config.toml introuvable"
  exit 1
fi

echo "📄 Fichier de config détecté : $CONFIG_FILE"

# Détecte les langues
LANGS=$(grep -oP '^\s*\[languages\.\K[a-z]{2}(?=\])' "$CONFIG_FILE" | sort -u)
if [[ -z "$LANGS" ]]; then
  echo "❌ Aucune langue trouvée dans [languages]"
  exit 1
fi

for lang in $LANGS; do
  echo -n "📝 Nouveau slogan pour '$lang' : "
  read slogan
  slogan_escaped=$(printf '%s' "$slogan" | sed 's/"/\\"/g')

  TMP_FILE=$(mktemp)
  inserted=0
  in_lang=0
  in_params=0

  while IFS= read -r line; do
    if [[ "$line" =~ ^\[languages\.${lang}\]$ ]]; then
      in_lang=1
    elif [[ "$line" =~ ^\[languages\.[a-z]{2}\]$ ]]; then
      in_lang=0
    fi

    if [[ "$line" =~ ^\[languages\.${lang}\.params\]$ ]]; then
      in_params=1
      echo "$line" >> "$TMP_FILE"
      continue
    elif [[ "$line" =~ ^\[languages\.[a-z]{2}(\.params)?\]$ ]]; then
      if [[ $in_params -eq 1 && $inserted -eq 0 ]]; then
        echo "slogan = \"$slogan_escaped\"" >> "$TMP_FILE"
        inserted=1
      fi
      in_params=0
    fi

    if [[ $in_params -eq 1 && "$line" =~ ^\s*slogan\s*= ]]; then
      echo "slogan = \"$slogan_escaped\"" >> "$TMP_FILE"
      inserted=1
      continue
    fi

    echo "$line" >> "$TMP_FILE"
  done < "$CONFIG_FILE"

  # Slogan jamais inséré : bloc params existe ou non
  if [[ $in_params -eq 1 && $inserted -eq 0 ]]; then
    echo "slogan = \"$slogan_escaped\"" >> "$TMP_FILE"
  elif [[ $in_lang -eq 1 && $in_params -eq 0 ]]; then
    echo "" >> "$TMP_FILE"
    echo "[languages.${lang}.params]" >> "$TMP_FILE"
    echo "slogan = \"$slogan_escaped\"" >> "$TMP_FILE"
  fi

  mv "$TMP_FILE" "$CONFIG_FILE"

  # Ajout du shortcode dans _index.md
  INDEX_FILE="../content/${lang}/_index.md"
  if [[ ! -f "$INDEX_FILE" ]]; then
    echo -e "---\ntitle: \"Accueil\"\n---\n\n{{< slogan >}}" > "$INDEX_FILE"
    echo "🆕 Fichier créé : $INDEX_FILE"
  elif ! grep -q "{{< slogan >}}" "$INDEX_FILE"; then
    echo -e "\n{{< slogan >}}" >> "$INDEX_FILE"
    echo "🔧 Shortcode ajouté à : $INDEX_FILE"
  fi
done

echo
echo "📄 Nouveau contenu de $CONFIG_FILE :"
cat "$CONFIG_FILE"
echo
echo "✅ Tous les slogans ont été insérés ou mis à jour."

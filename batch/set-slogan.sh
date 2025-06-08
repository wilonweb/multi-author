#!/bin/bash

CONFIG_FILE="../hugo.toml"

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "❌ Fichier hugo.toml introuvable"
  exit 1
fi

echo "📄 Fichier détecté : $CONFIG_FILE"

# Récupère toutes les langues définies
LANGS=$(dasel -r toml -f "$CONFIG_FILE" 'languages.all().key()' --write plain)

for lang in $LANGS; do
  echo -n "📝 Slogan pour '$lang' : "
  read slogan
  dasel put -r toml -w toml -f "$CONFIG_FILE" -v "$slogan" "languages.$lang.params.slogan"
done

echo "✅ Tous les slogans ont été insérés ou mis à jour dans $CONFIG_FILE"


  INDEX_FILE="../content/${lang}/_index.md"
  if [[ ! -f "$INDEX_FILE" ]]; then
    echo -e "---\ntitle: \"Accueil\"\n---\n\n{{< slogan >}}" > "$INDEX_FILE"
    echo "🆕 Fichier créé : $INDEX_FILE"
  elif ! grep -q "{{< slogan >}}" "$INDEX_FILE"; then
    echo -e "\n{{< slogan >}}" >> "$INDEX_FILE"
    echo "🔧 Shortcode ajouté à : $INDEX_FILE"
  fi

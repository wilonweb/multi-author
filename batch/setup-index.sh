#!/bin/bash

CONFIG_FILE="../hugo.toml"
CONTENT_DIR="../content"

# 🔎 Vérifie que le fichier hugo.toml existe
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "❌ Fichier hugo.toml introuvable"
  exit 1
fi

# 📚 Liste des langues
LANGS=$(dasel -r toml -f "$CONFIG_FILE" 'languages.all().key()' --write plain)

echo "🌍 Langues détectées : $LANGS"
echo

for lang in $LANGS; do
  INDEX_FILE="$CONTENT_DIR/$lang/_index.md"

  # 📂 Création du dossier si nécessaire
  mkdir -p "$(dirname "$INDEX_FILE")"

  if [[ ! -f "$INDEX_FILE" ]]; then
    echo -e "---\ntitle: \"Accueil\"\n---\n\n{{< slogan >}}" > "$INDEX_FILE"
    echo "✅ Fichier créé : $INDEX_FILE"
  elif ! grep -q "{{< slogan >}}" "$INDEX_FILE"; then
    echo -e "\n{{< slogan >}}" >> "$INDEX_FILE"
    echo "✏️ Shortcode ajouté dans : $INDEX_FILE"
  else
    echo "⚠️ Déjà prêt : $INDEX_FILE"
  fi
done

echo
echo "🏁 Tous les fichiers _index.md sont en place avec le shortcode {{< slogan >}}"

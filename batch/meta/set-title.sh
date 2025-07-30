#!/bin/bash

# Répertoire du script (absolu)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

config_file="$PROJECT_DIR/hugo.toml"
tmp_file="$PROJECT_DIR/hugo_tmp.toml"

# Vérifie que le fichier existe
if [ ! -f "$config_file" ]; then
  echo "❌ Fichier introuvable : $config_file"
  exit 1
fi

read -p "Quel est le titre de ton site ? " site_title

# Traitement du fichier
while IFS= read -r line; do
    if [[ $line == title\ =* ]]; then
        echo "title = \"$site_title\"" >> "$tmp_file"
    else
        echo "$line" >> "$tmp_file"
    fi
done < "$config_file"

mv "$tmp_file" "$config_file"

echo "✅ Titre mis à jour dans hugo.toml"

#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
CONFIG_FILE="$PROJECT_DIR/hugo.toml"
TMP_FILE="$PROJECT_DIR/hugo_tmp.toml"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "❌ Fichier introuvable : $CONFIG_FILE"
  exit 1
fi

read -p "Langue à modifier (ex: fr, es, ar, etc.) : " lang_code
read -p "Description du site pour [$lang_code] : " desc
read -p "Bio courte pour [$lang_code] : " bio

found=0
while IFS= read -r line; do
  echo "$line" >> "$TMP_FILE"

  # Injecter dans le bon bloc
  if [[ "$line" =~ \[languages\.${lang_code}\.params\] ]]; then
    found=1
  elif [[ "$found" -eq 1 && "$line" =~ ^\[ ]]; then
    # Fin du bloc params -> insérer et couper
    echo "  description = \"$desc\"" >> "$TMP_FILE"
    echo "  bio = \"$bio\"" >> "$TMP_FILE"
    found=0
  fi
done < "$CONFIG_FILE"

# Si jamais on était encore dans le bloc à la fin
if [[ "$found" -eq 1 ]]; then
  echo "  description = \"$desc\"" >> "$TMP_FILE"
  echo "  bio = \"$bio\"" >> "$TMP_FILE"
fi

mv "$TMP_FILE" "$CONFIG_FILE"
echo "✅ Description et bio ajoutées pour [$lang_code]"

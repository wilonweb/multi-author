#!/bin/bash

# 📍 Positionne les chemins du projet
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
config_file="$PROJECT_DIR/hugo.toml"
tmp_file="$PROJECT_DIR/hugo_tmp.toml"

# 📎 Vérifie que le fichier de configuration existe
if [ ! -f "$config_file" ]; then
  echo "❌ Fichier introuvable : $config_file"
  exit 1
fi

# 🧹 Supprime les anciennes définitions multilingues
grep -v 'defaultContentLanguage' "$config_file" \
  | grep -v '^\[languages' \
  | grep -v '^  \[languages\.' \
  | grep -v 'languageName' \
  | grep -v 'weight =' \
  | grep -v 'contentDir =' \
  > "$tmp_file"

# ✏️ Ajoute le bloc multilingue à la suite
cat >> "$tmp_file" <<EOL

defaultContentLanguage = "fr"

[languages]
  [languages.fr]
    languageName = "Français"
    contentDir = "content/fr"
    weight = 1

  [languages.es]
    languageName = "Español"
    contentDir = "content/es"
    weight = 2

  [languages.he]
    languageName = "עברית"
    contentDir = "content/he"
    weight = 3
    [languages.he.params]
      rtl = true

  [languages.ar]
    languageName = "العربية"
    contentDir = "content/ar"
    weight = 4
    [languages.ar.params]
      rtl = true

  [languages.fa]
    languageName = "فارسی"
    contentDir = "content/fa"
    weight = 5
    [languages.fa.params]
      rtl = true
EOL

# 💾 Sauvegarde le nouveau hugo.toml
mv "$tmp_file" "$config_file"

# 📁 Génère les fichiers _index.md pour chaque langue si manquants
for lang in fr es he ar fa; do
  content_path="$PROJECT_DIR/content/$lang/_index.md"
  if [ ! -f "$content_path" ]; then
    mkdir -p "$(dirname "$content_path")"
    cat > "$content_path" <<EOF
---
title: "Bienvenue (${lang})"
description: "Page d'accueil en ${lang}"
---
EOF
    echo "✅ Créé : $content_path"
  else
    echo "⚠️ Déjà existant : $content_path"
  fi
done

echo ""
echo "✅ Fichier hugo.toml mis à jour avec 5 langues"
echo "🌍 Fichiers _index.md créés pour chaque langue"

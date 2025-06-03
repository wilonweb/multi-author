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

# 🧹 Nettoie l'ancien config.toml (en retirant les anciens blocs multilingues)
grep -v 'defaultContentLanguage' "$config_file" \
  | grep -v '^\[languages' \
  | grep -v '^  \[languages\.' \
  > "$tmp_file"

# ✏️ Ajoute la nouvelle configuration multilingue
cat >> "$tmp_file" <<'EOL'

defaultContentLanguage = "fr"

[languages]

  [languages.fr]
    languageName = "Français"
    contentDir = "content/fr"
    weight = 1
    [languages.fr.params]
      displayName = "Français"
    [languages.fr.menus]
      [[languages.fr.menus.main]]
        name = "Accueil"
        pageRef = "/"
        weight = 1
      [[languages.fr.menus.main]]
        name = "Articles"
        pageRef = "/posts/"
        weight = 2

  [languages.es]
    languageName = "Español"
    contentDir = "content/es"
    weight = 2
    [languages.es.params]
      displayName = "Español"
    [languages.es.menus]
      [[languages.es.menus.main]]
        name = "Inicio"
        pageRef = "/"
        weight = 1
      [[languages.es.menus.main]]
        name = "Artículos"
        pageRef = "/posts/"
        weight = 2

  [languages.he]
    languageName = "עברית"
    contentDir = "content/he"
    weight = 3
    [languages.he.params]
      displayName = "עברית"
      rtl = true
    [languages.he.menus]
      [[languages.he.menus.main]]
        name = "דף הבית"
        pageRef = "/"
        weight = 1
      [[languages.he.menus.main]]
        name = "מאמרים"
        pageRef = "/posts/"
        weight = 2

  [languages.ar]
    languageName = "العربية"
    contentDir = "content/ar"
    weight = 4
    [languages.ar.params]
      displayName = "العربية"
      rtl = true
    [languages.ar.menus]
      [[languages.ar.menus.main]]
        name = "الرئيسية"
        pageRef = "/"
        weight = 1
      [[languages.ar.menus.main]]
        name = "مقالات"
        pageRef = "/posts/"
        weight = 2

  [languages.fa]
    languageName = "فارسی"
    contentDir = "content/fa"
    weight = 5
    [languages.fa.params]
      displayName = "فارسی"
      rtl = true
    [languages.fa.menus]
      [[languages.fa.menus.main]]
        name = "خانه"
        pageRef = "/"
        weight = 1
      [[languages.fa.menus.main]]
        name = "مقالات"
        pageRef = "/posts/"
        weight = 2
EOL

# 💾 Remplace le fichier hugo.toml par le nouveau
mv "$tmp_file" "$config_file"

echo "✅ Fichier hugo.toml mis à jour avec menus, displayName et paramètres multilingues complets."

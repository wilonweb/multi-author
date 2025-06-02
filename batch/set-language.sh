#!/bin/bash

# Récupère le répertoire où se trouve ce script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Définit le chemin du projet Hugo (on suppose que le script est dans /batch)
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Chemin du fichier de configuration principal de Hugo
config_file="$PROJECT_DIR/hugo.toml"

# Fichier temporaire pour écrire la nouvelle configuration
tmp_file="$PROJECT_DIR/hugo_tmp.toml"

# Vérifie que le fichier hugo.toml existe bien
if [ ! -f "$config_file" ]; then
  echo "❌ Fichier introuvable : $config_file"
  exit 1
fi

# Demande à l'utilisateur de saisir la langue principale (ex : fr)
read -p "Langue principale (code ISO, ex: fr) : " default_lang

# Demande une seconde langue (ex : en, es, de)
read -p "Langue secondaire (ex: en, es, de) : " secondary_lang

# Supprime les lignes existantes qui contiennent 'defaultContentLanguage' ou débutent par '[languages'
# Cela évite les doublons ou conflits quand on réécrit la configuration
grep -v 'defaultContentLanguage' "$config_file" | grep -v '^\[languages' > "$tmp_file"

# Ajoute les lignes de configuration multilingue dans le fichier temporaire
cat >> "$tmp_file" <<EOL

defaultContentLanguage = "$default_lang"

[languages]
  [languages.$default_lang]
    languageName = "Français"
    weight = 1

  [languages.$secondary_lang]
    languageName = "English"
    weight = 2
EOL

# Remplace l'ancien hugo.toml par la version modifiée
mv "$tmp_file" "$config_file"

# Message de confirmation
echo "✅ Configuration multilingue mise à jour dans hugo.toml"

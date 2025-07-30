#!/bin/bash

echo "🖼️ Configuration d'une image d’accueil pour le site Hugo (auto-détection de la racine + injection dans hero)"

# 1. Demander le chemin de l’image source
read -p "Chemin de l'image locale (ex: /c/Users/wilon/Pictures/avatar.png) : " image_path

# 2. Vérification que le fichier existe
while [ ! -f "$image_path" ]; do
  echo "❌ Fichier introuvable à $image_path"
  read -p "➡️ Réessaie avec un chemin commençant par /c/ : " image_path
done

# 3. Détection automatique de la racine Hugo
project_root="$(git rev-parse --show-toplevel 2>/dev/null || realpath "$(pwd)/..")"

if [ ! -f "$project_root/hugo.toml" ] && [ ! -f "$project_root/config.toml" ] && [ ! -d "$project_root/config" ]; then
  echo "⚠️ Projet Hugo non détecté automatiquement."
  read -p "➡️ Chemin du dossier racine Hugo (ex: ../..) : " manual_path
  project_root=$(realpath "$manual_path")
  if [ ! -f "$project_root/hugo.toml" ] && [ ! -f "$project_root/config.toml" ] && [ ! -d "$project_root/config" ]; then
    echo "❌ Dossier invalide : $project_root"
    exit 1
  fi
fi

echo "📁 Projet Hugo détecté à : $project_root"

# 4. Copier l’image dans le bon static/
image_name=$(basename "$image_path")
target_path="$project_root/static/$image_name"

mkdir -p "$project_root/static"
cp "$image_path" "$target_path" && echo "✅ Image copiée dans $target_path"

# 5. Modifier content/_index.md pour afficher l’image en hero
index_file="$project_root/content/_index.md"
mkdir -p "$(dirname "$index_file")"

# Créer fichier s’il n’existe pas
if [ ! -f "$index_file" ]; then
  echo -e "---\ntitle: \"Accueil\"\n---" > "$index_file"
fi

# Supprimer ancien bloc hero
sed -i '/^hero:/,/^[^ ]/d' "$index_file"

# Ajouter bloc hero
cat <<EOF >> "$index_file"

hero:
  enabled: true
  image: "/$image_name"
  align: center
  headline: "Bienvenue sur mon site"
  description: "Page d’accueil propulsée par Hugo + Blowfish"
EOF

echo "🎉 Image d’accueil ajoutée dans content/_index.md"

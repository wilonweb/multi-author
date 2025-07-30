#!/bin/bash

# 📂 Localise le fichier hugo.toml
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
CONFIG_FILE="$PROJECT_DIR/hugo.toml"

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "❌ Fichier hugo.toml introuvable dans $PROJECT_DIR"
  exit 1
fi

# 🔤 Demande les langues avec nettoyage des inputs
read -p "Code langue principale (ex: fr) : " lang1
read -p "Nom affiché (ex: Français) pour $lang1 : " name1
read -p "Poids (ordre d'affichage, ex: 1) pour $lang1 : " weight1
weight1=$(echo "$weight1" | tr -cd '[:digit:]')

read -p "Code langue secondaire (ex: en) : " lang2
read -p "Nom affiché (ex: English) pour $lang2 : " name2
read -p "Poids (ordre d'affichage, ex: 2) pour $lang2 : " weight2
weight2=$(echo "$weight2" | tr -cd '[:digit:]')

if [[ -z "$weight1" || -z "$weight2" ]]; then
  echo "❌ Les poids doivent être des nombres entiers."
  exit 1
fi

# ✅ Fonction pour ajouter une langue si elle n'existe pas
add_lang_block() {
  local lang="$1"
  local name="$2"
  local weight="$3"

  if grep -q "^\[languages\.$lang\]" "$CONFIG_FILE"; then
    echo "⚠️ La langue '$lang' existe déjà, rien à faire."
  else
    echo -e "\n[languages.$lang]" >> "$CONFIG_FILE"
    echo "languageName = \"$name\"" >> "$CONFIG_FILE"
    echo "contentDir = \"content/$lang\"" >> "$CONFIG_FILE"
    echo "weight = $weight" >> "$CONFIG_FILE"
    echo "[languages.$lang.params]" >> "$CONFIG_FILE"
    echo "  displayName = \"$name\"" >> "$CONFIG_FILE"
    echo "[languages.$lang.menus]" >> "$CONFIG_FILE"
    echo "  [[languages.$lang.menus.main]]" >> "$CONFIG_FILE"
    echo "    name = \"Home\"" >> "$CONFIG_FILE"
    echo "    pageRef = \"/\"" >> "$CONFIG_FILE"
    echo "    weight = 1" >> "$CONFIG_FILE"
    echo "  [[languages.$lang.menus.main]]" >> "$CONFIG_FILE"
    echo "    name = \"Posts\"" >> "$CONFIG_FILE"
    echo "    pageRef = \"/posts/\"" >> "$CONFIG_FILE"
    echo "    weight = 2" >> "$CONFIG_FILE"
    echo "✅ Langue '$lang' ajoutée."
  fi
}

# 🛠️ Ajoute defaultContentLanguage si absent
if ! grep -q "^defaultContentLanguage" "$CONFIG_FILE"; then
  echo -e "\ndefaultContentLanguage = \"$lang1\"" >> "$CONFIG_FILE"
  echo "✅ defaultContentLanguage = \"$lang1\" ajouté."
fi

# 🔁 Ajout des langues
add_lang_block "$lang1" "$name1" "$weight1"
add_lang_block "$lang2" "$name2" "$weight2"

echo -e "\n🎉 Terminé."

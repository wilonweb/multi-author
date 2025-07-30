#!/bin/bash

# 📂 Chemins
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
CONFIG_FILE="$PROJECT_DIR/hugo.toml"
CONTENT_DIR="$PROJECT_DIR/content"
TMP_FILE="$PROJECT_DIR/hugo_tmp.toml"

# 📜 Langues RTL connues
RTL_LANGS=("ar" "fa" "he" "ur" "ps" "syr" "dv")

# 🧪 Vérif
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "❌ Fichier introuvable : $CONFIG_FILE"
  exit 1
fi

# 🌐 Langue par défaut
read -p "Langue par défaut (ex: fr) : " default_lang
# Supprime l'ancienne ligne si elle existe
grep -v '^defaultContentLanguage' "$CONFIG_FILE" > "$TMP_FILE"
echo "defaultContentLanguage = \"$default_lang\"" >> "$TMP_FILE"

# Nettoie tous les anciens blocs [languages.xx]
awk '
  BEGIN { skip=0 }
  /^\[languages\.[a-z]{2,3}\]/ { skip=1; next }
  /^\[languages\..*\]/ { skip=1; next }
  /^\[.*\]/ { skip=0 }
  skip==0 { print }
' "$TMP_FILE" > "$CONFIG_FILE"

echo "✅ defaultContentLanguage = \"$default_lang\" défini et anciens blocs nettoyés."

# 🔁 Ajout de plusieurs langues
while true; do
  echo ""
  read -p "Code langue (ex: en), ENTER pour arrêter : " lang
  [[ -z "$lang" ]] && break

  read -p "Nom affiché pour $lang : " name
  read -p "Poids (ordre dans menu) : " weight

  # RTL ?
  is_rtl=false
  for rtl_lang in "${RTL_LANGS[@]}"; do
    [[ "$lang" == "$rtl_lang" ]] && is_rtl=true && break
  done

  # Ajout du bloc dans hugo.toml
  {
    echo ""
    echo "[languages.$lang]"
    echo "languageName = \"$name\""
    echo "contentDir = \"content/$lang\""
    echo "weight = $weight"
    echo "[languages.$lang.params]"
    echo "  displayName = \"$name\""
    [[ "$is_rtl" == true ]] && echo "  rtl = true"
    echo "[languages.$lang.menus]"
    echo "  [[languages.$lang.menus.main]]"
    echo "    name = \"Home\""
    echo "    pageRef = \"/\""
    echo "    weight = 1"
    echo "  [[languages.$lang.menus.main]]"
    echo "    name = \"Posts\""
    echo "    pageRef = \"/posts/\""
    echo "    weight = 2"
  } >> "$CONFIG_FILE"

  echo "✅ Langue '$lang' ajoutée avec${is_rtl:+ RTL}."

  # 📁 Création du dossier content/lang + _index.md
  LANG_DIR="$CONTENT_DIR/$lang"
  INDEX_FILE="$LANG_DIR/_index.md"
  mkdir -p "$LANG_DIR"
  if [[ ! -f "$INDEX_FILE" ]]; then
    echo -e "---\ntitle: \"Accueil\"\n---\n\n{{< slogan >}}" > "$INDEX_FILE"
    echo "📄 _index.md créé dans $LANG_DIR"
  fi
done

echo ""
echo "🎉 Toutes les langues sont configurées dans hugo.toml et content/."

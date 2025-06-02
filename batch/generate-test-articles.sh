#!/bin/bash

# 📍 Répertoire du projet Hugo
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_DIR"

config_file="hugo.toml"
article_name="mon-test.md"

# 🌐 Traductions de base
declare -A messages
messages[fr]="Bonjour Wil, tu as réussi."
messages[en]="Hello Wil, you made it."
messages[es]="Hola Wil, lo lograste."
messages[de]="Hallo Wil, du hast es geschafft."
messages[it]="Ciao Wil, ce l'hai fatta."
messages[pt]="Olá Wil, você conseguiu."
messages[ar]="مرحبا ويل، لقد نجحت."
messages[fa]="سلام ویل، موفق شدی."
messages[he]="שלום ויל, הצלחת."
messages[ja]="こんにちはWil、成功しました。"
messages[zh]="你好Wil，你成功了。"
messages[ru]="Привет Уил, ты справился."
messages[tr]="Merhaba Wil, başardın."
messages[nl]="Hallo Wil, je bent geslaagd."

# 🔍 Extraction des langues depuis hugo.toml
LANGS=$(grep -oP '\[languages\.\K[a-z]{2}(-[a-z]{2})?' "$config_file")

echo "🌍 Langues détectées dans hugo.toml : $LANGS"
echo

for lang in $LANGS; do
  folder="content/$lang/posts"
  filepath="$folder/$article_name"
  message="${messages[$lang]}"

  # Fallback si pas de traduction
  if [ -z "$message" ]; then
    message="Hello Wil, you made it. ([$lang])"
  fi

  # Crée le _index.md si absent
  index_file="$folder/_index.md"
  if [ ! -f "$index_file" ]; then
    mkdir -p "$folder"
    echo -e "---\ntitle: \"Articles\"\nlayout: list\n---" > "$index_file"
    echo "✅ _index.md créé : $index_file"
  fi

  # Crée l'article s'il n'existe pas
  if [ ! -f "$filepath" ]; then
    mkdir -p "$folder"
    cat > "$filepath" <<EOF
---
title: "Mon Test (${lang})"
date: $(date -Iseconds)
draft: false
---

$message
EOF
    echo "✅ Article généré : $filepath"
  else
    echo "⚠️ Article déjà présent : $filepath"
  fi
done

echo
echo "🏁 Tous les fichiers sont prêts à s'afficher dans /<lang>/posts/"

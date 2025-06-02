#!/bin/bash

# 📍 Chemins
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_DIR"

config_file="hugo.toml"
article_name="bienvenue.md"

# 🌐 Traductions de "Bonjour Wil, tu as réussi."
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

# 🔎 Récupération des langues depuis hugo.toml
LANGS=$(grep -E "^\[languages\.[a-z]{2}(-[a-z]{2})?\]" "$config_file" | sed 's/\[languages\.//' | sed 's/\]//')

echo "🌐 Langues détectées dans hugo.toml : $LANGS"
echo

# 📝 Création des fichiers
for lang in $LANGS; do
  filepath="content/$lang/$article_name"
  message="${messages[$lang]}"

  # Utilise l'anglais par défaut si la langue est absente
  if [ -z "$message" ]; then
    message="Hello Wil, you made it. ([$lang])"
  fi

  if [ ! -f "$filepath" ]; then
    mkdir -p "$(dirname "$filepath")"
    cat > "$filepath" <<EOF
---
title: "Bienvenue (${lang})"
date: $(date -Iseconds)
draft: false
---

$message
EOF
    echo "✅ Créé : $filepath"
  else
    echo "⚠️ Existe déjà : $filepath"
  fi
done

echo
echo "🏁 Fichiers bienvenue.md générés avec succès 🎉"

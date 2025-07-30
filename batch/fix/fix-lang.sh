#!/bin/bash

# nettoie automatiquement ton fichier hugo.toml en supprimant les blocs [languages.xxx] dont le nom de langue est invalide (c’est-à-dire tout ce qui ne correspond pas à deux lettres alphabétiques comme fr, en, es, etc.)

# 📍 Emplacement du fichier de configuration
CONFIG_FILE="../hugo.toml"
TMP_FILE="../hugo_tmp.toml"

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "❌ Fichier $CONFIG_FILE introuvable"
  exit 1
fi

echo "🔍 Nettoyage des blocs [languages.X] invalides..."

# 🧼 On filtre uniquement les blocs valides et supprime les blocs invalides
awk '
  /^\[languages\.[a-z]{2}\]/    { keep = 1; print; next }
  /^\[languages\..*\]/          { keep = 0; next }
  /^\[/                         { keep = 1; print; next }
  keep == 1                     { print }
' "$CONFIG_FILE" > "$TMP_FILE"

# 📝 On remplace l'ancien fichier
mv "$TMP_FILE" "$CONFIG_FILE"

echo "✅ Blocs invalides supprimés. Fichier nettoyé : $CONFIG_FILE"

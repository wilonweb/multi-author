#!/bin/bash

FILE="hugo.toml"
BACKUP="hugo.toml.bak"

# 🛡️ Sauvegarde
cp "$FILE" "$BACKUP"
echo "🔒 Backup créé : $BACKUP"

# 🧹 Nettoyage du fichier
awk '
BEGIN { insideLanguagesBlock = 0 }
/^\[languages\]$/ {
  insideLanguagesBlock = 1
  print
  next
}
/^\[languages\.[a-z]{2,3}(\.menus|\.(params|menus)\.main)?\]$/ {
  if (insideLanguagesBlock) {
    print
    next
  } else {
    # 🚫 Skip les blocs dupliqués hors du bloc [languages]
    skip = 1
    next
  }
}
/^\[.*\]$/ {
  skip = 0
  if (!insideLanguagesBlock) {
    print
    next
  }
}
{
  if (!skip) print
}
' "$BACKUP" > "$FILE"

echo "✅ hugo.toml nettoyé avec succès."


#!/bin/bash

# 📍 Répertoire du script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_DIR"

# 1. Définir les langues dans hugo.toml
echo "🔧 Étape 1 : Configuration multilingue"
"$SCRIPT_DIR/set-language-multi.sh" || { echo "❌ Erreur set-language-multi.sh"; exit 1; }

# 2. Générer les fichiers bienvenue.md
echo "📝 Étape 2 : Génération des messages de bienvenue"
"$SCRIPT_DIR/generate-lang-content.sh" || { echo "❌ Erreur generate-lang-content.sh"; exit 1; }

# 3. Générer les articles de test
echo "📰 Étape 3 : Génération des articles de test"
"$SCRIPT_DIR/generate-test-articles.sh" || { echo "❌ Erreur generate-test-articles.sh"; exit 1; }

echo ""
echo "✅ Setup terminé. Lance 'hugo server -D' pour tester ton site."

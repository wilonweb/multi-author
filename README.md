# 🚀 Multi Author

L'idée de ce repo est d'utiiliser le template pour en faire un site multi author et documenter le process

On vas gegalement faire en sorte qu'il y est des batch pour automatiser le fait qu'il y est tel ou tel congig. 

On vas prendre pour exemple Les pilotes de l'IT 

---

## Les commande sympa
cat batch/*.sh : Affiche le contenue des batch

for file in ./batch/*; do
  echo "===== $file ====="
  cat "$file"
  echo ""
done | clip

## Les batch

✅ generate-lang-content.sh
But : Crée un fichier bienvenue.md dans chaque langue détectée dans hugo.toml.

Il écrit un petit message "Bonjour Wil, tu as réussi." (traduit)
Utilisé pour générer une page de bienvenue pour chaque langue

✅ generate-test-articles.sh
But : Crée un article mon-test.md dans chaque langue, dans /posts/.

Crée également un fichier _index.md avec layout: list si nécessaire
Sert à tester l'affichage d’articles multi-langue dans Hugo

✅ set-language.sh
But : Te permet d’ajouter manuellement une langue principale et une langue secondaire à hugo.toml.
Supprime les anciennes définitions de langues

Génère une config de base simple (sans menus, contentDir, etc.)

✅ set-language-multi.sh
But : Insère dans hugo.toml une configuration multilingue complète avec :

defaultContentLanguage

contentDir, params, menus, etc. pour plusieurs langues (fr, es, he, ar, fa)

C’est le script à utiliser pour avoir une config complète et prête à l’emploi avec plusieurs langues.

✅ set-title.sh
But : Met à jour la ligne title = "..." dans hugo.toml.

Pose la question "Quel est le titre de ton site ?"

Écrit ce titre proprement dans le fichier

✅ setup-multilang.sh
But : Lance un setup complet en 3 étapes :

Ajoute la configuration multilingue avec set-language-multi.sh
Crée les fichiers bienvenue.md avec generate-lang-content.sh
Crée les articles mon-test.md avec generate-test-articles.sh
C’est ton script principal pour mettre en place un site multilingue de test fonctionnel.

## Ordre de batvj

🟡 tout faire d’un coup pour le multi langue

./batch/setup-multilang.sh
Ce script exécute automatiquement les trois étapes dans le bon ordre :

set-language-multi.sh
generate-lang-content.sh
generate-test-articles.sh

✅ Facultatif : changer le titre du site
Si tu veux personnaliser le titre :

./batch/set-title.sh


## Ce qu'on a fait
Creation du dossier batch 
pour avoir plein de module en bash pour 
set title : modifie le titre


Pour voir la liste des articles 
http://localhost:1313/multi-author/fr/posts/





## Question 

Comment automatiser le fait de définir le titre du site. 
# 🌐 Scripts multilingues Hugo — Batch Setup

Ce dossier contient une suite de scripts Bash pour automatiser la configuration multilingue d’un site Hugo. Il permet de :

- Ajouter des langues au fichier `hugo.toml`
- Générer du contenu d'accueil traduit (`bienvenue.md`)
- Générer des articles de test (`mon-test.md`)
- Préconfigurer les menus et les paramètres RTL ( right to left, arabe, hebreux et perse )

---

## ✅ Utilisation rapide

```bash
cd language/
./setup-multilang.sh
````

Ce script exécute 3 étapes automatiquement :

1. Configure les langues par défaut et secondaires (`set-language-multi.sh`)
2. Génère un message d’accueil (`generate-lang-content.sh`)
3. Crée des articles de test dans `/posts/` (`generate-test-articles.sh`)

---

## 📄 Description des scripts

| Script                      | Description                                                         |
| --------------------------- | ------------------------------------------------------------------- |
| `setup-multilang.sh`        | Script principal, enchaîne toutes les étapes                        |
| `set-language-multi.sh`     | Insère 5 langues (fr, es, he, ar, fa) avec menus, displayName, RTL… |
| `generate-lang-content.sh`  | Crée `bienvenue.md` dans chaque langue avec message traduit         |
| `generate-test-articles.sh` | Crée `mon-test.md` dans chaque `/posts/` + `_index.md`              |
| `add-language.sh`           | Ajoute 2 langues manuellement au `hugo.toml`                        |
| `add-languages-multiple.sh` | Ajoute plusieurs langues en boucle, avec gestion RTL                |
| `set-language.sh`           | Similaire à `add-language.sh`, mais en version plus basique         |

---

## ⚠️ Scripts redondants ou à fusionner ?

* `add-language.sh` et `set-language.sh` font la même chose ➜ **fusion possible**
* `add-languages-multiple.sh` est une version interactive plus souple ➜ **à garder**
* `set-language-multi.sh` est rigide (langues prédéfinies) ➜ utile comme **template de départ**

➡️ Suggestion : créer un **menu interactif** pour choisir entre :

* Ajout manuel simple (2 langues)
* Ajout en boucle
* Setup express multilingue complet

---

## 💡 Idées d’amélioration

* [ ] Ajouter la gestion automatique des drapeaux ou icônes dans le thème
* [ ] Générer des fichiers `_index.md` traduits (titre de section, layout…)
* [ ] Ajouter un fichier `languages.json` comme source pour préconfigurer les noms/poids/rtl
* [ ] Centraliser les traductions dans un fichier externe (`.json`, `.yml`…)

---

## 🔧 Dépendances

Ces scripts utilisent uniquement `bash`, `awk`, `grep`, `mkdir`, etc. Ils sont compatibles avec :

* Linux / macOS / Termux
* Git Bash sur Windows ✅

---

## 📂 Arborescence recommandée

```
batch/
├── language/
│   ├── setup-multilang.sh
│   ├── set-language-multi.sh
│   ├── add-language.sh
│   ├── add-languages-multiple.sh
│   ├── set-language.sh
│   ├── generate-lang-content.sh
│   └── generate-test-articles.sh
├── meta/
├── image/
└── ...
```

---

## 🧪 Test rapide

Lance simplement :

```bash
cd language/
./setup-multilang.sh
hugo server -D
```

Tu pourras visiter ton site Hugo sur `http://localhost:1313` avec les différentes langues actives.

---

## Auteur

Scripts conçus par [@wilonweb](https://github.com/wilonweb) — pour automatiser les projets Hugo multilingues en quelques secondes ⚡

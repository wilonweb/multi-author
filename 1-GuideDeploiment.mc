# 6-starter-hugo-blowfish

# 🚀 Guide de déploiement : Hugo + Blowfish + GitHub Pages

Ce guide vous permet de créer un site statique Hugo avec le thème Blowfish, déployé automatiquement via GitHub Pages avec un workflow GitHub Actions.

---

## 📦 Prérequis

* Un compte GitHub
* Git et Hugo Extended installés localement
* VS Code ou tout éditeur

---

## 1. Créer un dépôt GitHub

* Nom : `starter-hugo-blowfish`
* Décocher tout (pas de README, licence...)

---

## 2. Cloner le repo en HTTPS

```bash
git clone https://github.com/<votre-user>/starter-hugo-blowfish.git
cd starter-hugo-blowfish
```

---

## 3. Initialiser un site Hugo

```bash
hugo new site . --force
```

---

## 4. Ajouter le thème Blowfish (submodule)

```bash
git submodule add https://github.com/nunocoracao/blowfish themes/blowfish
```

---

## 5. Configuration de base `hugo.toml`

```toml
baseURL = 'https://<votre-user>.github.io/starter-hugo-blowfish/'
languageCode = 'fr-fr'
title = 'Mon blog'
theme = 'blowfish'

[params]
  defaultTheme = "auto"
  ShowReadingTime = true
  ShowPostNavLinks = true
  disableFingerprinting = true
  disableSRI = true
```

---

## 6. Créer un article de démo

```bash
hugo new posts/hello-world.md
```

Puis éditez `content/posts/hello-world.md` :

```md
---
title: "Hello World"
date: 2025-05-16
draft: false
---

Bienvenue sur mon blog Hugo avec le thème Blowfish !
```

---

## 7. Ajouter un `.gitignore`

```bash
echo "/public/" >> .gitignore
echo "/resources/" >> .gitignore
```

---

## 8. Ajouter le workflow GitHub Pages

Fichier `.github/workflows/deploy.yml` :

```yaml
name: Deploy Hugo site to Pages

on:
  push:
    branches:
      - main
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    env:
      HUGO_VERSION: 0.147.1
    steps:
      - uses: actions/checkout@v4
        with:
          submodules: true

      - name: Install Hugo
        run: |
          wget -O ${{ runner.temp }}/hugo.deb https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb
          sudo dpkg -i ${{ runner.temp }}/hugo.deb

      - name: Setup Pages
        id: pages
        uses: actions/configure-pages@v5

      - name: Build
        run: hugo --minify --gc --cleanDestinationDir --baseURL "${{ steps.pages.outputs.base_url }}/"

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./public

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy
        id: deployment
        uses: actions/deploy-pages@v4
```

---

## 9. Commit & Push

```bash
git add .
git commit -m "Initial commit"
git push -u origin main
```

---

## 10. Activer GitHub Pages

1. Aller sur GitHub > votre repo
2. `Settings > Pages`
3. **Build and deployment** :

   * Source: **GitHub Actions**

> L’URL apparaîtra : `https://<user>.github.io/starter-hugo-blowfish/`

---

## 🚀 Démarrer en local

```bash
git submodule update --init --recursive
hugo server -D
```

> Accès : [http://localhost:1313](http://localhost:1313)

---

Ce projet est maintenant déployable automatiquement avec chaque push !

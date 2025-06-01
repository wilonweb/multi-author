# 🚀 Multi Author

L'idée de ce repo est d'utiiliser le template pour en faire un site multi author et documenter le process

---

## 🧪 Étapes pour créer un nouveau blog

### 1. 📄 Créer un nouveau repo avec ce template

- Clique sur le bouton **"Use this template"** (en haut à droite sur GitHub)
- Choisis un **nom de repo** (ex : `mon-blog`)
- Assure-toi qu’il est **public**
- Valide

---

### 2. ⚙️ Activer GitHub Pages

- Va dans `Settings` → `Pages`
- Dans **Build and Deployment**, choisis :
  - Source : `GitHub Actions`
- C’est tout. GitHub Pages va attendre le workflow.

---

### 3. 🛠️ Modifier `hugo.toml`

Avant de déployer en local, édite le fichier `hugo.toml` :

```toml
baseURL = 'https://<ton-user>.github.io/<nouveau-repo>/'
languageCode = 'fr-fr'
title = 'Mon blog'
theme = 'blowfish'

[params]
  defaultTheme = "auto"
  ShowReadingTime = true
  ShowPostNavLinks = true
```

exemple 
pages : https://wilonweb.github.io/test-template/
code : https://github.com/wilonweb/test-template

## TODO 
Deployer test-template en local

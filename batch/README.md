# 🧰 README des Scripts Hugo Multilang + Blowfish

Ce dépôt contient une collection de **scripts Bash** pour automatiser la configuration d'un site Hugo multilingue avec le thème **Blowfish**. Chaque script est regroupé par fonctionnalité.

---

## 📂 Arborescence

```
.
├── fix/             # Nettoyage du fichier hugo.toml
├── image/           # Configuration de l'image d'accueil (hero)
├── language/        # Ajout et génération de langues
├── meta/            # Slogan, bio, titre, description multilingue
├── setup-index.sh   # Ajout automatique des _index.md
```

---

## 📁 `fix/` – Nettoyage `hugo.toml`

### `fix-hugo-toml.sh`

* Nettoie les blocs `[languages.xx]` dupliqués ou mal placés
* Sauvegarde `hugo.toml` en `.bak`

### `fix-lang.sh`

* Supprime les blocs `[languages.xxx]` non valides (ex: `[languages.xyz]`)

**Utilisation** :

```bash
./fix/fix-hugo-toml.sh
./fix/fix-lang.sh
```

---

## 🖼️ `image/` – Image d’accueil (hero)

### `set-home-image.sh`

* Demande un chemin vers une image locale
* Copie vers `static/` et insère un bloc `hero:` dans `content/_index.md`

**Utilisation** :

```bash
./image/set-home-image.sh
```

---

## 🌐 `language/` – Gestion des langues Hugo

### `add-language.sh`

* Ajoute manuellement deux langues dans `hugo.toml`

### `add-languages-multiple.sh`

* Boucle interactive pour ajouter plusieurs langues (support RTL)

### `set-language.sh`

* Ajoute une configuration simple `lang1` + `lang2`

### `set-language-multi.sh`

* Ajoute 5 langues (fr, es, he, ar, fa) avec RTL, menus, displayName, etc.

### `setup-multilang.sh`

* Combo script : exécute automatiquement :

  * `set-language-multi.sh`
  * `generate-lang-content.sh`
  * `generate-test-articles.sh`

### `generate-lang-content.sh`

* Crée `bienvenue.md` dans chaque langue avec un message "Wil a réussi"

### `generate-test-articles.sh`

* Crée `posts/mon-test.md` pour chaque langue

**Utilisation recommandée** :

```bash
./language/setup-multilang.sh
```

---

## 🧠 `meta/` – Métadonnées multilingues

### `set-description.sh`

* Ajoute `description` et `bio` dans le bloc `[languages.xx.params]`

### `set-slogan.sh`

* Ajoute un champ `slogan` pour chaque langue + shortcode dans `_index.md`

### `set-title.sh`

* Change le champ global `title = "Mon Site"` dans `hugo.toml`

**Utilisation** :

```bash
./meta/set-title.sh
./meta/set-description.sh
./meta/set-slogan.sh
```

---

## 📚 `setup-index.sh`

* Insère le shortcode `{{< slogan >}}` dans tous les fichiers `_index.md`
* Crée les fichiers `_index.md` s’ils n’existent pas

**Utilisation** :

```bash
./setup-index.sh
```

---

## 🛠️ À améliorer / idées futures

* [ ] Script pour supprimer une langue
* [ ] Validation TOML automatique après chaque modification
* [ ] Intégration avec Git pour commits auto
* [ ] Ajout d’un mode `--dry-run`
* [ ] Fichier `lang.json` de configuration externe

---

## ▶️ Début rapide

```bash
cd language/
./setup-multilang.sh
cd ../meta/
./set-title.sh
./set-description.sh
./set-slogan.sh
cd ../image/
./set-home-image.sh
```

Ensuite, lance Hugo :

```bash
hugo server -D
```

---

## 🙌 Crédit

Scripts créés pour automatiser la configuration multilingue d’un site Hugo avec le thème **Blowfish** par Wilonweb ✨

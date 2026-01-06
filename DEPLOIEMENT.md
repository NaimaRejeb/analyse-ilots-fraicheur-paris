# 🚀 Guide de Déploiement sur GitHub Pages

## Étapes pour publier votre site web

### 1. Initialiser Git

```bash
git init
git add .
git commit -m "Premier commit - Site Quarto îlots de fraîcheur"
```

### 2. Créer un repository sur GitHub

1. Allez sur [github.com](https://github.com)
2. Cliquez sur **"New repository"** (+)
3. Nom du repository : `ilots-fraicheur-paris`
4. Description : `Analyse des îlots de fraîcheur à Paris`
5. Choisissez **Public**
6. Ne cochez PAS "Initialize with README" (vous en avez déjà un)
7. Cliquez sur **"Create repository"**

### 3. Lier votre projet au repository GitHub

```bash
# Remplacez VOTRE_USERNAME par votre nom d'utilisateur GitHub
git remote add origin https://github.com/VOTRE_USERNAME/ilots-fraicheur-paris.git
git branch -M main
git push -u origin main
```

### 4. Activer GitHub Pages

1. Sur GitHub, allez dans votre repository
2. Cliquez sur **Settings** (⚙️)
3. Dans le menu de gauche, cliquez sur **Pages**
4. Sous **Source**, sélectionnez :
   - Branch: `main`
   - Folder: `/docs`
5. Cliquez sur **Save**

### 5. Attendre le déploiement

- GitHub va construire votre site (2-3 minutes)
- Votre site sera disponible à :
  ```
  https://VOTRE_USERNAME.github.io/ilots-fraicheur-paris/
  ```

### 6. Vérifier le déploiement

- Rafraîchissez la page **Settings > Pages**
- Vous verrez un message vert avec l'URL de votre site

---

## 📝 Mettre à jour votre site

Chaque fois que vous modifiez vos fichiers :

```bash
# 1. Régénérer le site
quarto render

# 2. Commiter les changements
git add .
git commit -m "Mise à jour de l'analyse"

# 3. Pousser sur GitHub
git push
```

GitHub Pages mettra automatiquement à jour votre site !

---

## ⚠️ Résolution de problèmes

### Le site ne s'affiche pas
- Vérifiez que le dossier `/docs` contient des fichiers HTML
- Assurez-vous que `.nojekyll` existe dans le dossier `/docs`
- Attendez 5 minutes après le premier push

### Erreur 404
- Vérifiez l'URL : `https://USERNAME.github.io/NOM-REPO/`
- Allez dans Settings > Pages et vérifiez la configuration

### Les images ne s'affichent pas
- Vérifiez que le dossier `outputs/` est bien dans `/docs`
- Les chemins dans `visualisations.qmd` doivent être relatifs

---

## 🎨 Personnalisation

### Changer le thème
Éditez `_quarto.yml` :
```yaml
format:
  html:
    theme: flatly  # Autres: cosmo, united, journal, etc.
```

### Modifier les couleurs
Éditez `styles.css` :
```css
:root {
  --primary-color: #votrecouleur;
}
```

---

## 📚 Ressources

- [Documentation Quarto](https://quarto.org/docs/websites/)
- [Guide GitHub Pages](https://pages.github.com/)
- [Thèmes Quarto](https://quarto.org/docs/output-formats/html-themes.html)

---

Bon déploiement ! 🚀

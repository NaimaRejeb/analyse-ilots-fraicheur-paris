# 🌳 Îlots de Fraîcheur à Paris

[![Quarto](https://img.shields.io/badge/Quarto-Project-blue)](https://quarto.org)
[![R](https://img.shields.io/badge/R-Language-276DC3)](https://www.r-project.org/)
[![GitHub Pages](https://img.shields.io/badge/GitHub-Pages-green)](https://pages.github.com/)

Analyse statistique et géographique des îlots de fraîcheur à Paris.

## 📊 Description

Ce projet analyse les **548 îlots de fraîcheur** recensés à Paris à partir des données ouvertes de la Ville de Paris. Il comprend :

- 📈 Statistiques descriptives complètes
- 🗺️ Cartes géographiques interactives
- 📊 Visualisations avancées (radar, bulles, 3D)
- 📄 Exports de données CSV

## 🚀 Installation et Déploiement

### Prérequis

- R (version 3.6+)
- Quarto CLI ([télécharger ici](https://quarto.org/docs/get-started/))
- Git

### Générer le site

```bash
# Installer Quarto depuis https://quarto.org/docs/get-started/

# Générer le site web
quarto render

# Le site sera généré dans le dossier 'docs/'
```

### Publier sur GitHub Pages

1. **Créer un dépôt GitHub** pour ce projet

2. **Pousser le code**
```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/VOTRE_USERNAME/projet-ilots-fraicheur.git
git push -u origin main
```

3. **Configurer GitHub Pages**
   - Aller dans `Settings` > `Pages`
   - Source: `Deploy from a branch`
   - Branch: `main` / Folder: `/docs`
   - Cliquer sur `Save`

4. **Accéder au site**
   - URL: `https://VOTRE_USERNAME.github.io/projet-ilots-fraicheur/`

## 📁 Structure du projet

```
projet_ilots_fraicheur/
├── index.qmd                    # Page d'accueil
├── analyse.qmd                  # Analyses statistiques
├── visualisations.qmd           # Cartes et graphiques
├── _quarto.yml                  # Configuration Quarto
├── styles.css                   # Styles personnalisés
├── .nojekyll                    # Pour GitHub Pages
├── scripts/
│   ├── 01_analyse_principale.R  # Script d'analyse de base
│   └── 02_analyse_avancee.R     # Script d'analyse avancée
├── outputs/                     # Graphiques et données
└── docs/                        # Site web généré (auto)
```

## 📊 Données

Source : [Open Data Paris](https://opendata.paris.fr/explore/dataset/ilots-de-fraicheur-equipements-activites/)

- **548 îlots** recensés
- **19 variables** (coordonnées GPS, type, accès, horaires...)
- **20 arrondissements** couverts

## 🛠️ Technologies

- **R** : Analyse statistique et visualisations
- **Quarto** : Publication scientifique et web
- **Plotrix** : Graphiques avancés (radar, 3D, bulles)
- **RColorBrewer** : Palettes de couleurs
- **GitHub Pages** : Hébergement gratuit

## 📝 Auteur

**Naima Rejeb** - Data Science & AI G1

## 📄 Licence

Ce projet est sous licence open source. Les données proviennent de Paris Open Data.

---

🌟 **N'oubliez pas de mettre une étoile si ce projet vous a été utile !**

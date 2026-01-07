# 🌳 Analyse des Îlots de Fraîcheur à Paris

[![Quarto](https://img.shields.io/badge/Quarto-Website-blue)](https://quarto.org)
[![R](https://img.shields.io/badge/R-4.0+-276DC3)](https://www.r-project.org/)
[![GitHub Pages](https://img.shields.io/badge/Live-Demo-green)](https://naimarejeb.github.io/analyse-ilots-fraicheur-paris/)

> 🔗 **Site web** : [https://naimarejeb.github.io/analyse-ilots-fraicheur-paris/](https://naimarejeb.github.io/analyse-ilots-fraicheur-paris/)

## 📊 Description

Projet d'analyse statistique des **548 îlots de fraîcheur** à Paris, réalisé dans le cadre du cours de **Data Science & AI**.

### Objectifs
- 📍 Cartographier les îlots de fraîcheur
- 📈 Analyser leur répartition par arrondissement
- 🏷️ Identifier les types d'équipements les plus fréquents
- 💰 Évaluer l'accessibilité (gratuit vs payant)

## 🎯 Résultats clés

| Indicateur | Valeur |
|------------|--------|
| Nombre total d'îlots | **548** |
| Type le plus fréquent | **Parc ou jardin** |
| Arrondissement top | **20e** |
| Accès gratuit | **~80%** |

## 🚀 Installation

### Prérequis
- R (version 4.0+)
- Quarto CLI ([télécharger](https://quarto.org/docs/get-started/))

### Packages R requis
```r
install.packages(c("plotrix", "RColorBrewer", "MASS"))
```

### Générer le site
```bash
quarto render
```

### Prévisualiser
```bash
quarto preview
```

## 📁 Structure du projet

```
analyse-ilots-fraicheur-paris/
├── 📄 index.qmd              # Page d'accueil
├── 📄 analyse.qmd            # Statistiques descriptives
├── 📄 visualisations.qmd     # Cartes et graphiques
├── ⚙️ _quarto.yml            # Configuration Quarto
├── 🎨 styles.css             # Styles personnalisés
├── 📚 COMPREHENSION.md       # Guide complet du projet
├── scripts/
│   ├── 01_analyse_principale.R
│   └── 02_analyse_avancee.R
├── outputs/                  # Graphiques générés (.png, .csv)
└── docs/                     # Site web généré
```

## 📊 Visualisations générées

| Graphique | Description |
|-----------|-------------|
| 🗺️ Carte des îlots | Position GPS de chaque îlot |
| 🌡️ Carte de densité | Zones de concentration |
| 📊 Barplots | Répartition par type/arrondissement |
| 🕸️ Radar | Distribution des types |
| 🫧 Bulles | Croisement arrondissement × type |
| 🥧 Camembert 3D | Top 10 des types |

## 🛠️ Technologies

| Outil | Usage |
|-------|-------|
| **R** | Analyse statistique |
| **Quarto** | Publication web |
| **plotrix** | Graphiques avancés |
| **RColorBrewer** | Palettes de couleurs |
| **GitHub Pages** | Hébergement |

## 📦 Source des données

[Open Data Paris - Îlots de fraîcheur](https://opendata.paris.fr/explore/dataset/ilots-de-fraicheur-equipements-activites/)

## 👩‍💻 Auteur

**Naima Rejeb**  
Data Science & AI G1 - 2025/2026

## 📄 Licence

Données : [Licence Ouverte / Open Licence](https://www.etalab.gouv.fr/licence-ouverte-open-licence)

---

⭐ *Projet réalisé avec R et Quarto*

🌟 **N'oubliez pas de mettre une étoile si ce projet vous a été utile !**

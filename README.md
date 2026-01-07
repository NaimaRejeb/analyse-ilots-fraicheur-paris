# 🌳 Analyse des Îlots de Fraîcheur à Paris

[![Quarto](https://img.shields.io/badge/Quarto-Website-blue)](https://quarto.org)
[![R](https://img.shields.io/badge/R-4.0+-276DC3)](https://www.r-project.org/)
[![GitHub Pages](https://img.shields.io/badge/Live-Demo-green)](https://naimarejeb.github.io/analyse-ilots-fraicheur-paris/)

> 🔗 **Site web** : [https://naimarejeb.github.io/analyse-ilots-fraicheur-paris/](https://naimarejeb.github.io/analyse-ilots-fraicheur-paris/)

## 📊 Description

Projet d'analyse statistique des **îlots de fraîcheur** à Paris, réalisé dans le cadre du cours de **Data Science & AI**.

### Objectifs
- 🧹 **Prétraiter** et nettoyer les données brutes
- 📍 **Cartographier** les îlots de fraîcheur
- 📈 **Analyser** leur répartition par arrondissement
- 🏷️ **Identifier** les types d'équipements les plus fréquents
- 💰 **Évaluer** l'accessibilité (gratuit vs payant)

## 🎯 Résultats clés

| Indicateur | Valeur |
|------------|--------|
| Données brutes | **548 lignes** |
| Après nettoyage | **520 lignes** |
| Doublons supprimés | **28** |
| Types d'équipements | **12 catégories** |
| Arrondissements couverts | **20** |
| Équipements gratuits | **80%** |
| Points GPS valides | **100%** |

## 🚀 Installation

### Prérequis
- R (version 4.0+)
- Quarto CLI ([télécharger](https://quarto.org/docs/get-started/))

### Packages R requis
```r
install.packages(c("plotrix", "RColorBrewer", "MASS"))
```

### Exécuter le pipeline complet

```bash
# 1. Prétraitement des données
Rscript scripts/00_pretraitement.R

# 2. Analyses statistiques
Rscript scripts/01_analyse_principale.R
Rscript scripts/02_analyse_avancee.R

# 3. Génération des graphiques
Rscript scripts/regenerer_graphiques.R

# 4. Générer le site Quarto
quarto render

# 5. Prévisualiser le site
quarto preview
```

### Exécution rapide (tout en une commande)

```bash
Rscript scripts/00_pretraitement.R; Rscript scripts/regenerer_graphiques.R; quarto render
```

## 📁 Structure du projet

```
analyse-ilots-fraicheur-paris/
├── 📄 index.qmd              # Page d'accueil
├── 📄 analyse.qmd            # Statistiques descriptives
├── 📄 visualisations.qmd     # Cartes et graphiques
├── ⚙️ _quarto.yml            # Configuration Quarto
├── 🎨 styles.css             # Styles personnalisés
├── 📚 README.md              # Documentation du projet
├── scripts/
│   ├── 00_pretraitement.R    # 🆕 Nettoyage et préparation des données
│   ├── 01_analyse_simple.R   # Analyse de base
│   ├── 01_analyse_principale.R # Analyse statistique principale
│   ├── 02_analyse_avancee.R  # Analyses avancées
│   └── regenerer_graphiques.R # Génération des visualisations
├── data/
│   └── donnees_nettoyees.csv # 🆕 Données après prétraitement
├── outputs/                  # Graphiques générés (.png, .csv)
└──🧹 Étapes du prétraitement

| Étape | Description | Résultat |
|-------|-------------|----------|
| 1️⃣ Nettoyage texte | Suppression espaces, conversion vides → NA | ✅ |
| 2️⃣ Doublons | Détection et suppression | 28 supprimés |
| 3️⃣ Coordonnées GPS | Extraction lat/lon + validation Paris | 520 valides |
| 4️⃣ Normalisation | Variables catégorielles standardisées | 12 types |
| 5️⃣ Nouvelles variables | `categorie`, `zone_paris`, `est_payant`... | 8 colonnes |

## 📊 Visualisations générées

| Graphique | Description |
|-----------|-------------|
| 🗺️ Carte des îlots | Position GPS de chaque îlot |
| 🌡️ Carte de densité | Zones de concentration |
| 📊 Barplots | Répartition par type/arrondissement |
| 🕸️ Radar | Distribution des types |
| 🫧 Bulles | Croisement arrondissement × type |
| 🥧 Camembert 3D | Top 10 des types |
| 📈 Cleveland | Comparaison arrondissements |
| 📊 Histogramme empilé | Accessibilité par type>-28 lignes]
    D --> E[Extraction GPS]
    E --> F[Normalisation]
    F --> G[Nouvelles variables]
    G --> H[Données propres<br/>520 lignes]
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

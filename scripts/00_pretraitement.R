# =============================================================================
# PRÉTRAITEMENT DES DONNÉES - ÎLOTS DE FRAÎCHEUR PARIS
# Auteur: Naima Rejeb - Data Science & AI G1
# Ce script nettoie et prépare les données pour l'analyse
# =============================================================================

cat("╔══════════════════════════════════════════════════════════════╗\n")
cat("║       PRÉTRAITEMENT DES DONNÉES - ÎLOTS DE FRAÎCHEUR        ║\n")
cat("╚══════════════════════════════════════════════════════════════╝\n\n")

# =============================================================================
# 1. CHARGEMENT DES DONNÉES BRUTES
# =============================================================================
cat("1. CHARGEMENT DES DONNÉES BRUTES\n")
cat("   ─────────────────────────────\n")

url <- "https://opendata.paris.fr/api/explore/v2.1/catalog/datasets/ilots-de-fraicheur-equipements-activites/exports/csv"
donnees_brutes <- read.csv2(url, encoding = "UTF-8", stringsAsFactors = FALSE)

cat("   ✓ Source: Open Data Paris\n")
cat("   ✓ Lignes chargées:", nrow(donnees_brutes), "\n")
cat("   ✓ Colonnes:", ncol(donnees_brutes), "\n\n")

# Sauvegarder copie des données brutes
donnees <- donnees_brutes

# =============================================================================
# 2. EXPLORATION INITIALE - VALEURS MANQUANTES
# =============================================================================
cat("2. ANALYSE DES VALEURS MANQUANTES\n")
cat("   ───────────────────────────────\n")

# Compter les NA et chaînes vides par colonne
analyse_na <- data.frame(
  Colonne = names(donnees),
  NA_count = sapply(donnees, function(x) sum(is.na(x))),
  Vide_count = sapply(donnees, function(x) sum(x == "", na.rm = TRUE)),
  Pourcentage_manquant = round(sapply(donnees, function(x) {
    (sum(is.na(x)) + sum(x == "", na.rm = TRUE)) / length(x) * 100
  }), 1)
)
analyse_na <- analyse_na[order(-analyse_na$Pourcentage_manquant), ]

cat("   Colonnes avec données manquantes:\n")
print(analyse_na[analyse_na$Pourcentage_manquant > 0, ], row.names = FALSE)
cat("\n")

# =============================================================================
# 3. NETTOYAGE DES CHAÎNES DE CARACTÈRES
# =============================================================================
cat("3. NETTOYAGE DES CHAÎNES DE CARACTÈRES\n")
cat("   ─────────────────────────────────────\n")

# Fonction de nettoyage de texte
nettoyer_texte <- function(x) {
  if (!is.character(x)) return(x)
  x <- trimws(x)                           # Supprimer espaces début/fin
  x <- gsub("\\s+", " ", x)                # Remplacer espaces multiples
  x[x == ""] <- NA                         # Convertir vides en NA
  return(x)
}

# Appliquer à toutes les colonnes texte
colonnes_texte <- c("nom", "type", "adresse", "arrondissement", "payant", 
                    "statut_ouverture", "horaires_periode")
for (col in colonnes_texte) {
  if (col %in% names(donnees)) {
    donnees[[col]] <- nettoyer_texte(donnees[[col]])
  }
}
cat("   ✓ Espaces superflus supprimés\n")
cat("   ✓ Chaînes vides converties en NA\n\n")

# =============================================================================
# 4. TRAITEMENT DES DOUBLONS
# =============================================================================
cat("4. DÉTECTION ET SUPPRESSION DES DOUBLONS\n")
cat("   ───────────────────────────────────────\n")

n_avant <- nrow(donnees)

# Identifier les doublons basés sur nom + adresse + type
donnees$cle_unique <- paste(donnees$nom, donnees$adresse, donnees$type, sep = "|")
doublons <- duplicated(donnees$cle_unique)
n_doublons <- sum(doublons)

if (n_doublons > 0) {
  cat("   ⚠ Doublons détectés:", n_doublons, "\n")
  donnees <- donnees[!doublons, ]
  cat("   ✓ Doublons supprimés\n")
} else {
  cat("   ✓ Aucun doublon détecté\n")
}

donnees$cle_unique <- NULL  # Supprimer colonne temporaire
cat("   Lignes restantes:", nrow(donnees), "\n\n")

# =============================================================================
# 5. EXTRACTION ET VALIDATION DES COORDONNÉES GPS
# =============================================================================
cat("5. EXTRACTION DES COORDONNÉES GPS\n")
cat("   ────────────────────────────────\n")

# Extraire latitude et longitude
if ("geo_point_2d" %in% names(donnees)) {
  coords <- strsplit(as.character(donnees$geo_point_2d), ",")
  donnees$latitude <- as.numeric(sapply(coords, function(x) {
    if (length(x) >= 1) trimws(x[1]) else NA
  }))
  donnees$longitude <- as.numeric(sapply(coords, function(x) {
    if (length(x) >= 2) trimws(x[2]) else NA
  }))
  
  # Validation des coordonnées pour Paris (bornes approximatives)
  lat_min <- 48.80; lat_max <- 48.92
  lon_min <- 2.22; lon_max <- 2.47
  
  coords_invalides <- which(
    donnees$latitude < lat_min | donnees$latitude > lat_max |
    donnees$longitude < lon_min | donnees$longitude > lon_max
  )
  
  if (length(coords_invalides) > 0) {
    cat("   ⚠ Coordonnées hors Paris:", length(coords_invalides), "\n")
    donnees$latitude[coords_invalides] <- NA
    donnees$longitude[coords_invalides] <- NA
  }
  
  n_gps_valides <- sum(!is.na(donnees$latitude) & !is.na(donnees$longitude))
  cat("   ✓ Latitude extraite\n")
  cat("   ✓ Longitude extraite\n")
  cat("   ✓ Points GPS valides:", n_gps_valides, "/", nrow(donnees), "\n\n")
}

# =============================================================================
# 6. NORMALISATION DES VARIABLES CATÉGORIELLES
# =============================================================================
cat("6. NORMALISATION DES VARIABLES CATÉGORIELLES\n")
cat("   ──────────────────────────────────────────\n")

# 6.1 Normaliser la colonne "payant"
if ("payant" %in% names(donnees)) {
  donnees$payant_original <- donnees$payant
  donnees$payant <- tolower(donnees$payant)
  donnees$payant <- ifelse(donnees$payant %in% c("oui", "yes", "1", "true"), "Oui",
                    ifelse(donnees$payant %in% c("non", "no", "0", "false"), "Non", NA))
  
  # Créer variable binaire
  donnees$est_payant <- ifelse(donnees$payant == "Oui", TRUE, FALSE)
  cat("   ✓ Variable 'payant' normalisée (Oui/Non)\n")
  cat("   ✓ Variable binaire 'est_payant' créée\n")
}

# 6.2 Normaliser les types d'équipements
if ("type" %in% names(donnees)) {
  donnees$type <- tools::toTitleCase(tolower(donnees$type))
  types_uniques <- length(unique(na.omit(donnees$type)))
  cat("   ✓ Variable 'type' normalisée (", types_uniques, "catégories)\n")
}

# 6.3 Normaliser les arrondissements
if ("arrondissement" %in% names(donnees)) {
  # Extraire le numéro d'arrondissement (1 à 20)
  donnees$num_arrondissement <- as.integer(gsub("750", "", donnees$arrondissement))
  
  # Créer des groupes géographiques
  donnees$zone_paris <- cut(donnees$num_arrondissement,
                            breaks = c(0, 4, 8, 12, 16, 20),
                            labels = c("Centre (1-4)", "Ouest (5-8)", 
                                      "Sud (9-12)", "Sud-Ouest (13-16)", 
                                      "Nord-Est (17-20)"),
                            include.lowest = TRUE)
  cat("   ✓ Numéro d'arrondissement extrait\n")
  cat("   ✓ Zones géographiques créées\n")
}
cat("\n")

# =============================================================================
# 7. CRÉATION DE NOUVELLES VARIABLES
# =============================================================================
cat("7. CRÉATION DE NOUVELLES VARIABLES\n")
cat("   ─────────────────────────────────\n")

# Fonction de catégorisation des types
categoriser_type <- function(type) {
  categorie <- rep("Autre", length(type))
  categorie[grepl("piscine|baignade|bain", type, ignore.case = TRUE)] <- "Aquatique"
  categorie[grepl("brumisateur|fontaine", type, ignore.case = TRUE)] <- "Rafraîchissement"
  categorie[grepl("musée|bibliothèque|culte", type, ignore.case = TRUE)] <- "Bâtiment climatisé"
  categorie[grepl("ombrière|ombre", type, ignore.case = TRUE)] <- "Ombrage"
  categorie[grepl("parc|jardin|square|terrain", type, ignore.case = TRUE)] <- "Espace vert"
  categorie[grepl("mairie|découverte", type, ignore.case = TRUE)] <- "Service public"
  return(categorie)
}

# Appliquer la catégorisation
if ("type" %in% names(donnees)) {
  donnees$categorie <- categoriser_type(donnees$type)
  cat("   ✓ Variable 'categorie' créée (regroupement des types)\n")
  print(table(donnees$categorie))
}

# 7.2 Variable pour analyse temporelle des horaires
if ("statut_ouverture" %in% names(donnees)) {
  donnees$est_ouvert <- grepl("ouvert", donnees$statut_ouverture, ignore.case = TRUE)
  cat("   ✓ Variable 'est_ouvert' créée\n")
}

cat("\n")

# =============================================================================
# 8. RÉSUMÉ DU PRÉTRAITEMENT
# =============================================================================
cat("8. RÉSUMÉ DU PRÉTRAITEMENT\n")
cat("   ────────────────────────\n")

resume <- data.frame(
  Metrique = c(
    "Lignes initiales",
    "Lignes après nettoyage",
    "Doublons supprimés",
    "Points GPS valides",
    "Types d'équipements",
    "Arrondissements couverts",
    "Équipements gratuits",
    "Équipements payants"
  ),
  Valeur = c(
    nrow(donnees_brutes),
    nrow(donnees),
    n_doublons,
    sum(!is.na(donnees$latitude)),
    length(unique(na.omit(donnees$type))),
    length(unique(na.omit(donnees$arrondissement))),
    sum(donnees$payant == "Non", na.rm = TRUE),
    sum(donnees$payant == "Oui", na.rm = TRUE)
  )
)
print(resume, row.names = FALSE)

# =============================================================================
# 9. EXPORT DES DONNÉES NETTOYÉES
# =============================================================================
cat("\n9. EXPORT DES DONNÉES\n")
cat("   ────────────────────\n")

# Créer dossier si nécessaire
if (!dir.exists("outputs")) dir.create("outputs")
if (!dir.exists("data")) dir.create("data")

# Sauvegarder les données nettoyées
write.csv(donnees, "data/donnees_nettoyees.csv", row.names = FALSE, fileEncoding = "UTF-8")
cat("   ✓ data/donnees_nettoyees.csv\n")

# Sauvegarder le résumé du prétraitement
write.csv(resume, "outputs/resume_pretraitement.csv", row.names = FALSE)
cat("   ✓ outputs/resume_pretraitement.csv\n")

# Sauvegarder l'analyse des NA
write.csv(analyse_na, "outputs/analyse_valeurs_manquantes.csv", row.names = FALSE)
cat("   ✓ outputs/analyse_valeurs_manquantes.csv\n")

cat("\n╔══════════════════════════════════════════════════════════════╗\n")
cat("║              PRÉTRAITEMENT TERMINÉ AVEC SUCCÈS               ║\n")
cat("╚══════════════════════════════════════════════════════════════╝\n")

# Afficher la structure finale
cat("\nStructure des données nettoyées:\n")
str(donnees)

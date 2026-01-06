# =============================================================================
# PROJET R: ANALYSE DES ÎLOTS DE FRAÎCHEUR DE PARIS
# Auteur: Naima Rejeb - Data Science & AI G1
# Version simplifiée utilisant les fonctions de base R
# =============================================================================

# 1. IMPORTATION DES DONNÉES -----------------------------------------------
# URL du dataset Open Data Paris
url <- "https://opendata.paris.fr/api/explore/v2.1/catalog/datasets/ilots-de-fraicheur-equipements-activites/exports/csv"

# Import des donnees
cat("Telechargement des donnees...\n")
donnees <- read.csv2(url, encoding = "UTF-8", stringsAsFactors = FALSE)

# Apercu des donnees
cat("\n=== APERCU DES DONNEES ===\n")
cat("Nombre de lignes:", nrow(donnees), "\n")
cat("Nombre de colonnes:", ncol(donnees), "\n")
cat("\nNoms des colonnes:\n")
print(names(donnees))

# 2. STATISTIQUES DESCRIPTIVES ---------------------------------------------

cat("\n=== STATISTIQUES DESCRIPTIVES ===\n\n")

# 2.1 Repartition par type d'equipement
cat("--- Repartition par type d'equipement ---\n")
if ("type" %in% names(donnees)) {
  type_table <- table(donnees$type)
  type_df <- data.frame(
    Type = names(type_table),
    Nombre = as.numeric(type_table),
    Pourcentage = round(as.numeric(type_table) / sum(type_table) * 100, 1)
  )
  type_df <- type_df[order(-type_df$Nombre), ]
  print(type_df)
}

# 2.2 Repartition par arrondissement
cat("\n--- Repartition par arrondissement ---\n")
if ("arrondissement" %in% names(donnees)) {
  arrd_table <- table(donnees$arrondissement)
  arrd_df <- data.frame(
    Arrondissement = names(arrd_table),
    Nombre = as.numeric(arrd_table),
    Pourcentage = round(as.numeric(arrd_table) / sum(arrd_table) * 100, 1)
  )
  arrd_df <- arrd_df[order(-arrd_df$Nombre), ]
  print(arrd_df)
}

# 2.3 Acces payant vs gratuit
cat("\n--- Equipements payants vs gratuits ---\n")
if ("payant" %in% names(donnees)) {
  payant_table <- table(donnees$payant)
  payant_df <- data.frame(
    Acces = names(payant_table),
    Nombre = as.numeric(payant_table),
    Pourcentage = round(as.numeric(payant_table) / sum(payant_table) * 100, 1)
  )
  print(payant_df)
}

# 3. VISUALISATIONS --------------------------------------------------------

# 3.1 Graphique en barres: Top 10 types d'equipements
if ("type" %in% names(donnees)) {
  type_table_sorted <- sort(table(donnees$type), decreasing = TRUE)
  top10 <- head(type_table_sorted, 10)
  
  par(mar = c(5, 12, 4, 2))
  barplot(top10, 
          horiz = TRUE, 
          las = 1,
          main = "Top 10 des types d'equipements\nIlots de fraicheur - Paris",
          xlab = "Nombre d'equipements",
          col = rainbow(10))
  par(mar = c(5, 4, 4, 2))  # Reset margins
}

# 3.2 Graphique en barres: Repartition par arrondissement
if ("arrondissement" %in% names(donnees)) {
  arrd_table <- table(donnees$arrondissement)
  arrd_table_sorted <- sort(arrd_table, decreasing = TRUE)
  
  barplot(arrd_table_sorted, 
          main = "Nombre d'ilots de fraicheur par arrondissement",
          xlab = "Arrondissement",
          ylab = "Nombre d'ilots",
          col = "steelblue",
          las = 2)
}

# 3.3 Graphique circulaire: Payant vs Gratuit
if ("payant" %in% names(donnees)) {
  payant_table <- table(donnees$payant)
  colors <- c("#2ecc71", "#e74c3c")  # Vert et Rouge
  pie(payant_table, 
      main = "Accessibilite des ilots de fraicheur",
      col = colors,
      labels = paste(names(payant_table), "\n", payant_table, " (", 
                    round(payant_table/sum(payant_table)*100, 1), "%)", sep=""))
}

# 4. EXPORT DES RÉSULTATS --------------------------------------------------

# Sauvegarder les résultats
if (exists("type_df")) {
  write.csv(type_df, "outputs/repartition_types.csv", row.names = FALSE)
  cat("\n[OK] Fichier 'outputs/repartition_types.csv' cree\n")
}

if (exists("arrd_df")) {
  write.csv(arrd_df, "outputs/repartition_arrondissements.csv", row.names = FALSE)
  cat("[OK] Fichier 'outputs/repartition_arrondissements.csv' cree\n")
}

if (exists("payant_df")) {
  write.csv(payant_df, "outputs/repartition_acces.csv", row.names = FALSE)
  cat("[OK] Fichier 'outputs/repartition_acces.csv' cree\n")
}

cat("\n=== ANALYSE TERMINEE ===\n")
cat("Les fichiers CSV ont ete exportes.\n")
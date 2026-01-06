# =============================================================================
# PROJET R: ANALYSE SIMPLIFIÉE DES ÎLOTS DE FRAÎCHEUR DE PARIS
# Version utilisant uniquement les fonctions de base R (sans packages externes)
# =============================================================================

# 1. IMPORTATION DES DONNÉES -----------------------------------------------
# URL du dataset Open Data Paris
url <- "https://opendata.paris.fr/api/explore/v2.1/catalog/datasets/ilots-de-fraicheur-equipements-activites/exports/csv"

# Import des données
cat("Téléchargement des données...\n")
donnees <- read.csv2(url, encoding = "UTF-8", stringsAsFactors = FALSE)

# Aperçu des données
cat("\n=== APERÇU DES DONNÉES ===\n")
cat("Nombre de lignes:", nrow(donnees), "\n")
cat("Nombre de colonnes:", ncol(donnees), "\n")
cat("\nNoms des colonnes:\n")
print(names(donnees))

# 2. STATISTIQUES DESCRIPTIVES ---------------------------------------------

cat("\n=== STATISTIQUES DESCRIPTIVES ===\n\n")

# 2.1 Répartition par type d'équipement
cat("--- Répartition par type d'équipement ---\n")
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

# 2.2 Répartition par arrondissement
cat("\n--- Répartition par arrondissement ---\n")
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

# 2.3 Accès payant vs gratuit
cat("\n--- Équipements payants vs gratuits ---\n")
if ("payant" %in% names(donnees)) {
  payant_table <- table(donnees$payant)
  payant_df <- data.frame(
    Acces = names(payant_table),
    Nombre = as.numeric(payant_table),
    Pourcentage = round(as.numeric(payant_table) / sum(payant_table) * 100, 1)
  )
  print(payant_df)
}

# 3. GRAPHIQUES SIMPLES AVEC FONCTIONS DE BASE ----------------------------

# 3.1 Graphique en barres: Top 10 types d'équipements
if ("type" %in% names(donnees)) {
  type_table_sorted <- sort(table(donnees$type), decreasing = TRUE)
  top10 <- head(type_table_sorted, 10)
  
  par(mar = c(5, 12, 4, 2))
  barplot(top10, 
          horiz = TRUE, 
          las = 1,
          main = "Top 10 des types d'équipements\nÎlots de fraîcheur - Paris",
          xlab = "Nombre d'équipements",
          col = rainbow(10))
  par(mar = c(5, 4, 4, 2))  # Reset margins
}

# 3.2 Graphique en barres: Répartition par arrondissement
if ("arrondissement" %in% names(donnees)) {
  arrd_table <- table(donnees$arrondissement)
  arrd_table_sorted <- sort(arrd_table, decreasing = TRUE)
  
  barplot(arrd_table_sorted, 
          main = "Nombre d'îlots de fraîcheur par arrondissement",
          xlab = "Arrondissement",
          ylab = "Nombre d'îlots",
          col = "steelblue",
          las = 2)
}

# 3.3 Graphique circulaire: Payant vs Gratuit
if ("payant" %in% names(donnees)) {
  payant_table <- table(donnees$payant)
  colors <- c("#2ecc71", "#e74c3c")  # Vert et Rouge
  pie(payant_table, 
      main = "Accessibilité des îlots de fraîcheur",
      col = colors,
      labels = paste(names(payant_table), "\n", payant_table, " (", 
                    round(payant_table/sum(payant_table)*100, 1), "%)", sep=""))
}

# 4. EXPORT DES RÉSULTATS --------------------------------------------------

# Sauvegarder les résultats
if (exists("type_df")) {
  write.csv(type_df, "outputs/repartition_types.csv", row.names = FALSE)
  cat("\n✓ Fichier 'outputs/repartition_types.csv' créé\n")
}

if (exists("arrd_df")) {
  write.csv(arrd_df, "outputs/repartition_arrondissements.csv", row.names = FALSE)
  cat("✓ Fichier 'outputs/repartition_arrondissements.csv' créé\n")
}

if (exists("payant_df")) {
  write.csv(payant_df, "outputs/repartition_acces.csv", row.names = FALSE)
  cat("✓ Fichier 'outputs/repartition_acces.csv' créé\n")
}

cat("\n=== ANALYSE TERMINÉE ===\n")
cat("Les graphiques devraient apparaître dans la fenêtre de visualisation R.\n")
cat("Les fichiers CSV ont été exportés dans le répertoire de travail.\n")

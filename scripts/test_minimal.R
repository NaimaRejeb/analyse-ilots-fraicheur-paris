# Test minimal pour graphiques sans accents
# Encodage UTF-8

cat("Debut du script de test\n")

# Creer le dossier outputs s'il n'existe pas
if (!dir.exists("outputs")) {
  dir.create("outputs")
  cat("Dossier outputs cree\n")
}

# Test 1: Graphique basique
cat("\n1. Creation graphique simple...\n")
png("outputs/test1_simple.png", width=800, height=600)
plot(1:10, 1:10, 
     main="Test Simple - Sans Accents",
     xlab="Axe X",
     ylab="Axe Y",
     type="b", col="blue", pch=19)
dev.off()
cat("   [OK] test1_simple.png\n")

# Test 2: Barplot avec texte
cat("\n2. Creation barplot...\n")
png("outputs/test2_barplot.png", width=800, height=600)
donnees_test <- c(45, 32, 28, 22, 19)
noms_test <- c("Premier", "Deuxieme", "Troisieme", "Quatrieme", "Cinquieme")

barplot(donnees_test,
        names.arg=noms_test,
        main="Repartition Test",
        xlab="Categories",
        ylab="Valeurs",
        col="steelblue")
dev.off()
cat("   [OK] test2_barplot.png\n")

# Test 3: Texte avec variables
cat("\n3. Creation graphique avec texte dynamique...\n")
png("outputs/test3_dynamique.png", width=800, height=600)
nb_ilots <- 548
plot(1:5, 1:5, type="n",
     main=paste("Analyse de", nb_ilots, "ilots"),
     xlab="Position",
     ylab="Quantite")
text(3, 3, paste(nb_ilots, "ilots de fraicheur"), cex=1.5, col="darkblue")
dev.off()
cat("   [OK] test3_dynamique.png\n")

cat("\n=== TESTS TERMINES ===\n")
cat("Verifiez les fichiers dans outputs/\n")

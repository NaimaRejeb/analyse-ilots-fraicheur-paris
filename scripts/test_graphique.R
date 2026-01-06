# Script de test pour verifier les graphiques sans accents

# Test 1: Graphique simple
png("outputs/test_graphique.png", width=800, height=600, res=100)

# Donnees de test
valeurs <- c(45, 32, 28, 22, 19)
noms <- c("20e arr.", "12e arr.", "19e arr.", "18e arr.", "15e arr.")

# Graphique sans aucun accent
barplot(valeurs,
        names.arg = noms,
        main = "Test: Nombre d'ilots par arrondissement",
        xlab = "Arrondissement",
        ylab = "Nombre d'ilots",
        col = "steelblue",
        las = 2)

dev.off()

cat("[OK] Graphique de test cree: outputs/test_graphique.png\n")
cat("Verifiez que les textes s'affichent correctement!\n")

# Script simplifie pour regenerer UNIQUEMENT les graphiques

cat("=== REGENERATION DES GRAPHIQUES ===\n\n")

# Charger les packages
suppressMessages({
  library(plotrix)
  library(RColorBrewer)
})

# 1. Charger les donnees
cat("1. Chargement des donnees...\n")
url <- "https://opendata.paris.fr/api/explore/v2.1/catalog/datasets/ilots-de-fraicheur-equipements-activites/exports/csv"
donnees <- read.csv2(url, encoding = "UTF-8", stringsAsFactors = FALSE)
cat("   [OK]", nrow(donnees), "lignes chargees\n\n")

# 2. Extraire coordonnees
cat("2. Extraction coordonnees GPS...\n")
coords <- strsplit(donnees$geo_point_2d, ",")
donnees$latitude <- as.numeric(sapply(coords, function(x) if(length(x) >= 1) trimws(x[1]) else NA))
donnees$longitude <- as.numeric(sapply(coords, function(x) if(length(x) >= 2) trimws(x[2]) else NA))
donnees_geo <- donnees[!is.na(donnees$latitude) & !is.na(donnees$longitude), ]
cat("   [OK]", nrow(donnees_geo), "points GPS valides\n\n")

# 3. CARTE 1
cat("3. Carte des ilots...\n")
types_uniques <- unique(donnees_geo$type)
types_uniques <- types_uniques[types_uniques != ""]
couleurs_types <- brewer.pal(min(12, length(types_uniques)), "Set3")
if(length(types_uniques) > 12) {
  couleurs_types <- colorRampPalette(brewer.pal(12, "Set3"))(length(types_uniques))
}
names(couleurs_types) <- types_uniques
donnees_geo$couleur <- couleurs_types[match(donnees_geo$type, types_uniques)]
donnees_geo$couleur[is.na(donnees_geo$couleur)] <- "gray"

png("outputs/carte_ilots_fraicheur.png", width=1200, height=1000, res=120)
par(mar=c(5,5,4,2))
plot(donnees_geo$longitude, donnees_geo$latitude,
     pch=19, cex=1.2, col=donnees_geo$couleur,
     main="Carte des Ilots de Fraicheur a Paris",
     xlab="Longitude", ylab="Latitude",
     las=1, cex.main=1.5, cex.lab=1.2)
grid(col="gray80", lty=2)
legend("topright", legend=head(types_uniques, 8), 
       col=head(couleurs_types, 8), pch=19, cex=0.8, bg="white")
dev.off()
cat("   [OK] carte_ilots_fraicheur.png\n\n")

# 4. CARTE 2
cat("4. Carte de densite...\n")
png("outputs/carte_densite.png", width=1200, height=1000, res=120)
par(mar=c(5,5,4,2))
densite <- MASS::kde2d(donnees_geo$longitude, donnees_geo$latitude, n=100)
image(densite, col=rev(heat.colors(20)),
      main="Carte de Densite des Ilots de Fraicheur",
      xlab="Longitude", ylab="Latitude",
      cex.main=1.5, cex.lab=1.2)
contour(densite, add=TRUE, col="blue", lwd=1.5)
points(donnees_geo$longitude, donnees_geo$latitude, pch=20, cex=0.3, col="black")
dev.off()
cat("   [OK] carte_densite.png\n\n")

# 5. PYRAMIDE
cat("5. Pyramide arrondissements...\n")
png("outputs/pyramide_arrondissements.png", width=1400, height=1000, res=120)
arrd_stats <- table(donnees$arrondissement)
arrd_df <- data.frame(arrondissement = names(arrd_stats), total = as.numeric(arrd_stats))
arrd_df <- arrd_df[order(-arrd_df$total), ]
par(mar=c(5,8,4,2))
barplot(arrd_df$total, names.arg=arrd_df$arrondissement, horiz=TRUE, las=1,
        col=colorRampPalette(c("lightblue", "darkblue"))(nrow(arrd_df)), border=NA,
        main="Repartition des Ilots de Fraicheur par Arrondissement",
        xlab="Nombre d'ilots", cex.main=1.5, cex.lab=1.2, cex.names=0.9)
grid(nx=NA, ny=NULL, col="white", lwd=1.5)
dev.off()
cat("   [OK] pyramide_arrondissements.png\n\n")

# 6. RADAR
cat("6. Graphique radar...\n")
png("outputs/radar_types.png", width=1000, height=1000, res=120)
type_stats <- sort(table(donnees$type), decreasing=TRUE)[1:min(8, length(table(donnees$type)))]
radial.plot(as.numeric(type_stats), labels=names(type_stats), rp.type="p",
            main="Distribution des Types d'Equipements (Top 8)",
            line.col="darkblue", lwd=3, poly.col=rgb(0, 0, 1, 0.3),
            show.grid.labels=3, radial.lim=c(0, max(type_stats)*1.1), cex.main=1.5)
dev.off()
cat("   [OK] radar_types.png\n\n")

# 7. PIE 3D
cat("7. Camembert 3D...\n")
png("outputs/pie3d_types.png", width=1200, height=900, res=120)
type_top10 <- sort(table(donnees$type), decreasing=TRUE)[1:10]
pie3D(as.numeric(type_top10),
      labels=paste(names(type_top10), "\n", round(type_top10/sum(type_top10)*100, 1), "%"),
      col=brewer.pal(10, "Spectral"),
      main="Top 10 des Types d'Equipements (3D)",
      labelcex=0.9, explode=0.1, cex.main=1.5)
dev.off()
cat("   [OK] pie3d_types.png\n\n")

# 8. BUBBLES
cat("8. Graphique a bulles...\n")
png("outputs/bubble_arrd_type.png", width=1400, height=1000, res=120)
top_arrd <- head(names(sort(table(donnees$arrondissement), decreasing=TRUE)), 5)
top_types <- head(names(sort(table(donnees$type), decreasing=TRUE)), 5)
matrice_bubble <- matrix(0, nrow=length(top_arrd), ncol=length(top_types))
rownames(matrice_bubble) <- top_arrd
colnames(matrice_bubble) <- top_types
for(i in 1:nrow(donnees)) {
  if(donnees$arrondissement[i] %in% top_arrd && donnees$type[i] %in% top_types) {
    r <- which(top_arrd == donnees$arrondissement[i])
    c <- which(top_types == donnees$type[i])
    matrice_bubble[r, c] <- matrice_bubble[r, c] + 1
  }
}
par(mar=c(8,8,4,2))
plot(0, 0, type="n", xlim=c(0.5, length(top_types)+0.5), ylim=c(0.5, length(top_arrd)+0.5),
     xlab="", ylab="", xaxt="n", yaxt="n",
     main="Analyse Croisee: Arrondissement x Type d'Equipement", cex.main=1.5)
axis(1, at=1:length(top_types), labels=top_types, las=2, cex.axis=0.9)
axis(2, at=1:length(top_arrd), labels=top_arrd, las=1, cex.axis=0.9)
for(i in 1:nrow(matrice_bubble)) {
  for(j in 1:ncol(matrice_bubble)) {
    if(matrice_bubble[i,j] > 0) {
      taille <- sqrt(matrice_bubble[i,j]) * 0.5
      couleur <- colorRampPalette(c("yellow", "red"))(max(matrice_bubble)+1)[matrice_bubble[i,j]+1]
      draw.circle(j, i, radius=taille, col=couleur, border="black", lwd=1.5)
      text(j, i, matrice_bubble[i,j], cex=0.8, font=2)
    }
  }
}
dev.off()
cat("   [OK] bubble_arrd_type.png\n\n")

# 9. STACKED
cat("9. Histogramme empile...\n")
png("outputs/stacked_payant_type.png", width=1400, height=900, res=120)
top8_types <- head(names(sort(table(donnees$type), decreasing=TRUE)), 8)
donnees_top8 <- donnees[donnees$type %in% top8_types, ]
matrice_stack <- table(donnees_top8$type, donnees_top8$payant)
par(mar=c(8,5,4,8))
barplot(t(matrice_stack), beside=FALSE, col=c("gray80", "#2ecc71", "#e74c3c"),
        main="Accessibilite par Type d'Equipement (Top 8)",
        xlab="", ylab="Nombre d'equipements",
        las=2, cex.main=1.5, cex.lab=1.2, border=NA)
legend("topright", inset=c(-0.15, 0), xpd=TRUE,
       legend=c("Non renseigne", "Gratuit", "Payant"),
       fill=c("gray80", "#2ecc71", "#e74c3c"), cex=1.1, title="Acces")
dev.off()
cat("   [OK] stacked_payant_type.png\n\n")

# 10. CLEVELAND
cat("10. Diagramme Cleveland...\n")
png("outputs/cleveland_arrondissements.png", width=1200, height=1000, res=120)
arrd_sorted <- sort(table(donnees$arrondissement))
par(mar=c(5,8,4,2))
dotchart(as.numeric(arrd_sorted), labels=names(arrd_sorted),
         col=colorRampPalette(c("lightblue", "darkblue"))(length(arrd_sorted)),
         pch=19, cex=1.5,
         main="Comparaison des Arrondissements (Diagramme de Cleveland)",
         xlab="Nombre d'ilots de fraicheur",
         cex.main=1.5, cex.lab=1.2)
grid(nx=NULL, ny=NA, col="gray80")
dev.off()
cat("   [OK] cleveland_arrondissements.png\n\n")

cat("\n=== TERMINE: 10 graphiques crees ===\n")

library(tidyverse)  # data manipulation
library(cluster)    # clustering algorithms
library(factoextra) # clustering visualization
library(dendextend)
library(philentropy)



df<-read.csv("~/Documents/GitHub/fraudulent_transactions/datasets/scaled_data.csv")
head(df)

str(df)
df <- na.omit(df)


cols <- select(df, -1)

dist_mat <- dist(t(cols))
hc <- hclust(dist_mat,method = "complete")

# Plot the dendrogram
fviz_dend(hc, k = NULL, cex = 0.6, k_colors = NULL, rect = TRUE, horiz = FALSE)


# methods to assess
m <- c( "average", "single", "complete", "ward")
names(m) <- c( "average", "single", "complete", "ward")

# function to compute coefficient
ac <- function(x) {
  agnes((t(cols)), method = x)$ac
}

map_dbl(m, ac)

hc3 <- agnes((t(cols)), method = "ward")
pltree(hc3, cex = 0.6, hang = -1, main = "Dendrogram of agnes") 




# Ward's method
hc5 <- hclust(dist_mat, method = "ward.D2" )

# Cut tree into 4 groups
sub_grp <- cutree(hc5, k = 3)

table(sub_grp)

plot(hc5, cex = 0.6)
rect.hclust(hc5, k = 4, border = 2:5)


fviz_cluster(list(data = (t(cols)), cluster = sub_grp))


dist_mat_cos <- distance(as.matrix(t(cols)),method="cosine")
true_dist_mat <- as.dist(dist_mat_cos)
hc_cos <- hclust(true_dist_mat,method = "ward.D")




fviz_dend(hc_cos, k = NULL, cex = 0.6, k_colors = NULL, rect = TRUE, horiz = TRUE)



t<-as.matrix(t(cols))

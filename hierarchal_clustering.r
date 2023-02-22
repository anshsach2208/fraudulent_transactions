library(tidyverse)  # data manipulation
library(cluster)    # clustering algorithms
library(factoextra) # clustering visualization
library(dendextend)



df<-read.csv("~/Documents/GitHub/fraudulent_transactions/datasets/scaled_data.csv")
head(df)
str(df)

df <- na.omit(df)
str(df)

# Dissimilarity matrix
d <- dist(df, method = "euclidean")

# Hierarchical clustering using Complete Linkage
hc1 <- hclust(d, method = "complete" )

# Plot the obtained dendrogram
plot(hc1, cex = 0.6, hang = -1)

# Compute with agnes
hc2 <- agnes(df, method = "complete")

# Agglomerative coefficient
print(hc2$ac)

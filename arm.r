install.packages("arules")
install.packages("TSP")
install.packages("data.table")
install.packages("arulesViz")
install.packages("sp")

install.packages("dplyr", dependencies = TRUE)
install.packages("purrr", dependencies = TRUE)
install.packages("devtools", dependencies = TRUE)
install.packages("tidyr")
library(viridis)
library(arules)
library(TSP)
library(data.table)

library(tcltk)
library(dplyr)
library(devtools)
library(purrr)
library(tidyr)
#install_github("mhahsler/arulesViz")
## RE: https://github.com/mhahsler/arulesViz


## DO THIS: 
## (1) detach("package:arulesViz", unload=TRUE)
## (2) detach("package:arules", unload=TRUE)
#library(arules)
library(arulesViz)
###################################################################

## To see if you have tcltk run this on the console...
# capabilities()["tcltk"]
#library(arulesViz)


fraud_trans <- read.transactions("~/Documents/GitHub/fraudulent_transactions/Cleaned Dataset/cleaned_text_data.csv",
                                rm.duplicates = FALSE, 
                                format = "basket",  ##if you use "single" also use cols=c(1,2)
                                sep=",",  ## csv file
                                cols=1) ## The dataset HAS row numbers
inspect(fraud_trans)

##### Use apriori to get the RULES
FrulesK = arules::apriori(fraud_trans, parameter = list(support=.03, 
                                                       confidence=.5, minlen=2))
inspect(FrulesK)

## Plot of which items are most frequent
itemFrequencyPlot(fraud_trans, topN=20, type="absolute")

## Sort rules by a measure such as conf, sup, or lift
SortedRulesK <- sort(FrulesK, by="confidence", decreasing=TRUE)
inspect(SortedRulesK)
(summary(SortedRulesK))

SortedRulesL <- sort(FrulesK, by="lift", decreasing=TRUE)
inspect(SortedRulesL)
(summary(SortedRulesL))

SortedRulesS <- sort(FrulesK, by="support", decreasing=TRUE)
inspect(SortedRulesS)
(summary(SortedRulesS))


## Visualize
## tcltk

subrulesK <- head(sort(SortedRulesK, by="confidence"),15)
plot(subrulesK)

subrulesL <- head(sort(SortedRulesL, by="lift"),15)
plot(subrulesL)

subrulesS <- head(sort(SortedRulesS, by="support"),15)
plot(subrulesS)

plot(subrulesK, method="graph", engine="htmlwidget")
plot(subrulesL, method="graph", engine="htmlwidget")
plot(subrulesS, method="graph", engine="htmlwidget")

## Visualize
## tcltk

subrules <- head(sort(SortedRulesK, by="confidence"),15)
plot(subrules)

#plot(subrules, method="graph", engine="interactive")
plot(subrules, method="graph", engine="htmlwidget")

purchase_items <- read.transactions("~/Documents/GitHub/fraudulent_transactions/Cleaned Dataset/transaction_data_arm.csv",
                                 rm.duplicates = FALSE,
                                 format = "basket",  ##if you use "single" also use cols=c(1,2)
                                 sep=",",  ## csv file
                                 cols=1) ## The dataset HAS row numbers
inspect(purchase_items)


itemFrequencyPlot(purchase_items, topN=20, type="absolute")



ArulesK = arules::apriori(purchase_items, parameter = list(support=.0005, 
                                                        confidence=.03, minlen=2))
inspect(ArulesK)

SortedRulesK <- sort(ArulesK, by="confidence", decreasing=TRUE)
inspect(SortedRulesK)
(summary(SortedRulesK))


SortedRulesL <- sort(ArulesK, by="lift", decreasing=TRUE)
inspect(SortedRulesL)
(summary(SortedRulesL))

SortedRulesS <- sort(ArulesK, by="support", decreasing=TRUE)
inspect(SortedRulesS)
(summary(SortedRulesS))


## Visualize
## tcltk

subrulesK <- head(sort(SortedRulesK, by="confidence"),15)
plot(subrulesK)

subrulesL <- head(sort(SortedRulesL, by="lift"),15)
plot(subrulesL)

subrulesS <- head(sort(SortedRulesS, by="support"),15)
plot(subrulesS)

plot(subrulesK, method="graph", engine="htmlwidget")
plot(subrulesL, method="graph", engine="htmlwidget")
plot(subrulesS, method="graph", engine="htmlwidget")

subrulesK <- head(sort(SortedRulesK, by="confidence"),15)
plot(subrulesK)

plot(subrulesK, method="graph", engine="htmlwidget")

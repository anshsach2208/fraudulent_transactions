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

##############
## IF YOUR CODE BREAKS - TRY THIS
##
## Error in length(obj) : Method length not implemented for class rules 
## DO THIS: 
## (1) detach("package:arulesViz", unload=TRUE)
## (2) detach("package:arules", unload=TRUE)
#library(arules)
library(arulesViz)
###################################################################

## To see if you have tcltk run this on the console...
# capabilities()["tcltk"]
#library(arulesViz)


## YOUR working dir goes here...

#df<-read.csv("~/Documents/GitHub/fraudulent_transactions/datasets/cleaned_text_data.csv")


fraud_trans <- read.transactions("~/Documents/GitHub/fraudulent_transactions/Cleaned Dataset/cleaned_text_data.csv",
                                rm.duplicates = FALSE, 
                                format = "basket",  ##if you use "single" also use cols=c(1,2)
                                sep=",",  ## csv file
                                cols=1) ## The dataset HAS row numbers
inspect(fraud_trans)

##### Use apriori to get the RULES
FrulesK = arules::apriori(fraud_trans, parameter = list(support=.05, 
                                                       confidence=.1, minlen=2))
inspect(FrulesK)

## Plot of which items are most frequent
itemFrequencyPlot(fraud_trans, topN=20, type="absolute")

## Sort rules by a measure such as conf, sup, or lift
SortedRulesK <- sort(FrulesK, by="confidence", decreasing=TRUE)
inspect(SortedRulesK)
(summary(SortedRulesK))


## Visualize
## tcltk

subrulesK <- head(sort(SortedRulesK, by="lift"),10)
plot(subrulesK)

plot(subrulesK, method="graph", engine="interactive")

## Visualize
## tcltk

subrules <- head(sort(SortedRulesK, by="lift"),15)
plot(subrules)

#plot(subrules, method="graph", engine="interactive")
plot(subrules, method="graph", engine="htmlwidget")

# BeerRules <- apriori(data=FoodsKumar,parameter = list(supp=.001, conf=.01, minlen=2),
#                      appearance = list(default="lhs", rhs="Beer"),
#                      control=list(verbose=FALSE))
# BeerRules <- sort(BeerRules, decreasing=TRUE, by="confidence")
# inspect(BeerRules[1:4])


library (dplyr)
library(tidyr)
table <- read.csv("tabula-Expenditure Budget Volume 2 (Part I)_0.csv", header = TRUE,na="")
table_1 <- read.csv("tabula-Expenditure Budget Volume 2 (Part II)_0 (1).csv", header = FALSE, na = "")

tripura_budget_cuts <- function(x,y)
    {
  x[1] <- as.character(x[1])
  x[1]<- as.character(x[1])
  table_y <- x [grep(y, x[1]),]
  table_y[5] <- as.numeric(table_5[5])
  table_y[1] <- sapply(strsplit(table_y[1]," "), `[`, 1)
  table_y <- table_y %>% group_by[1] %>% summarise_at(5, sum, na.rm = T)
  tabley_sum <- sum(tabley[5])
}
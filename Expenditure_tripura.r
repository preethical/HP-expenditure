library (dplyr)
library(tidyr)
table <- read.csv("tabula-Expenditure Budget Volume 2 (Part I)_0.csv", header = TRUE,na="")
table_1 <- read.csv("tabula-Expenditure Budget Volume 2 (Part II)_0 (1).csv", header = FALSE, na = "")

names(table)[1] <- "Heads"
names(table_1)[1] <- "Heads"
names(table)[5] <- "Budget2020"
names(table_1)[5] <- "Budget2020"
#table <- na.omit(table)


table$Heads <- as.character(table$Heads)
table_1$Heads <- as.character(table_1$Heads)
#table_office <- table %>% filter(Heads == "Office Expenses")
#table[,grep("Office Expenses", names(df), value=TRUE)]
tableoffice <- table[grep("Office Expenses", table$Heads),]
tableoffice$Budget2020 <- as.numeric(tableoffice$Budget2020)
tableoffice$Heads <- sapply(strsplit(tableoffice$Heads," "), `[`, 1)
tableoffice_sum <- sum(tableoffice$Budget2020)

table_1_office <- table_1[grep("Office Expenses", table_1$Heads),]
table_1_office$Budget2020 <- as.numeric(table_1_office$Budget2020)
table_1_office$Heads <- sapply(strsplit(table_1_office$Heads," "), `[`, 1)
table_1_office_sum <- sum(table_1_office$Budget2020)
Office_table <- rbind(tableoffice, table_1_office)
Office_table <- Office_table %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)

tablesuppl <- table[grep("Supplies and Materials", table$Heads),]
tablesuppl$Budget.1 <- as.numeric(tablesuppl$Budget.1)
tablesuppl$Heads <- sapply(strsplit(tablesuppl$Heads," "), `[`, 1)
tablesuppl <- tablesuppl %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)
tablesuppl_sum <- sum(tablesuppl$Budget.1)

table_1_suppl <- table_1[grep("Supplies and Materials", table_1$Heads),]
table_1_suppl$Budget2020 <- as.numeric(table_1_suppl$Budget2020)
table_1_suppl$Heads <- sapply(strsplit(table_1_suppl$Heads," "), `[`, 1)
table_1_suppl <- table_1_suppl %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)
tablesuppl_sum <- sum(tablesuppl$Budget.1)
Office_table <- rbind(tableoffice, table_1_office)
Office_table <- Office_table %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)



table_ad <- table[grep("Advertisement", table$Heads),]
table_ad$Budget.1 <- as.numeric(table_ad$Budget.1)
table_ad_sum <- sum(table_ad$Budget.1, na.rm= TRUE)

table_wage <- table[grep("Wage", table$Heads),]
table_wage$Budget.1 <- as.numeric(table_wage$Budget.1)
table_wage <- table_wage[- grep("Wages Total", table_wage$Heads),]
table_wage <- table_wage[!is.na(table_wage$Budget.1), ]
table_wage_sum <- sum(table_wage$Budget.1, na.rm= TRUE)


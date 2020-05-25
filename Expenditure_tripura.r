library (dplyr)
library(tidyr)
library(ggplot2)
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
tableoffice$Budget2020 <- as.numeric(as.character(tableoffice$Budget2020))
#tableoffice$Heads <- sapply(strsplit(tableoffice$Heads," "),1)
tableoffice$Heads <- substr(tableoffice$Heads,1,4)
#write.csv(tableoffice,"C:/Users/Preethi's Laptop/Documents/R/datascience_coursera_main/HP expenditure/HP-expenditure/tableoffice.csv", row.names = FALSE)
tableoffice<- tableoffice %>% group_by(Heads) %>% summarise_at("Budget2020",sum, na.rm = TRUE)

table_1_office <- table_1[grep("Office Expenses", table_1$Heads),]
table_1_office$Budget2020 <- as.numeric(as.character(table_1_office$Budget2020))
table_1_office$Heads <- sapply(strsplit(table_1_office$Heads," "), `[`, 1)
table_1_office <- table_1_office %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)

Office_table <- rbind(tableoffice, table_1_office)
Office_table <- Office_table %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)
Office_table_sum<- sum(Office_table$Budget2020)


office_plot <- Office_table %>% arrange(desc(Budget2020)) %>%
  slice(1:5) %>%
  ggplot(., aes(x=Heads,y=Budget2020)) + geom_bar(fill = "#21405d", stat = "identity")+ 
  ggtitle ("Budget Estimates for Office Expenses for the year 2020-21")+
  ylab ("Budget Estimates in rs lakhs")

print(office_plot)
ggsave("office_plot.png")


table_vehicle <- table[grep("Vehicle", table$Heads),]
table_vehicle$Budget2020 <- as.numeric(as.character(table_vehicle$Budget2020))
table_vehicle$Heads <- sapply(strsplit(table_vehicle$Heads," "), `[`, 1)
table_vehicle<- table_vehicle %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)

table_1_vehicle <- table_1[grep("Vehicle", table_1$Heads),]
table_1_vehicle$Budget2020 <- as.numeric(as.character(table_1_vehicle$Budget2020))
table_1_vehicle$Heads <- sapply(strsplit(table_1_vehicle$Heads," "), `[`, 1)
table_1_vehicle<- table_1_vehicle %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)

vehicle_table <- rbind(table_vehicle, table_1_vehicle)
vehicle_table <- vehicle_table %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)
vehicle_table_sum<- sum(vehicle_table$Budget2020)


vehicle_plot <- vehicle_table %>% arrange(desc(Budget2020)) %>%
  slice(1:5) %>%
  ggplot(., aes(x=Heads,y=Budget2020)) + geom_bar(fill = "#21405d", stat = "identity") + 
  theme(axis.text.x = element_text(angle = 90))+ 
  ggtitle ("Budget Estimates for Vehicles for the year 2020-21")+
  ylab ("Budget Estimates in rs lakhs")

print(vehicle_plot)
ggsave("vehicle_plot.png")

table_electricity <- table[grep("Electricity", table$Heads),]
table_electricity$Budget2020 <- as.numeric(as.character(table_electricity$Budget2020))
table_electricity <- table_electricity[- grep("Electricity Charges Total", table_electricity$Heads),]
table_electricity <- table_electricity[!is.na(table_electricity$Budget2020), ]
table_electricity$Heads <- sapply(strsplit(table_electricity$Heads," "), `[`, 1)
table_electricity<- table_electricity %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)


table_1_electricity <- table_1[grep("Electricity", table_1$Heads),]
table_1_electricity$Budget2020 <- as.numeric(as.character(table_1_electricity$Budget2020))
table_1_electricity$Heads <- sapply(strsplit(table_1_electricity$Heads," "), `[`, 1)
table_1_electricity<- table_1_electricity %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)

electricity_table <- rbind(table_electricity, table_1_electricity)
electricity_table <- electricity_table %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)
electricity_table_sum<- sum(electricity_table$Budget2020)


elec_plot <- electricity_table %>% arrange(desc(Budget2020)) %>%
  slice(1:5) %>%
  ggplot(., aes(x=Heads,y=Budget2020)) + geom_bar(fill = "#21405d", stat = "identity") + 
  theme(axis.text.x = element_text(angle = 90))+
  ggtitle ("Budget Estimates for Electricity for the year 2020-21")+
  ylab ("Budget Estimates in rs lakhs")

print(elec_plot)
ggsave("elec_plot.png")

#table_enter <- table[grep("Entertainment", table$Heads),]
#table_enter$Budget2020 <- as.numeric(as.character(table_enter$Budget2020))
#table_enter<- table_enter[- grep("Total", table_enter$Heads),]
#table_enter <- table_enter[!is.na(table_enter$Budget2020), ]
#table_enter$Heads <- sapply(strsplit(table_enter$Heads," "), `[`, 1)
#table_enter<- table_enter %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)
#table_1_enter <- table_1[grep("Entertainment", table_1$Heads),]
#table_1_enter$Budget2020 <- as.numeric(table_1_enter$Budget2020)
#table_1_enter$Heads <- sapply(strsplit(table_1_enter$Heads," "), `[`, 1)
#table_1_enter <- table_1_enter %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)
#entertainment_table <- rbind(table_enter, table_1_enter)
#entertainment_table <- entertainment_table %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)
#entertainment_table_sum<- sum(entertainment_table$Budget2020)
#ent_plot <- entertainment_table %>% arrange(desc(Budget2020)) %>%
 # slice(1:5) %>%
#  ggplot(., aes(x=Heads,y=Budget2020)) + geom_bar(fill = "#21405d", stat = "identity") + 
 # theme(axis.text.x = element_text(angle = 90))
#print(ent_plot)
#ggsave("ent_plot.png")


#tablesuppl <- table[grep("Supplies and Materials", table$Heads),]
#tablesuppl$Budget2020 <- as.numeric(tablesuppl$Budget2020)
#tablesuppl$Heads <- sapply(strsplit(tablesuppl$Heads," "), `[`, 1)
#tablesuppl <- tablesuppl %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)

#table_1_suppl <- table_1[grep("Supplies and Materials", table_1$Heads),]
#table_1_suppl$Budget2020 <- as.numeric(table_1_suppl$Budget2020)
#table_1_suppl$Heads <- sapply(strsplit(table_1_suppl$Heads," "), `[`, 1)
#table_1_suppl <- table_1_suppl %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)

#supply_table <- rbind(tablesuppl, table_1_suppl)
#supply_table <- supply_table %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)
#supply_table_sum<- sum(supply_table$Budget2020)

#keywords <- c("Advertisement", "Advertising")
#table_ad <- filter(table, grepl(paste(keywords, collapse="|"), Heads))
table_ad <- table[grep("Advertis.*", table$Heads),]
table_ad$Budget2020 <- as.numeric(as.character(table_ad$Budget2020))
#table_ad$Heads <- substr(table_ad$Heads,1,4)
#table_ad$Heads <- sapply(strsplit(table_ad$Heads," "), `[`, 1)

table_ad <- table_ad[- grep("Total", table_ad$Heads),]
table_ad <- table_ad %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)

table_1_ad <- table_1[grep("Advertis.*", table_1$Heads),]
table_1_ad$Budget2020 <- as.numeric(as.character(table_1_ad$Budget2020))
#table_1_ad$Heads <- sapply(strsplit(table_1_ad$Heads," "), `[`, 1)
#table_1_ad <- table_1_ad[- grep("Total", table_ad$Heads),]
table_1_ad <- table_1_ad %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)

ad_table <- rbind(table_ad, table_1_ad)
ad_table <- ad_table %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)
ad_table_sum<- sum(ad_table$Budget2020)

ad_plot <- ad_table %>% arrange(desc(Budget2020)) %>%
  slice(1:5) %>%
  ggplot(., aes(x=Heads,y=Budget2020)) + geom_bar(fill = "#21405d", stat = "identity") + 
  theme(axis.text.x = element_text(angle = 90))+
  ggtitle ("Budget Estimates for advertising for the year 2020-21")+
  ylab ("Budget Estimates in rs lakhs")

print(ad_plot)
ggsave("ad_plot.png")


table_wage <- table[grep("Wages", table$Heads),]
table_wage$Budget2020 <- as.numeric(as.character(table_wage$Budget2020))
table_wage <- table_wage[- grep("Wages Total", table_wage$Heads),]
table_wage <- table_wage[!is.na(table_wage$Budget2020), ]
table_wage$Heads <- sapply(strsplit(table_wage$Heads," "), `[`, 1)
table_wage<- table_wage %>% group_by(Heads) %>% summarise_at("Budget2020", sum, na.rm = T)

table_1_wage <- table_1[grep("Wages", table_1$Heads),]
table_1_wage$Budget2020 <- as.numeric(as.character(table_1_wage$Budget2020))
#table_1_wage <- table_1_wage[- grep("Wages Total", table_1_wage$Heads),]
table_1_wage <- table_1_wage[!is.na(table_1_wage$Budget2020), ]
table_1_wage$Heads <- sapply(strsplit(table_1_wage$Heads," "), `[`, 1)
table_1_wage <- table_1_wage %>% group_by(Heads) %>% summarise_at("Budget2020", sum, na.rm = T)

wage_table <- rbind(table_wage,table_1_wage)
wage_table <- wage_table %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)
wage_table_sum<- sum(wage_table$Budget2020)

wage_plot <- wage_table %>% arrange(desc(Budget2020)) %>%
  slice(1:5) %>%
  ggplot(., aes(x=Heads,y=Budget2020)) + geom_bar(fill = "#21405d", stat = "identity") + 
  theme(axis.text.x = element_text(angle = 90))+
  ggtitle ("Budget Estimates for wages for the year 2020-21")+
  ylab ("Budget Estimates in rs lakhs")

print(wage_plot)
ggsave("wage_plot.png")


table_salaries <- table[grep("Salaries", table$Heads),]
table_salaries$Budget2020 <- as.numeric(as.character(table_salaries$Budget2020))
table_salaries <- table_salaries[- grep("Salaries Total", table_salaries$Heads),]
table_salaries <- table_salaries[!is.na(table_salaries$Budget2020), ]
table_salaries$Heads <- sapply(strsplit(table_salaries$Heads," "), `[`, 1)
table_salaries<- table_salaries %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)

table_1_salaries <- table_1[grep("Salaries", table_1$Heads),]
table_1_salaries$Budget2020 <- as.numeric(as.character(table_1_salaries$Budget2020))
table_1_salaries<- table_1_salaries[- grep("Salaries Total", table_1_salaries$Heads),]
table_1_salaries<- table_1_salaries[!is.na(table_1_salaries$Budget2020), ]
table_1_salaries$Heads <- sapply(strsplit(table_1_salaries$Heads," "), `[`, 1)
table_1_salaries <- table_1_salaries %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)

salary_table <- rbind(table_salaries, table_1_salaries)
salary_table <- salary_table %>% group_by (Heads) %>% summarise_at("Budget2020", sum, na.rm = T)
salary_table_sum<- sum(salary_table$Budget2020)

salary_plot <- salary_table %>% arrange(desc(Budget2020)) %>%
  slice(1:5) %>%
  ggplot(., aes(x=Heads,y=Budget2020)) + geom_bar(fill = "#21405d", stat = "identity") + 
  theme(axis.text.x = element_text(angle = 90))+
  ggtitle ("Budget Estimates for salaries for the year 2020-21")+
  ylab ("Budget Estimates in rs lakhs")

print(salary_plot)
ggsave("salary_plot.png")


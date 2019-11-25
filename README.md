
## HP-expenditure
A repository for the exploratory analysis with 2018-2019 expenditure and budget data for Himachal Pradesh

The repository contains

- HP-expenditure.rmd file: This file has the working code for the HP-expenditure and budget data exploratory analysis along with any queries at each step. 
To run the code.
-first download R-studio
-Clone the repository
-run the budgetdata_download.r program
-Either knit or run specific chunks of .rmd file

-budgetdata_download.r file : This file contains the code to download the budget data from the google drive. This should then be stored in your working directory before running the HP-expenditure.rmd file as it expects the file to be there. 

HP-expenditure.pdf file : Is the knitted version of the rmd file so it can be viewed without R. 

## Why this repository and code base exists. 

This is a prelimnary attempt to work with and analyse the Himachal Pradesh Budgetary data. 
It works with 2 databases

- Budget Expenditure data: This contains the budget allocation and realized estimates for the year 2018-2019. It is updated regularly
- Spending Expenditure data: This contains the district wise expenditure data for the year 2018-2019 and is updated regularly

How both the databases tie into each other is unknown right now. 

## glossary 

Budget Allocation dataset: 

1) Account Heads(demand,major,sub_major, minor, sub_minor, budget): These Account Heads are meant to represent the nature of the income or expenditure, these also represent hierarchial money flow		

## Assumptions: 
  For example a major of 2210 corresponds to medical and public health
  Underwhich a sub major of 03 corresponds to Medical Education Training and Research
  and 
  A minor of 102 under that corresponds to Homeopathy. 
  
At this point I do not know what Demand and sub-minor correspond or their relevance to the exploratory analysis. 
Information regarding Account heads from:
https://www.google.co.in/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&ved=2ahUKEwiJlNrMpYXmAhXZZCsKHd5yCKcQFjAAegQIARAH&url=http%3A%2F%2Fcga.nic.in%2FDownloadPDF.aspx%3Ffilenameid%3D1537&usg=AOvVaw3Z4EAzbLv5P9gbjMle70_s

2) voted_charged	
a) Voted: There needs to be voting by all government representatives to pass this expenditure  
b) Charged: This amount needs to be passed without voting 		

3) plan_nonplan	
a)Plan: Money spent by Government for heads such as salaries, Loans, subsides, Interests etc. 
b) Non Plan: Money spent on various projects of Minitries		

4) SOE	Unique code for different Statement Of Expenditure		

5) SOE_description	Contains essentials of budget(Further drill down the hierarchy of Account Heads)		
date	Date for which the data is collected		

6) SANCTION	Refers to the Amount that is added in the sanctioned amount to meet the requirements	
7) SAVING	refers to the Amount saved after considering addition		
8) REVISED(Sanction+Addition-Saving): This refers to the final balance for particular head		

Assumption: Sanction, Saving and Revised are mentioned in Lakhs? 

## Himachal District Wise Expenditure Dataset

1) District: Name of district for which respective daily spending data is given	

There are a 105 unique characters in this column and only 12 districs in HP. So I am a little confused about this

2) Treasury_Code: Every District have treasury through which it conducts transactions. Every Treasury has its own unique code	

3) DDO_Code: A Drawing and Disbursing Officer (DDO) is the officer responsible for drawing fund from Treasuries and diburse to proper recepients. This column proved unique code of DDO


4) DDO_Desc: Description of the above code	

5) Account Heads: The same as the budget definitions

6) voted_charged	
Voted: There needs to be voting by all government representatives to pass this expenditure  
Charged: This amount needs to be passed without voting 	

7) plan_nonplan	
Plan: Money spent by Government for heads such as salaries, Loans, subsides, Interests etc. 
Non Plan: Money spent on various projects of Minitries	

8) SOE: Unique code for different Statement Of Expenditure	

9) SOE_description: Contains essentials of budget(Further drill down the hierarchy of Account Heads)	

10) TRANSDATE: Date of Transaction	

11) Voucher and Bills: Number of bills and unique code of each voucher	
 - (I do not know the relevance of this column)

12) GROSS: Total alloted amount	

13) AGDED: Amount added in Alloted Amount	

14) BTDED: Amount saved from Total Alloted Amount	

15) NETPAYMENT: Net Payment	
		Netpayment = GROSS + AGDED - BTDED		
		
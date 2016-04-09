# Since I have downloaded my data from a thrid party source in xlsx format (eia), I am installing "xlsx" package
#install.packages("xlsx")

#setwd("/Users/AbdulWadood/Desktop/R/Data_Products") 

library(xlsx)
#reading sheet 1 of eia.gov data
my_data <- read.xlsx(file = 'Consumptiondata.xlsx',header = TRUE,1)

#removing multiplier unit of bbl/day for each row
my_data <- my_data[,c(-3)] 
# rename columns
colnames(my_data) <- c("Serial#","Country","1981","1982","1983","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014")

#NA_data  <- apply(!is.na(data),2, sum) > 226
#req_data <- data[,NA_data]

# Replaced "(s)", "-","NAs", with "0" since they do not contribute to the analysis. Some countries ceased to exist or changed names etc
my_data[my_data=='--'] <- 0
my_data[my_data=='(s)'] <- 0
my_data[is.na(my_data)] <- 0

#Further data preprocesing for my analysis (summing total production )
#my_data[228,2] <- "Total" 
country_data <-  data.frame(my_data[,1])
country_data[,2] <-  data.frame(my_data[,2])
country_data[228,1] <- c("Total") 
my_data <- data.frame(lapply(my_data[,c(1,3:37)],as.numeric))
my_data[228,]<- colSums(my_data,na.rm =TRUE)

#Column binding contry name data with serial no, and also combining total production value /day (although not used)
my_data3 <- cbind(country_data,my_data)

#removing serial# and multiplier unit of bbl/day for each column
my_data3 <- my_data3[,-3] 

# renaming columns
colnames(my_data3) <- c("Serial#","Country","1981","1982","1983","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014")

levels(my_data3$Country) = c(levels(my_data3$Country), "Total")
my_data3[228,2] <- as.character("Total")
my_data3[,38]<- rowSums(my_data3[,c(3:37)],na.rm =TRUE)

#replacing NAs with 0
my_data3[is.na(my_data3)] <- 0
my_data3 <- my_data3[c(1:227),]

#replacing spaces, fullstops, brackets with spaces for use in checkboxes
my_data3$Country <- gsub(my_data3$Country,pattern = "\\, | \\. | \\( | \\(|\\)",replacement = " ")
my_data3$Country <- gsub(my_data3$Country,pattern = "\\, | \\. | \\( | \\(|\\)",replacement = " ")
my_data3$Country <- gsub(my_data3$Country,pattern = "\\, | \\. | \\( | \\(|\\)",replacement = " ")

#Making all country data frame for use in selection checkbox group
c_names <- data.frame(my_data3[,2])
c_names <- gsub(c_names[,1],pattern = "\\, | \\. | \\( | \\(|\\)",replacement = " ")
c_names<- as.matrix(c_names)

#downloaded further data, a data set that separated country specfic to a certain region (continent)
country <- read.xlsx("country.xlsx",header = TRUE,1,stringsAsFactors=FALSE)
colnames(country) <- gsub(names(country),pattern = "\\.",replacement = " ")

#data preprocessing for use in check boxes
country$`North America` <- gsub(country$`North America`, pattern = "\\, | \\. | \\( | \\(|\\)", replacement = " ")
country$`Central   South America` <- gsub(country$`Central   South America`, pattern = "\\, | \\. | \\( | \\(|\\)", replacement = " ")
country$Europe <- gsub(country$Europe, pattern = "\\, | \\. | \\( | \\(|\\)", replacement = " ")
country$Eurasia <- gsub(country$Eurasia, pattern = "\\, | \\. | \\( | \\(|\\)", replacement = " ")
country$`Middle East` <- gsub(country$`Middle East`, pattern = "\\, | \\. | \\( | \\(|\\)", replacement = " ")
country$Africa <- gsub(country$Africa, pattern = "\\, | \\. | \\( | \\(|\\)", replacement = " ")
country$`Asia   Oceania`<- gsub(country$`Asia   Oceania`, pattern = "\\, | \\. | \\( | \\(|\\)", replacement = " ")

# Testing position variable to calculate each indivudla column end of roecord for each region. Later used in Server.R files
# remove(country1)
country1 <- as.data.frame(1,nrow = 235, ncol= 34)
for(i in 1:7)
{
pos <- which(is.na(country[,i]))[1] - 1
country1[c(1:pos),i]<- as.matrix(country[c(1:pos),i])
}


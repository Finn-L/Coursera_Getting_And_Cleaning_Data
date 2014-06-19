## 1
data <- read.csv("GettingCleaningData/data/housing.csv")
names(data)
summary(data$VAL)
table(data$VAL >= 24)
table(data$FES)

## 2
library(xlsx)
dat <- read.xlsx("GettingCleaningData/data/NaturalGasAquisitionProgram.xlsx", 
                 sheetIndex = 1, colIndex = 7:15, rowIndex = 18:23)
sum(dat$Zip*dat$Ext,na.rm=T) 

## 3
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml" 
download.file(fileURL, destfile = "GettingCleaningData/data/restaurants.xml", 
              method = "curl")
dataDownloaded <- data()
library(XML)
data2 <- xmlTreeParse("GettingCleaningData/data/restaurants.xml", 
                      useInternal = TRUE)
node <- xmlRoot(data2)
xmlName(node)
names(node)
node[[1]][[1]]
node[[1]][[1]][[2]]
zipcodes <- xpathSApply(node, "//zipcode", xmlValue)
table(zipcodes == 21231)

## 4
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(URL, 
              destfile = "GettingCleaningData/data/housingforIdaho.csv", 
              method = "curl")
library(data.table)
DT <- fread("GettingCleaningData/data/housingforIdaho.csv")

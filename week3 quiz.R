data <- read.csv("GettingCleaningData/data/housingofIdaho.csv")
summary(data)
## ACR 1 Lot size
## b .N/A (GQ/not a one-family house or mobile home)
## 1 .House on less than one acre
## 2 .House on one to less than ten acres
## 3 .House on ten or more acres
summary(data$ACR)

## AGS        1
## Sales of Agriculture Products
## b .N/A (less than 1 acre/GQ/vacant/  
## .2 or more units in structure)
## 1 .None
## 2.$ 1-$999 3 .$ 1000 - $ 2499 4 .$ 2500 - $ 4999 
## 5 .$ 5000 - $ 9999 6 .$10000+
summary(data$AGS)

agricultureLogical <- data$AGS == 6 & data$ACR == 3
for(i in 1:length(agricultureLogical)) {
    if(is.na(agricultureLogical[i])) {
        agricultureLogical[i] <- FALSE
    }
}
which(agricultureLogical)


library(jpeg)
jdata <- readJPEG("GettingCleaningData/data/getdata-jeff.jpg",
                  native = T)
quantile(jdata, probs = c(0.3, 0.8))


d1 <- read.csv("GettingCleaningData/data/getdata-data-GDP.csv",
               skip = 5, header = F)
d2 <- read.csv("GettingCleaningData/data/EDSTATS_Country.csv")
d1 <- d1[ ,c(1,2,4,5)]
names(d1) <- c("CountryCode", "ranking", "eco", "usd")
head(d1)
d1 <- d1[1:231, ]
d1 <- d1[1:190, ]
tail(d1, 10)
head(d1$CountryCode)
str(d1$ranking)
## don't know why need to transform data this way (cuz of factor ?)
d1$ranking <- as.character(d1$ranking)
d1$ranking <- as.numeric(d1$ranking)
d1$CountryCode <- as.character(d1$CountryCode)
head(d2$CountryCode)
d2$CountryCode <- as.character(d2$CountryCode)
intersect(names(d1), names(d2))
d3 <- merge(d1, d2)
str(d3$ranking)
d3 <- d3[order(d3$ranking, decreasing = T), ]


summary(d3$Income.Group)
d4 <- split(d3$ranking, d3$Income.Group)
head(d4)
lapply(d4, mean, na.rm = TRUE)


library(Hmisc)
d3$groups <- cut2(d3$ranking, g = 5)
summary(d3$groups)
table(d3$groups, d3$Income.Group)

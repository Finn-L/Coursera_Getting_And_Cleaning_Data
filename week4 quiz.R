## q1
data <- read.csv("GettingCleaningData/data/getdata-data-ss06hid.csv")
strsplit(names(data), "wgtp")

## q2
data <- read.csv("GettingCleaningData/data/getdata-data-GDP.csv", 
                 header = F, skip = 5)
data <- data[ ,c(1,2,4,5)]
names(data) <- c("CountryCode", "ranking", "eco", "usd")
head(data)
data <- data[1:231, ]
data$usd <- gsub(",", "", data$usd)
data <- data[1:190, ]
data$usd <- as.numeric(data$usd)
str(data$usd)
mean(data$usd)

## q3
grep("^United", data$eco)

## q4
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

info <- as.character(d3$Special.Notes[grep("[Ff]iscal", d3$Special.Notes)])
info <- info[grep("June", info)]
info

## q5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
str(sampleTimes)
length(grep("2012", sampleTimes))
sampleTimes <- sampleTimes[grep("2012", sampleTimes)]
length(grep("Monday", weekdays(sampleTimes)))

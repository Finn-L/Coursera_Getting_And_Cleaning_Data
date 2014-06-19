library(sqldf)
acs <- read.csv("GettingCleaningData/data/ss06pid.csv")
names(acs)
unique(acs$AGEP)

## library(XML)
## url <- "http://biostat.jhsph.edu/~jleek/contact.html"
## html <- htmlTreeParse(url, useInternalNodes = T)


con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlcode = readLines(con)
close(con)
nchar(htmlcode[10])
nchar(htmlcode[20])
nchar(htmlcode[30])
nchar(htmlcode[100])

d <- read.fwf("GettingCleaningData/data/wksst8110.for", 
              width = c(-1, 9, -5, 4, -1, 3, -5, 4), skip = 4)
head(d)
sum(d$V4)

## read data and put the header(variable names) in
x.train <- read.table("UCI HAR Dataset/train/X_train.txt")
features <- read.table("UCI HAR Dataset/features.txt")
names(x.train) <- features$V2
x.test <- read.table("UCI HAR Dataset/test/X_test.txt")
names(x.test) <- features$V2

subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt")
y.test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt")
y.train <- read.table("UCI HAR Dataset/train/y_train.txt")

## extract info about mean and standard deviation
names(x.train) <- tolower(names(x.train))
names(x.test) <- tolower(names(x.test))
length(names(x.train))
x.train <- x.train[ , grepl("mean|std", names(x.train))]
x.test <- x.test[ , grepl("mean|std", names(x.test))]

## put the subjects and activity identifiers in
x.train$subject <- subject.train$V1
x.test$subject <- subject.test$V1
x.train$activity <- y.train$V1
x.test$activity <- y.test$V1

##reorder variables
x.train <- x.train[c(87, 88, 1:86)]
x.test <- x.test[c(87, 88, 1:86)]

## merge test and training data
summary(x.test$subject)
summary(x.train$subject)
intersect(x.test$subject, x.train$subject) ## experiment participants are different
## add a test/training identifier
x.test$experiment.session <- "test"
x.train$experiment.session <- "train"
length(names(x.test))
## reorder varibles
x.test <- x.test[c(1, 2, 89, 3:88)]
x.train <- x.train[c(1, 2, 89, 3:88)]
names(x.test)
## merge data, then check row and column names
nrow(x.test) + nrow(x.train)
motion.data <- rbind(x.train, x.test)
rownames(motion.data)
names(motion.data)
summary(motion.data[ , 1:3])

## descripe actitity names
motion.data$activity[motion.data$activity == 1] <- "walking"
motion.data$activity[motion.data$activity == 2] <- "walking.upstairs"
motion.data$activity[motion.data$activity == 3] <- "walking.downstairs"
motion.data$activity[motion.data$activity == 4] <- "sitting"
motion.data$activity[motion.data$activity == 5] <- "standing"
motion.data$activity[motion.data$activity == 6] <- "laying"
motion.data$activity <- factor(motion.data$activity)

## Creates a second data set with the average of each variable 
## for each activity and each subject
motion.data$experiment.session <- factor(motion.data$experiment.session)
motion.data$subject <- factor(motion.data$subject)
motion.data <- motion.data[order(motion.data$subject), ]
## Group merged data and summarise the mean and std variables
library(dplyr)
data <- group_by(motion.data, subject, activity)
cols <- names(data)[4:89]
dots <- sapply(cols, function(x) substitute(mean(x), 
                                            list(x = as.name(x))))
tidy.data <- do.call(summarise, c(list(.data = data), dots))

## modify variable names to make them clear
names(tidy.data) <- gsub("-", ".", names(tidy.data))
names(tidy.data) <- gsub("\\()", "", names(tidy.data))
names(tidy.data) <- gsub("\\(", ".", names(tidy.data))
names(tidy.data) <- gsub(",", ".", names(tidy.data))
names(tidy.data) <- gsub("\\)", "", names(tidy.data))

## write the data to a local file
write.table(tidy.data, file = "UCI HAR Dataset/tidydata.txt", sep = ",")

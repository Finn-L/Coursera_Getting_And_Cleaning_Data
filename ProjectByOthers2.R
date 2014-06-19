#GETTING AND CLEANING DATA
#COURSE PROJECT

#This RScript takes wearable data as the input and then
#summarizes it by subject and activity into one data set

#set working directory

setwd("/Users/harishreddy/Google Drive/Coursera/GettingAndCleaningData/CourseProject")

#load and clean test and training data

#subject
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject <- rbind (subject_test, subject_train)

colnames(subject)[1] <- "Subject"

subject$Subject = as.factor(subject$Subject)

#activity
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
y <- rbind(y_test, y_train)
colnames(y)[1] <- "Activity"

y$Activity[y$Activity==1] <- "walking"
y$Activity[y$Activity==2] <- "walkingUpstairs"
y$Activity[y$Activity==3] <- "walkingDownstairs"
y$Activity[y$Activity==4] <- "sitting"
y$Activity[y$Activity==5] <- "standing"
y$Activity[y$Activity==6] <- "laying"

y$Activity = as.factor(y$Activity)


#this is the measurement data (from feature.txt)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
x <- rbind(x_test, x_train)

#open features.txt which has the names of the columns and change the column names
#to something more readable

features_list <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
names(x) <- features_list$V2

#Subset on just the mean and standard deviation columns
#See Readmet for column explanations

xSubset <- x[,c(1:6,41:46,
                81:86,121:126,
                161:166,201:202,
                214:215,227:228,
                240:241,253:254,
                266:271,345:350,
                424:429,503:504,
                516:517,529:530,
                542:543)]

#combine the subject, activity (x), and measurement (y) data frames into 1

subjectDF <- cbind(subject,y,xSubset)

#NEED TO GROUP BY SUBJECT AND ACTIVITY AND TAKE THE MEAN

aggregateCalcsDF <- aggregate(subjectDF[,3:ncol(subjectDF)], by=list(subjectDF$Subject, subjectDF$Activity), FUN="mean")

#CLEAN UP COLUMN NAMES 

colnames(aggregateCalcsDF)[1] <- "Subject"
colnames(aggregateCalcsDF)[2] <- "Activity"

n <- names(aggregateCalcsDF)
n <- gsub("-","",n)
n <- gsub("-","",n)
n <- gsub("\\(\\)","",n)
n <- gsub("mean","Mean",n)
n <- gsub("std","Std",n)

names(aggregateCalcsDF) <- n

#WRITE TIDY DATA SET TO FILE

write.csv(aggregateCalcsDF, file="aggregateCalcs.txt", row.names=FALSE)
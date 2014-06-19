run <- function() {
    #read the files into dataframes
    X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
    X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
    Y_test <- read.fwf("./UCI HAR Dataset/test/y_test.txt",widths=1)
    Y_train <- read.fwf("./UCI HAR Dataset/train/Y_train.txt",widths=1)
    subject_test <- read.fwf("./UCI HAR Dataset/test/subject_test.txt", width=2)
    subject_train <- read.fwf("./UCI HAR Dataset/train/subject_train.txt", width=2)
    features <- read.table("./UCI HAR Dataset/features.txt")
    activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
    
    #Column bind to generate A, B, C, D
    A <- cbind(Y_test, subject_test)
    colnames(A) <- c("Activity", "Subject")
    B <- cbind(Y_train, subject_train)
    colnames(B) <- c("Activity", "Subject")
    C <- rbind(A,B)
    D <- rbind(X_train,X_test)
    colnames(D) <- features$V2 #Change column names of D from features.txt
    
    #Eliminate columns from D which
    #do not have "mean()" or "std()" in the column names.
    E <- D[,c(grep("mean\\(\\)",colnames(D)),grep("std\\(\\)",colnames(D)))]
    
    # Take mean of observations per activity per subject
    F <- cbind(C,E)
    library(reshape2)
    meltF<-melt(F, id=c("Subject", "Activity"))
    dcastF<-dcast(meltF,Subject+Activity ~ variable,fun.aggregate=mean)
    
    #Replace activity numbers with Activity names from activity_labels
    tidydataset <- merge(dcastF, activity_labels, by.x="Activity", by.y="V1")
    for (i in 1:nrow(tidydataset)) {
        tidydataset$Activity <- factor((tidydataset$Activity[i]),
                                       labels = as.character(activity_labels[tidydataset$Activity[i],2]))  
    }
    tidydataset$V2 <- NULL #Delete the temporary label column "V2"
    
    #write the .txt file
    write.table(tidydataset,"tidydataset.txt")
}
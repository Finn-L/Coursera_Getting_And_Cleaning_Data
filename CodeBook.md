Getting and Cleaning Data - course project - Code Book
===========
### By Finn L
===========

### Two important variables:
* subject: 1-30 (every subject has 6 activities)
* activity: indicates one of the 6 types of activities, including:
  "laying", "sitting", "standing", "walking", "walking.downstairs",   "walking.upstairs"

### Rest of the variables are names utilitizing the following pattern:
### These signals were used to estimate variables of the feature vector for each pattern ('-XYZ' is used to denote 3-axial signals in the X, Y and Z directions):

        tBodyAcc-XYZ
        tGravityAcc-XYZ
        tBodyAccJerk-XYZ
        tBodyGyro-XYZ
        tBodyGyroJerk-XYZ
        tBodyAccMag
        tGravityAccMag
        tBodyAccJerkMag
        tBodyGyroMag
        tBodyGyroJerkMag
        fBodyAcc-XYZ
        fBodyAccJerk-XYZ
        fBodyGyro-XYZ
        fBodyAccMag
        fBodyAccJerkMag
        fBodyGyroMag
        fBodyGyroJerkMag

### The set of variables that were estimated from these signals are: 

        mean(): Mean value
        std(): Standard deviation
        
### Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
        gravityMean
        tBodyAccMean
        tBodyAccJerkMean
        tBodyGyroMean
        tBodyGyroJerkMean
        
### Important Notes:
* Perhaps this assignment intends that we organize the data in a way that every single row represents a single participant. So it should have involved some data reshaping work.

* Given the way the data is organized and processed by me, I think it is appropriate to reshape this tidy data in this format.


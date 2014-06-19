Getting and Cleaning Data - course project - tidy data
===========
### By Finn L
===========
* This tidy dataset contains the averaged information about mean and standard deviation on all features. It is organized in a way that readers can easily pick up the data for each participant on each activity.

## Variables explained:
* as described in the assignment requirements, variables named with "std" or "mean" in them are picked.

* then the data are summarised by both the participant number and activity identifier to be understandable by human.

## For this repo, it is provided:
* a r script to reproduce the tidy data from original data set
* a code book to clarify the variable names
* readme.md file


## For each row of the generated tidy data, it is provided:
* subject identifier(named "subject")
* activity identifier(named "activity")
* sets of measurements of mean and standard deviation on different features (note the variable names are modified to be more clear)

## How the r script works:
### 1.read the original data sets , then modify the x.* data headers from the "features.txt" file.

### 2.get rid of irrelevant columns.

### 3.insert the subject and activity information from the corresponded subject_*.txt and y_*.txt files.

### 4.merge the two data sets for training and test.

### 5.label the activity names.

### 6.group merged data by subject and activity, then summarise the relevant information.

### 7.export the final tidy data to local folder as a ".txt" file.

## Notes:
* For more details, please refer to the script comments.
* Personally I think the instructions are a little vague. So there is a chance that I misunderstand the assignment requirements.
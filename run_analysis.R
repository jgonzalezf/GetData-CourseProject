## Using the UCI HAR Dataset downloaded from:
## 
##   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## 
## This script does the following steps:
## 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for
##    each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set
##    with the average of each variable for each activity and each subject.


##
## 1. Merges the training and the test sets to create one data set.
##############################################################################


# Reads the features list

features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)


# Reads the training data set from the 3 files in the /train subdirectory
# It also assigns names to the columns in each file using the features list

subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                           col.names = c("subjectId"),
                           header = FALSE)

xTrain <- read.table("./UCI HAR Dataset/train/x_train.txt", 
                     col.names = features[,2],
                     header = FALSE)

yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                     col.names = c("activityId"),
                     header = FALSE)


# Combines subjectTrain, yTrain and xTrain into the training data set

trainData <- cbind(subjectTrain, yTrain, xTrain)


# Reads the test data set from the 3 files in the /test subdirectory
# It also assigns names to the columns in each file using the features list

subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                          col.names = c("subjectId"),
                          header = FALSE)

xTest <- read.table("./UCI HAR Dataset/test/x_test.txt", 
                    col.names = features[,2],
                    header = FALSE)

yTest <- read.table("./UCI HAR Dataset/test/y_test.txt", 
                    col.names = c("activityId"),
                    header = FALSE)


# Combines subjecttest, ytest and xtest into the testing data set

testData <- cbind(subjectTest, yTest, xTest)


# Combines trainData and testData to create the full data set

fullData <- rbind(trainData, testData)


##
## 2. Extracts only the measurements on the mean and standard deviation for
##    each measurement. 
##############################################################################


# Creates a character vector with the name of all the columns

columns <- colnames(fullData)


# Creates a logical vector with TRUE values for activityId, subjectId and all 
# mean() and stddev() columns, and FALSE for the rest of the columns
# 
# NOTE: meanFreq() columns are not included, since only the mean() and the
#   stddev() variables for each signal must be extracted. In the file 
#   features_info.txt, meanFreq() is listed as another variable for signals,
#   therefore different than the mean() variable

finalColumns <- (grepl("activityId", columns) |
                 grepl("subjectId", columns) |
                 (grepl("mean|std", columns) & !grepl("meanFreq", columns)))


# Subsets fullData based on the finalColumns vector, selecting final columns only

finalData <- fullData[finalColumns]


##
## 3. Uses descriptive activity names to name the activities in the data set
##############################################################################


# Reads the activity names

activityNames <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                             col.names = c("activityId","activityName"),
                             header = FALSE)


# Merges finalData with activityLabels to include descriptive activity names

finalData <- merge(finalData, activityNames, by = "activityId", all.x = TRUE)


##
## 4. Appropriately labels the data set with descriptive variable names
##############################################################################


# Creates a character vector with the name of all the columns

newColumnNames <- colnames(finalData)


# Since prefix 't' denotes time signal, and prefix 'f' denotes frequency
#   signal, changes prefix 't' to 'time' and prefix 'f' to 'freq'

newColumnNames <- gsub("^t", "time", newColumnNames)
newColumnNames <- gsub("^f", "freq", newColumnNames)


# Since all original features are written using camelCaps, changes 'mean'
#   and 'std' into 'Mean' and 'StdDev'

newColumnNames <- gsub("mean", "Mean", newColumnNames)
newColumnNames <- gsub("std", "StdDev", newColumnNames)


# Adds the lost '-' that denoted the feature vector for each pattern.
#   The slash was lost when reading the train and test files, where
#   the columns were named after the features list

newColumnNames <- gsub("(X|Y|Z)$", "-\\1", newColumnNames)


# Finally, removes the dots in the column names

newColumnNames <- gsub("\\.", "", newColumnNames)


# Reassigning the descriptive variable names to finalData

colnames(finalData) <- newColumnNames


##
## 5. From the data set in step 4, creates a second, independent tidy data set
##    with the average of each variable for each activity and each subject.
##############################################################################


# In this step, it uses ddply() from the "plyr" package

install.packages("plyr")
library(plyr)


# For each activity and each subject in the finalData set, calculates the mean
#   and then combines the results into a data frame

tidyData <- ddply(finalData, .(activityId, subjectId), numcolwise(mean))


# Exports the tidyData set 

write.table(tidyData, "./tidyData.txt", row.name=FALSE)

# Getting and Cleaning Data - Course Project

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The data used in this project is collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Project Summary

The goal of the project is to create one R script called ```run_analysis.R``` that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps to use this project

1. [Download the data source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and extract it into a folder on your local drive. You will see a ```UCI HAR Dataset``` folder.
2. Put ```run_analysis.R``` in the folder where you extracted the dataset ```UCI HAR Dataset```, then set it as your working directory using ```setwd()``` function in RStudio.
3. Run ```source("run_analysis.R")```, and it will generate a new file ```tidyData.txt``` in the directory.

## Project files 

The project consists of three files:
* **run_analysis.R** The R script that collects, works, and cleans the data set.
* **code_book.md** A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.
* **README.md** This README file.


## Dependencies

```run_analysis.R``` depends on ```plyr``` R package. The code will install and load the package automatically.

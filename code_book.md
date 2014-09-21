# CodeBook

This is a code bookdescribes the variables, the data, and any transformations or work that performed to clean up the data.

## Original Dataset

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. More details in 'features_info.txt

For each record it is provided
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

The dataset includes the following files:
* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes:
* Features are normalized and bounded within [-1,1].
* Each feature vector is a row on the text file.

## Data Transformations

```run_analysis.R``` is divided into 5 steps:

1. Merges the training and the test sets to create one data set.
    * Reads the features list.
    * Reads and combines the training data set using the 3 original files, and assigns names to the columns using the features list.
    * Reads and combines the test data set using the 3 original files, and assigns names to the columns using the features list.
    * Combines training and test data into one complete dataset.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
    * Creates a character vector with the name of all the columns.
    * Creates a logical vector with TRUE values for activityId, subjectId and all mean() and stddev() columns, and FALSE for the rest of the columns, using the column names and regular expressions. **NOTE**: meanFreq() columns are not included, since only the mean() and the stddev() variables for each signal must be extracted. In the file 'features_info.txt', meanFreq() is listed as another variable for signals, therefore it is assumed to be different than the mean() variable.
    * Subsets the complete dataset with the selected columns.
3. Uses descriptive activity names to name the activities in the data set
    * Reads the activity names
    * Merges the dataset with the activity names into another dataset 
4. Appropriately labels the data set with descriptive activity names. For all column names:
    * Since prefix 't' denotes time signal, and prefix 'f' denotes frequency signal, changes prefix 't' to 'time' and prefix 'f' to 'freq'.
    * Since all original features are written using camelCaps, changes 'mean' and 'std' into 'Mean' and 'StdDev'.
    * Adds the lost '-' that denoted the feature vector for each pattern. The slash was lost when reading the train and test files, where the columns were named after the features list.
    * Removes dots in the column names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    * Using ```ddply()``` from the ```plyr``` package, for each activity and each subject in the final dataset, calculates the mean and then combines the results into a tidy dataset.
    * Exports the tidy dataser set into ```tidyData.txt```

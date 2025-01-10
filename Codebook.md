# CodeBook
This is a code book that describes the variables, the data, and any transformations 
or work that you performed to clean up the data.

## The data source
* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the 
training data and 30% the test data.
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## The data

The dataset includes the following files:\
- 'README.txt'\
- 'features_info.txt': Shows information about the variables used on the feature vector.\
- 'features.txt': List of all features.\
- 'activity_labels.txt': Links the class labels with their activity name.\
- 'train/X_train.txt': Training set.\
- 'train/y_train.txt': Training labels.\
- 'test/X_test.txt': Test set.\
- 'test/y_test.txt': Test labels.  

The following files are available for the train and test data. Their descriptions are equivalent.\
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.\
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. 
The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.\
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting 
the gravity from the total acceleration.\
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope
for each window sample. The units are radians/second.  

## run_analysis.R details
Prerequisites: zip file from above is saved an unzipped to the working directory and
dplyr package for R should be installed on the machine.  

There are 5 steps to run_analysis:
1. Merge the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

# Step 1
create a list using features.txt, ready to apply to x_test and x_train data frames.\
Do the same with activity_labels.txt for y_test and y_train.\
Read in subject_test, subject_train data and set column name to "subj" then bind this data to one\
Read in x_test, x_train data and set column names using the features list created then bind this data to one\
Read in y_test, y_train data and set column names to "labels", reading for merging later then bind this data to one    

The above datasets should have the same no of obs (10299) so merge the above binded datasets to a new data frame called alldata based on obs number.

# Step 2
Using dplyr select funtion keep on mean and std measurements (select(subj, labels, contains("mean"), contains("std") ))

# Step 3 
Merge on activity_labels by labels variable to get full activity name. Labels variable can then be dropped as not needed for analysis.

# Step 4
For more decsriptive names gsub was applied as much as possible where:\
t at start of a column name is changed to Time\
f at start of a column name is changed to Frequency\
subj column changed to Subject\
Gyro in a column name change to Gyroscope\
Acc in a column name changed to Accelerometer\
Mean, STD, Gravity values were all standardised in case presented\
Some futher minor format substitutions applied

# Step 5
Using dplyr group_by to group data by subject and activity before using summarise_all to work out the means of all the columns by these group variables.
The resulting data is written to tidy_data.txt.

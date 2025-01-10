##Read in test and activity data
## Features Data and labels data for formatting later
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","features"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("labels", "activity"))

## 3 Test data files
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names="subj")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$features)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",  col.names = "labels")

## 3 Train data files
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subj")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$features)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "labels")

##Step 1 create merged dataset
##Bind datasets together and join to one dataset by obs no.
##Bind x datasets
allx<-rbind(x_test, x_train)
##Bind y datasets
ally<-rbind(y_test, y_train)
##Bind subject datasets
allsub<-rbind(subject_test, subject_train)
##Merge all together
alldata<-cbind(allx, ally, allsub)
names(alldata)


##Step 2 keep only mean and std measurements collected
library(dplyr)
alldata2<-alldata %>%
          select(subj, labels, contains("mean"), contains("std") )

##Step 3 use full activity names
alldata3<-merge(alldata2, activity_labels, by="labels")

##Remove labels column
alldata3<-select(alldata3, -labels)

##Step 4 use decsriptive variable names
names(alldata3)<-gsub("^t", "Time", names(alldata3))
names(alldata3)<-gsub("subj", "Subject", names(alldata3))
names(alldata3)<-gsub("activity", "Activity", names(alldata3))
names(alldata3)<-gsub("^f", "Frequency", names(alldata3))
names(alldata3)<-gsub("Gyro", "Gyroscope", names(alldata3))
names(alldata3)<-gsub("Acc", "Accelerometer", names(alldata3))
names(alldata3)<-gsub("std", "STD", names(alldata3))
names(alldata3)<-gsub("mean", "Mean", names(alldata3))
names(alldata3)<-gsub("\\.Mean", "Mean", names(alldata3))
names(alldata3)<-gsub("\\.X.", "X", names(alldata3))
names(alldata3)<-gsub("\\.Y.", "Y", names(alldata3))
names(alldata3)<-gsub("\\.Z.", "Z", names(alldata3))
names(alldata3)<-gsub("\\...", "", names(alldata3))
names(alldata3)<-gsub("\\..", "", names(alldata3))
names(alldata3)<-gsub("gravity", "Gravity", names(alldata3))
names(alldata3)

##Step 5 create new dataset with average by activity and subject
alldata4<-alldata3 %>%
        group_by(Subject, Activity) %>%
        summarise_all(funs(mean))
alldata4

##Write to final location
write.table(alldata4, "tidy_data.txt", row.name=FALSE)
# You should create one R script called run_analysis.R that does the following.
# 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(tidyr)
library(dplyr)
library(tidyverse)

## Download input file and extract it
destfile <- "GCDw4_data.zip"
# Checking if archieve already exists.
if (!file.exists(destfile)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, destfile=destfile, method="curl")
}  

# Checking if folder exists
if (!file.exists(file.path("data", "UCI HAR Dataset")) ) 
{ 
  unzip(filename) 
} else
{
  print("Files already extracted. Delete UCI HAR Dataset folder to fresh input data")
}

## Loading files:
# Labels...
featurenames<-read.csv("data/UCI HAR Dataset/features.txt",sep = " ",col.names = c("id","label"), header = FALSE)
activitynames<-read.csv("data/UCI HAR Dataset/activity_labels.txt",sep = " ",col.names = c("id","label"), header = FALSE)
# ...and data
xtrain<-read.table("data/UCI HAR Dataset/train/X_train.txt")
xtest<-read.table("data/UCI HAR Dataset/test/X_test.txt")
ytrain<-read.table("data/UCI HAR Dataset/train/y_train.txt", col.names=c("activityid"))
ytest<-read.table("data/UCI HAR Dataset/test/y_test.txt", col.names=c("activityid"))
subjectstrain<-read.table("data/UCI HAR Dataset/train/subject_train.txt", col.names=c("subjectid"))
subjectstest<-read.table("data/UCI HAR Dataset/test/subject_test.txt", col.names=c("subjectid"))
## 1. Merges the training and the test sets to create one data set.
xall<-rbind(xtrain, xtest)
yall<-rbind(ytrain,ytest)
subjall<-rbind(subjectstrain,subjectstest)

## 3. Uses descriptive activity names to name the activities in the data set
#translate ids into readable names
yall$activityid<-activitynames[match(yall$activityid, activitynames$id),]$label
colnames(xall)<-featurenames$label

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Get tidy X set[get col nums for mean & std]
xtidy<-xall[,featurenames[featurenames$label %like% "mean|std",]$id]
## Add columns Subject and Activity
tidyset<-cbind(yall, subjall, xtidy)

## 4. Appropriately labels the data set with descriptive variable names.
# Idea of label rename has been copied from N. Nugroho
names(tidyset)<-gsub("Acc", "Accelerometer", names(tidyset))
names(tidyset)<-gsub("Acc", "Accelerometer", names(tidyset))
names(tidyset)<-gsub("Gyro", "Gyroscope", names(tidyset))
names(tidyset)<-gsub("BodyBody", "Body", names(tidyset))
names(tidyset)<-gsub("Mag", "Magnitude", names(tidyset))
names(tidyset)<-gsub("^t", "Time", names(tidyset))
names(tidyset)<-gsub("^f", "Frequency", names(tidyset))
names(tidyset)<-gsub("tBody", "TimeBody", names(tidyset))
names(tidyset)<-gsub("-mean()", "Mean", names(tidyset), ignore.case = TRUE)
names(tidyset)<-gsub("-std()", "STD", names(tidyset), ignore.case = TRUE)
names(tidyset)<-gsub("-freq()", "Frequency", names(tidyset), ignore.case = TRUE)
names(tidyset)<-gsub("angle", "Angle", names(tidyset))
names(tidyset)<-gsub("gravity", "Gravity", names(tidyset))
# Store full tidy set in the file for final submission
write.table(tidyset, "GCDw4_tidyset.txt", row.name=FALSE)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
meanset<- tidyset %>% group_by(subjectid, activityid) %>%
   summarise_all(list(mean))
# Store created set into file for final submission
write.table(meanset, "GCDw4_resultset.txt", row.name=FALSE)


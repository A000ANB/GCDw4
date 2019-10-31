---
title: "Code Book GCD week 4 assignment"
output: html_document
---

## Code Book

### ERD
Both test and train datasets have X and Y data.  
X has 561 variables - features.  
Y has 1 variable of 6 categories - activities  
Every observesion is conducted on a Subject.  

### Code book

#### 1. Load data into R  
* featurenames<-"data/UCI HAR Dataset/features.txt"  
Loaded 561 obs of 2 variables  
* activitynames<-"data/UCI HAR Dataset/activity_labels.txt"  
Loaded 6 obs of 2 variables
+ xtrain<-read.table("data/UCI HAR Dataset/train/X_train.txt")  
Loaded 7352 obs of 561 variables  
+ xtest<-read.table("data/UCI HAR Dataset/test/X_test.txt")  
Loaded 2947 obs of 561 variables  
+ ytrain<-read.table("data/UCI HAR Dataset/train/y_train.txt")  
Loaded 7352 obs of 1 variable  
+ ytest<-read.table("data/UCI HAR Dataset/test/y_test.txt")  
Loaded 2947 obs of 1 variable  
+ subjectstrain<-read.table("data/UCI HAR Dataset/train/subject_train.txt")  
Loaded 7352 obs of 1 variable  
+ subjectstest<-read.table("data/UCI HAR Dataset/test/subject_test.txt")  
Loaded 2947 obs of 1 variable  
  
#### 2. Merge the training and the test sets to create one data set.  
* Using **rbind** merged xtrain and xtest into xall, ytrain and ytest into yall
and subjecttrain and subjecttest into subjall  
  + xall - 10299 obs of 561 variable  
  + yall - 10299 obs of 1 variable  
  + subjall - 10299 obs of 1 variable  
  
#### 3. Set human readable labels for activities in yall from activitynames  

#### 4. Set human readable column names on xall from featurenames

#### 5. Subset into xtidy from xall only variables having "mean" and "std" in their features
* xtidy - 10299 obs of 79 variables

#### 6. Using **cbind** add Subject, Activity to xtidy set and store it in tidyset
* tidyset - 10299 obs of 81 variables

#### 7. Using **gsub** replace abbreviations in column names of tidyset to human readable ones

#### 8. Store tidyset in "GCDw4_tidyset.txt"

#### 9. From tidyset created a "second"meanset, independent tidy data set with the average of each variable for each activity and each subject.
* meanset - 180 obs of 81 variable

#### 10. Store meanset in "GCDw4_resultset.txt"

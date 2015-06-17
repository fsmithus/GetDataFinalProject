## Interpretation of the UCI HAR mobile phone activity dataset
## - Description:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## - Dataset Source:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## - The root directory contains meta data for two independent but parallel datasets which were collected from
##   pools of 9 test and 21 train individuals.
## - All test/train *.txt files have the same number of rows (2947 for test, 7352 for train).
## - subject_*.txt files contain the ID of the subject who performed the activity (values 1:30)
## - y_*.txt contain activity labels (numeric values 1:6, mapped to strings in activity_labels.txt)
## - A set of X_*, y_*, and subject_* contain the data, activity, and subject, one row per observation.
## - features.txt contains the names of the 561 features ean each X_* file.
## - There are directories named "Inertial Signals" in each test/train datset that, presumably, contain
##   raw gyro and accelerometer data.  Insufficient information was provided about how the raw data was
##   pre-processed into the feature data.  There are references to sliding windows and low-pass filters but
##   since there are no time stamps (explicit nor implied) some of the data has been lost.  For this project
##   we take it on faith that the raw data was traslated into the feature data appropriately.
##
## Basic Processing approach:
## - Setup the environment by loading packages and setting the working directory (if necessary).
## - Read features.txt into a table, filter/message, to get variable names and column indexes.
## - Read activity_labels.txt into a table for simple lookup translation of numeric labels to strings.
## - Read and tidy each test/train datasets independently.
## - Use cbind to aggregate test/train datasets independently.
## - Use rbind to aggregate the two datasets together into one data frame for observations. (data frane data.out)
## - The combined data frame should have columns like subject, activity, *mean*, *sd*.  10299 rows.
## - Step 5 of the assignment calls for an analysis of the average value of each feature per
##   subject (30) & activity (6).  180 rows.  (data frame analysis.out)

## Load required packages.
library(dplyr)
library(reshape2)

## This script must be run with the working directory set to a folder that contains the folder "UCI HAR Dataset".
## Set the working directory to the location of the dataset folder.  Modify path as appropriate and uncomment.
# setwd("Getting and Cleaning Data")

## Get list of feature names.
features <- tbl_df(read.table("UCI HAR Dataset/features.txt",col.names=c("index","feature.name")))

## The feature names provided in the dataset contain parentheses and commas, which do not work well for column names.
## Strip the parentheses, and replace commas with dashes to transform feature.names into variable names.
## Add a "select" column to indicate which features will be propagated to the output dataset (all features
## related to means and standard deviations).
features <- features %>% mutate(variable.name=(gsub(",","-",gsub("\\)","",gsub("\\(","",feature.name))))) %>%
        mutate(select=(grepl("*mean*",variable.name) | grepl("*std*",variable.name)))

## Filter the selected rows (features whose names contain the strings "mean" or "std").
features.ms <- subset(features,features$select)

## write the selected variable names to a text file as the start of the Code Book.
write.table(features.ms$variable.name,"variable_list.txt",col.names=FALSE,row.names=FALSE,quote=FALSE)

## Get activity labels.
activity.labels <- tbl_df(read.table("UCI HAR Dataset//activity_labels.txt",col.names=c("label","activity")))

## Process the test dataset.
data.test <- tbl_df(read.table("UCI HAR Dataset//test//X_test.txt"))
colnames(data.test) <- features$variable.name
data.test.out <- data.test[,features.ms$index]
subjects.test <- tbl_df(read.table("UCI HAR Dataset//test//subject_test.txt",col.names=c("subject")))
labels.test <- tbl_df(read.table("UCI HAR Dataset//test//y_test.txt",col.names=c("label")))

## Process the train dataset.
data.train <- tbl_df(read.table("UCI HAR Dataset//train//X_train.txt"))
colnames(data.train) <- features$variable.name
data.train.out <- data.train[,features.ms$index]
subjects.train <- tbl_df(read.table("UCI HAR Dataset//train//subject_train.txt",col.names=c("subject")))
labels.train <- tbl_df(read.table("UCI HAR Dataset//train//y_train.txt",col.names=c("label")))

## Snap the subjects, activities, and observations together into one data frame per (test/train) dataset.
t.test  <- cbind(subjects.test$subject,sapply(labels.test,function(i) activity.labels[i,"activity"]),data.test.out)
t.train <- cbind(subjects.train$subject,sapply(labels.train,function(i) activity.labels[i,"activity"]),data.train.out)
## Rationalize the column names of the first two columns, which get anonymous names from their construction.
colnames(t.test)[1:2]  <- c("subject","activity")
colnames(t.train)[1:2] <- c("subject","activity")

## Snap test and train datasets into on data frame for output.
data.out <- rbind(t.test,t.train)

## At this point data.out contains observations selected measurements of subjects doing activities.
## Write the processed observations dataset to file.
write.table(data.out,"observations_out.txt",row.names=FALSE)

## The output file can be read back in using:
## read.table("data_out.txt",header=TRUE)

## Perform the Step 5 analysis to calculate the means of all feature variables per subject and activity.
## Melt wide to long, then take average to get means of all variables back into wide form.
analysis.out <- dcast(
        melt(data.out,id=c("subject","activity"),measure.vars=features.ms$variable.name),
        subject+activity ~ variable,mean)

## Write analysis data to file.
write.table(analysis.out,"analysis_out.txt",row.names=FALSE)

## The output file can be read back in using:
## read.table("analysis_out.txt",header=TRUE)

# GetDataFinalProject
Course final project for Getting and Cleaning Data

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
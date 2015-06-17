# GetDataFinalProject
Course final project for Getting and Cleaning Data

The purpose of the exercise was to practice scrubbing large(-ish) poorly-documented data, to make it suitable
for subsequent analysis.  Deliverables include:
* This README file
* A tidy dataset with averaged measurements per participants and activities
* A code book describing the tidy variables

# UCI HAR Mobile Phone Activity Dataset
* [Original Description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
* [Original Dataset Source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* The root directory contains meta data for two independent but parallel datasets which were collected from
pools of 9 test and 21 train subjects/participants.
* features.txt contains the names of the 561 features in each X_* file, which are described in features_info.txt.
* All test/train *.txt files have the same number of rows (2947 for test, 7352 for train).
* subject_*.txt files contain the ID of the study subject/participant who performed the activity (values 1:30)
* y_*.txt files contain activity labels (numeric values 1:6, mapped to strings in activity_labels.txt)
* X_*.txt files contain feature data that was collected during the study
* A set of X_*, y_*, and subject_* contain the data, activity, and subject, one row per observation.
* The orignal dataset contains directories named "Inertial Signals" in each test/train datset that, presumably,
contain raw gyro and accelerometer data.  Insufficient information was provided about how the raw data was
pre-processed into the feature data.  There are references to sliding windows and low-pass filters but
since there are no time stamps (explicit nor implied) some of the data has been lost.  For this project
I have taken on faith that the raw data was traslated into the feature data appropriately.

# Running the Analysis
The script run_analysis.R massages the original data into the tidy averaged dataset.  It must be run with in
the working directory which contains the root of the dataset folder structure where the original ZIP file was
uncompressed.  That is, "UCI HAR Dataset" must be a folder in the R environment working directory.

Once the analysis is run, it can be read from the resulting file with the following command:
```
read.table("analysis_out.txt",header=TRUE)
```

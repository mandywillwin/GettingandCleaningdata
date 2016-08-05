Cleaning Data Samsung research

Course project of Getting and Cleaning Data (Week3) assignment

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Procedure

Preparation Step1: Download input files

Download input files archive on to local folder from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Preparation Step2: Unzip the files into your working folder

Preparation Step3: Move the following files to your working directory of R

X_train.txt
X_test.txt
subject_test.txt
subject_train.txt
y_test.txt
y_train.txt
features.txt
activity_labels.txt ##Assignment Step1: Merge the training and the test sets to create one data set
(a): Read files Read the first 6 files above to data frames for data merge/combine
(b): Read files
(c)Combine train data and subject
(d): Set columnname for Subject as "Subject_ID"
(e)Combine the output of above with subject
(f)Combine the output of above with Activity Data
(g)Set columnname for Activity as "Activity_ID" Now the Train data is complete with all required attributes
(h)Repeat the steps (c) to (g) above on test data
(i)Combine the train data and test data prepared from (g) and (i) above
It completes the Step1 of the assignment

Assignment Step:2 Extract only the measurements on the mean and standard deviation for each measurement

(a): Read feature data
(b): Identify measures that contain strings mean() and std() and create indices Note: The meanFreq() observations were omitted as they don't have corresponding std() measures.
(c): Extract only the measurements on the mean() and std() from the combined data using the indices
(d): Remove "()" from column names
(e): Capitalize M of mean
(f): Capitalize S of std
(g): Remove "-" in column names
It completes the Assignment Step2

Assignment Step:3 Uses descriptive activity names to name the activities in the data set

(a):Read activity label into a data frame
(b):Remove "_" and convert the string to lower case
(c):Make the first letter of second word to uppercase
(d):Combine the train and test labels
(e):Set the column name of Activity to "activity" It completes the Step3
Assignment Step:4 Appropriately labels the data set with descriptive variable names

(a):Combine train and test subjects
(b):Set columnname subject
(c):Combine subject and label with the combined train-test data
(d):Write the data out to a local text file
Assignment Step:5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

(a):Find the size of the dimensions namely Subject count, Activity
(b):Loop through the combination to find the average of the measurements
(c):Write the data out to a file

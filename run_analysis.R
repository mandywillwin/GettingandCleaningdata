## Course project - Assignment
## Step:1
##	**Merge the training and the test sets to create one data set**
##	****************************************************************
##  (a)	Pre-requisite - download the file
##	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
##  (b)	extract them to a folder named ass
##	(c) move all the .txt files to /ass folder
##	(d)	set the working directory to ass
##	(e)	read train and test data into data.frames 
##	the following files will be merged to meet the requirements of step:1
##	x_train.txt,x_test.txt,subject_test.txt,
##	subject_train.txt,y_test.txt and y_train.txt 
## 	(f)	all the files are read and combined below


trainData <- read.table("./X_train.txt")
testData <- read.table("./X_test.txt")
testSubject <- read.table("./subject_test.txt")
trainSubject <- read.table("./subject_train.txt")
testLabel <- read.table("./y_test.txt") 
trainLabel <- read.table("./y_train.txt")

##	combine train data and subject
trainSubjectData <- cbind(trainData,trainSubject)
##	set columnname for Subject
colnames(trainSubjectData)[562] <- "Subject_ID"
##	combine trainSubjectData with Activity Data
trainSubjectActivityData <- cbind(trainSubjectData,trainLabel)
##	set columnname for Activity
colnames(trainSubjectActivityData)[563] <- "Activity_ID"

## repeat the above steps for test data

##	combine test data and subject
testSubjectData <- cbind(testData,testSubject)
##	set columnname for Subject
colnames(testSubjectData)[562] <- "Subject_ID"
##	combine testSubjectData with Activity Data
testSubjectActivityData <- cbind(testSubjectData,testLabel)
##	set columnname for Activity
colnames(testSubjectActivityData)[563] <- "Activity_ID"

## combine the resultant train and test data
combinedTrainTestData <- rbind(trainSubjectActivityData,testSubjectActivityData)


## Step:2
##	**Extract only the measurements on the mean and standard deviation for each measurement**
##	******************************************************************************************

featureLabel <- read.table("./features.txt")
## Identifies measures that contain strings mean() and std() 
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", featureLabel[, 2])
##	Extracts only the measurements on the mean() and std()
combinedTrainTestData <- combinedTrainTestData[, meanStdIndices]
# remove "()" from column names
names(combinedTrainTestData) <- gsub("\\(\\)", "", featureLabel[meanStdIndices, 2]) 
# capitalize M of mean
names(combinedTrainTestData) <- gsub("mean", "Mean", names(combinedTrainTestData)) 
# capitalize S od std
names(combinedTrainTestData) <- gsub("std", "Std", names(combinedTrainTestData)) 
# remove "-" in column names 
names(combinedTrainTestData) <- gsub("-", "", names(combinedTrainTestData)) 


## Step:3
##	**Uses descriptive activity names to name the activities in the data set *
##	******************************************************************************************

# read activity label and clean
activityLabel <- read.table("./activity_labels.txt")
activityLabel[, 2] <- tolower(gsub("_", "", activityLabel[, 2]))
substr(activityLabel[2, 2], 8, 8) <- toupper(substr(activityLabel[2, 2], 8, 8))
substr(activityLabel[3, 2], 8, 8) <- toupper(substr(activityLabel[3, 2], 8, 8))

#	combine train and test labels
combineLabel <- rbind(trainLabel, testLabel)

actLabel <- activityLabel[combineLabel[, 1], 2]
combineLabel[, 1] <- actLabel
names(combineLabel) <- "activity"
#View(combineLabel)

## Step:4
##	**Appropriately labels the data set with descriptive variable names*
##	******************************************************************************************

#	combine train and test subjects
combineSubject <- rbind(trainSubject, testSubject)
# set columnname subject
names(combineSubject) <- "subject"
cleanedData <- cbind(combineSubject, combineLabel, combinedTrainTestData)
colnames(cleanedData)

# write out the 1st dataset
write.table(cleanedData, "merged_data.txt") 

## Step:5
##	**From the data set in step 4, creates a second, independent tidy data set 
##	with the average of each variable for each activity and each subject *
##	******************************************************************************************

subjectLen <- length(table(combineSubject)) 
activityLen <- dim(activityLabel)[1] 
columnLen <- dim(cleanedData)[2]

result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
    for(j in 1:activityLen) {
        result[row, 1] <- sort(unique(combineSubject)[, 1])[i]
        result[row, 2] <- activityLabel[j, 2]
        bool1 <- i == cleanedData$subject
        bool2 <- activityLabel[j, 2] == cleanedData$activity
        result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
        row <- row + 1
    }
}
head(result)

# write out the tidy dataset
write.table(result, "tidy_data_with_average.txt",row.name=FALSE) 

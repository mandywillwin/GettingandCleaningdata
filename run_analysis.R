# GettingandCleaningdata
no description

# Step 1

X_test <- read.table("./test/X_test.txt",header=FALSE)
y_test <- read.table("./test/y_test.txt",header=FALSE)
subject_test <- read.table("./test/subject_test.txt",header=FALSE)
X_train <- read.table("./train/X_train.txt",header=FALSE)
y_train <- read.table("./train/y_train.txt",header=FALSE)
subject_train <- read.table("./train/subject_train.txt",header=FALSE)
activity_labels <- read.table("./activity_labels.txt",header=FALSE,colClasses="character")
features <- read.table("./features.txt",header=FALSE,colClasses="character")

# Step 2

mean_std_features <- grepl("mean|std", features$V2)
features <- features[mean_std_features,]
X_test <- X_test[,mean_std_features]
X_train <- X_train[,mean_std_features]

### Step 3

y_test$V1 <- factor(y_test$V1,levels=activity_labels$V1,labels=activity_labels$V2)
y_train$V1 <- factor(y_train$V1,levels=activity_labels$V1,labels=activity_labels$V2)

colnames(X_test) <- features$V2
colnames(y_test) <- "Activity"
colnames(subject_test) <- "Subject"

colnames(X_train) <- features$V2
colnames(y_train) <- "Activity"
colnames(subject_train) <- "Subject"

# Step 4

test_data <- cbind(X_test,y_test)
test_data <- cbind(test_data,subject_test)
train_data <- cbind(X_train,y_train)
train_data <- cbind(train_data,subject_train)
data <- as.data.table(rbind(test_data,train_data))


# Step 5

tidy <- data[,lapply(.SD,mean),by = "Activity,Subject"]
tidy <- tidy[order(Subject),]
write.table(tidy,file="tidy.txt",row.names = FALSE)

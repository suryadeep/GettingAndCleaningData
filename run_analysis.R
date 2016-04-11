# Download and unzip the dataset:
filename <- "getdata_dataset.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# load rehaspe2 library for melt() and dcast() functions
# used to melt and cast merged datasets later on
library(reshape2)

# Load activity labels + features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

## Extract only the data on mean and standard deviation
reqdFeatures <- grep(".*mean.*|.*std.*", features[,2])
reqdFeatures.names <- features[reqdFeatures,2]
reqdFeatures.names = gsub('-mean', 'Mean', reqdFeatures.names)
reqdFeatures.names = gsub('-std', 'Std', reqdFeatures.names)
reqdFeatures.names <- gsub('[-()]', '', reqdFeatures.names)


# Load the training sets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[reqdFeatures]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

# Load the test sets
test <- read.table("UCI HAR Dataset/test/X_test.txt")[reqdFeatures]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

## Merge the training and the test sets to create one data set
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", reqdFeatures.names)

## Use descriptive activity names to name the activities in the data set
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

## Appropriately labels the data set with descriptive variable names
allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

## Create a second, independent tidy data set with the average of each variable for each activity and each subject
write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)

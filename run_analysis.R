#The purpose of this project is to demonstrate your ability to collect, 
#work with, and clean a data set. The goal is to prepare tidy data that can be 
#used for later analysis. You will be graded by your peers on a series of yes/no 
#questions related to the project. You will be required to submit: 1) a tidy data
#set as described below, 2) a link to a Github repository with your script for 
#performing the analysis, and 3) a code book that describes the variables, the 
#data, and any transformations or work that you performed to clean up the data 
#called CodeBook.md. You should also include a README.md in the repo with your 
#scripts. This repo explains how all of the scripts work and how they are connected.  

# 1. Merges the training and the test sets to create one data set:

XTrain <- read.table("train/X_train.txt")
XTest <- read.table("test/X_test.txt")
X <- rbind(XTrain, XTest)

YTrain <- read.table("train/y_train.txt")
YTest <- read.table("test/y_test.txt")
Y <- rbind(YTrain, YTest)

STrain <- read.table("train/subject_train.txt")
STest <- read.table("test/subject_test.txt")
S <- rbind(STrain, STest)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
Good_Index <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, Good_Index]
names(X) <- features[Good_Index, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(S) <- "subject"
cleaned <- cbind(S, Y, X)
write.table(cleaned, "merged_clean_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

num_Activities = length(activities[,1])
num_Subjects = length(unique(S)[,1])
unique_Subjects = unique(S)[,1]
num_Cols = dim(cleaned)[2]
result = cleaned[1:(num_Subjects*num_Activities), ]

row = 1
for (s in 1:num_Subjects) {
        for (a in 1:num_Activities) {
                result[row, 1] = unique_Subjects[s]
                result[row, 2] = activities[a, 2]
                tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
                result[row, 3:num_Cols] <- colMeans(tmp[, 3:num_Cols])
                row = row+1
        }
}
write.table(result, "data_set_with_the_averages.txt")
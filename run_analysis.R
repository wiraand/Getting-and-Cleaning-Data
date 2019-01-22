#Load required packages
packages <- c("data.table", "reshape2")
sapply(packages,
       require,
       character.only = TRUE,
       quietly = TRUE)

#Download dataset
fileUrl <-
    "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists("data")) {
    dir.create("data")
}

download.file(fileUrl, "./data/Dataset.zip", method = "curl")
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

#Load activity labels and features then prepare requested measurement
#(mean, standard deviation) for column name
activityLabel <-
    fread(
        "./data/UCI HAR Dataset/activity_labels.txt",
        col.names = c("activityID", "activityName")
    )

feature <-
    fread("./data/UCI HAR Dataset/features.txt",
          col.names = c("featureID", "featureName"))

featReq <- grep("mean|std", feature[, featureName])

measurement <- feature[featReq, featureName]

#Load train dataset and extracts only the measurements on the mean and standard
#deviation for each measurement
xTrain <-
    fread("./data/UCI HAR Dataset/train/X_train.txt")[, featReq, with = FALSE]
setnames(xTrain, colnames(xTrain), measurement)

yTrain <-
    fread("./data/UCI HAR Dataset/train/Y_train.txt",
          col.names = c("activity"))

subjectTrain <-
    fread("./data/UCI HAR Dataset/train/subject_train.txt",
          col.names = c("subjectID"))

train <- cbind(subjectTrain, yTrain, xTrain)

#Load test dataset and extracts only the measurements on the mean and standard
#deviation for each measurement
xTest <-
    fread("./data/UCI HAR Dataset/test/X_test.txt")[, featReq, with = FALSE]

setnames(xTest, colnames(xTest), measurement)

yTest <-
    fread("./data/UCI HAR Dataset/test/Y_test.txt",
          col.names = c("activity"))

subjectTest <-
    fread("./data/UCI HAR Dataset/test/subject_test.txt",
          col.names = c("subjectID"))

test <- cbind(subjectTest, yTest, xTest)

#Merges the training and the test sets to create one data set.
#Use descriptive activity names to name the activities in the data set
tidyData <- rbind(train, test)
tidyData[["subjectID"]] <- as.factor(tidyData[, subjectID])
tidyData[["activity"]] <-
    factor(tidyData[, activity],
           levels = activityLabel[["activityID"]],
           labels = activityLabel[["activityName"]])

#Create independent tidy data set with the average of each variable for each
#activity and each subject
tidyData <- melt(tidyData, id = c("subjectID", "activity"))
tidyData <-
    dcast(tidyData, subjectID + activity ~ variable, fun.aggregate = mean)

#Create a txt file with write.table() using row.name=FALSE
write.table(tidyData,
            file = "./data/activityRecognition.txt",
            quote = FALSE,
            row.names = FALSE)
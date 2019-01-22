# Getting and Cleaning Data 

## Study case

Human Activity Recognition Using Smartphones Data Set

## Dataset

A full description is available at the site where the data was obtained: [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#)

## Code

You can get R code in the document as follows:
1. [run_analysis.R](https://github.com/wiraand/Getting-and-Cleaning-Data/blob/master/run_analysis.R)
2. [CodeBook](https://github.com/wiraand/Getting-and-Cleaning-Data/blob/master/CodeBook.md)

## Code description

1. Download the dataset from source
2. Load activity labels and features then prepare requested measurement (mean, standard deviation) for column name
3. Load train dataset and extracts only the measurements on the mean and standard deviation for each measurement
4. Load train dataset and extracts only the measurements on the mean and standard deviation for each measurement
5. Merges the training and the test sets to create one data set. Use descriptive activity names to name the activities in the data set
6. Create independent tidy data set with the average of each variable for each activity and each subject
7. Create a txt file with write.table() using row.name=FALSE into activityRecognition.txt

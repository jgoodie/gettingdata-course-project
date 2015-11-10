#################################################################################################
# Notes: 
#
# SubjectID: Test subject ID
# Activity: 1=WALKING, 2=WALKING_UPSTAIRS, 3=WALKING_DOWNSTAIRS, 4=SITTING, 5=STANDING, 6=LAYING
# Case: Created a new column for train vs test under the Case variable. 1 = train, 2=test
# 
# 
#
#################################################################################################
library(data.table)

# Create GettingData folder
if(!file.exists("GettingData")){
        dir.create("GettingData")
}

#Zipped data URL
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Check for existence of zipped data file if doesn't exist download and extract the data to the GettingData folder.
if(!file.exists("./GettingData/getdata_projectfiles_UCI HAR Dataset.zip")){
        download.file(fileURL, destfile = "./GettingData/getdata_projectfiles_UCI HAR Dataset.zip")
        unzip("./GettingData/getdata_projectfiles_UCI HAR Dataset.zip", exdir = "./GettingData")
        list.files("./GettingData")
        dataDownloaded <- date()
        dataDownloaded
}

# This is ugly.... but here goes

# Grab the training and test data: Subject_*, x_*, y_*
subject_train <- read.table("GettingData/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("GettingData/UCI HAR Dataset/test/subject_test.txt")
y_train <- read.table("GettingData/UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("GettingData/UCI HAR Dataset/test/y_test.txt")
x_train <- read.table("GettingData/UCI HAR Dataset/train/x_train.txt")
x_test <- read.table("GettingData/UCI HAR Dataset/test/x_test.txt")

# Start preparing and mashing/merging things together
features <- read.table("GettingData/UCI HAR Dataset/features.txt")
features<-as.vector(features[,2])
Subject_ID <- rbind(subject_train,subject_test)
colnames(Subject_ID) <- "Subject_ID"
Case <- c(rep(1,7352), rep(2,2947))
Activity <- rbind(y_train,y_test)
colnames(Activity) <- "Activity"
x_set <- rbind(x_train, x_test)
colnames(x_set) <- features
# Mash everything together like Victor Frankenstein!
merged <- cbind(Subject_ID, Case, Activity, x_set)

# Grep for "[Mm]ean" and "std" 
featuremeans <- grep("[Mm]ean",features)
featurestd <- grep("std",features)

# Fix this here... don't need all of x_train, only mean and std
# training <- cbind(training, x_train)
# for(i in 1:length(featuremeans)){
#         training <- cbind(training,x_train[features[featuremeans[i]]])
# }

#Case <- c(rep(1,7352), rep(2,2947))
          




#################################################################################################
# Notes: 
#
# SubjectID: Test subject ID and column name
# 
# Activity: 1=WALKING, 2=WALKING_UPSTAIRS, 3=WALKING_DOWNSTAIRS, 4=SITTING, 5=STANDING, 6=LAYING
# 
# Case: Created a new column for training vs test under the Case variable. Values are either 
# training or testing.
# 
# The features variable grabs all the features from the features.txt file and assignes them as 
# column names. Note further down the feature names will need
# 
# The merged variable is the whole data set mashed together.
#
#################################################################################################

# Load any additional libraries
library(data.table)
library(dplyr)

# Check for and create GettingData folder
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

# This is ugly.... but here goes...

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
subject_id <- rbind(subject_train,subject_test)
colnames(subject_id) <- "subject_ID"
#Case <- c(rep(1,7352), rep(2,2947))
case <- c(rep("training",7352), rep("testing",2947))
activity <- rbind(y_train,y_test)
colnames(activity) <- "activity"
x_set <- rbind(x_train, x_test)
colnames(x_set) <- features

# Mash everything together like Victor Frankenstein! FrankenData!
# Curious how big this is? run this: print(object.size(merged), units = "Mb")
merged <- cbind(subject_id, case, activity, x_set)

# Note: dplyr doesn't like column names gathered from features.txt and it needs to be fixed.
# here is the code to fix the column names. 
# Will need to include the fixed feature column names in the code book
new_names<-make.names(names = names(merged), unique = TRUE, allow_ = TRUE)

# Get rid of the periods and make all lower case
for(i in 1:length(new_names)){
        new_names[i] <- tolower(gsub("\\.","",new_names[i]))        
}

names(merged) <- new_names

# Pare down the data using select() from dplyr
pared_data<-select(merged,subject_id,case,activity,contains("mean"),contains("std"))

# Fix the Activity column to reflect the actual activity names
# I don't like this but I couldn't figure out how to do this with mutate() or transform() or some other more elegant method.
# Activity: 1=WALKING, 2=WALKING_UPSTAIRS, 3=WALKING_DOWNSTAIRS, 4=SITTING, 5=STANDING, 6=LAYING
for(j in 1:length(pared_data$activity)){
        #print(pared_data[j,3])
        if(pared_data[j,3] == 1){ 
                pared_data[j,3] <- "WALKING"
        }
        else if(pared_data[j,3] == 2) {
                pared_data[j,3] <- "WALKING_UPSTAIRS" 
        }
        else if(pared_data[j,3] == 3){
                pared_data[j,3] <- "WALKING_DOWNSTAIRS" 
        }
        else if(pared_data[j,3] == 4) {
                pared_data[j,3] <- "SITTING"
        }
        else if(pared_data[j,3] == 5) {
                pared_data[j,3] <- "STANDING"
        }
        else if(pared_data[j,3] == 6) {
                pared_data[j,3] <- "LAYING"
        }
        else {
                pared_data[j,3] <- "NA"  
        }
}



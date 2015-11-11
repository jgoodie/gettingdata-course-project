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
Subject_ID <- rbind(subject_train,subject_test)
colnames(Subject_ID) <- "Subject_ID"
#Case <- c(rep(1,7352), rep(2,2947))
Case <- c(rep("training",7352), rep("testing",2947))
Activity <- rbind(y_train,y_test)
colnames(Activity) <- "Activity"
x_set <- rbind(x_train, x_test)
colnames(x_set) <- features

# Mash everything together like Victor Frankenstein! FrankenData!
# Curious how big this is? run this: print(object.size(merged), units = "Mb")
merged <- cbind(Subject_ID, Case, Activity, x_set)

# Note: dplyr doesn't like column names gathered from features.txt and it needs to be fixed.
# here is the code to fix the column names. 
# I kind of don't like the new variable names because they're.... well... ugly.
# But then again the features names were also pretty ugly.
# Will need to include the fixed feature column names in the code book
new_names<-make.names(names = names(merged), unique = TRUE, allow_ = TRUE)
names(merged) <- new_names

# Pare down the data using select() from dplyr
pared_data<-select(merged,Subject_ID,Case,Activity,contains("mean"),contains("std"))





###################################################################################################
# Scratch Notes and code. Ignore this.
##################################################################################################
# Start paring the data down. We don't want all of the data as we are only 
# interested in means and standard deviations.
# Grep for "[Mm]ean" and "std" 
# foo<-select(merged,contains("mean"))
# bar<-select(merged,contains("std"))
# featuremeans <- grep("[Mm]ean",features)
# featurestd <- grep("std",features)

#################################################################
# Notes: 
# Adding a new column to a data.frame
# X$var4 <- rnorm(5) creates a new var4 column
# Can also use cbind
# Y <- bind(X, rnorm(5)) does the same thing
# rbind binds rows
#
# Look into plyr to help pare down the data ??? Maybe ???
#
##################################################################


# for(i in 1:length(featuremeans)){
#         training <- cbind(training,x_train[features[featuremeans[i]]])
# }

#Case <- c(rep(1,7352), rep(2,2947))
          




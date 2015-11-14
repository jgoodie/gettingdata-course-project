#################################################################################################
# Notes: 
#
# subject_id: Test subject ID and column name
# 
# activity: 1=WALKING, 2=WALKING_UPSTAIRS, 3=WALKING_DOWNSTAIRS, 4=SITTING, 5=STANDING, 6=LAYING
# 
# The features variable grabs all the features from the features.txt file and assignes them as 
# column names. Note there are dupliates in this but this is not as issue as we will create
# unique varible names and clean up the extraneous characters then set to lower case.
# 
# The merged variable is the whole data set mashed together.
#
# The pared_data variable contains subject_id, activity, mean and standard deviation 
# data.
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
activity <- rbind(y_train,y_test)
colnames(activity) <- "activity"
x_set <- rbind(x_train, x_test)
colnames(x_set) <- features

# Mash everything together like Victor Frankenstein! FrankenData!
# Curious how big this is? run this: print(object.size(merged), units = "Mb")
merged <- cbind(subject_id, activity, x_set)

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
pared_data<-select(merged,subject_id,activity,contains("mean"),contains("std"))

# Fix the Activity column to reflect the actual activity names
# I don't like this but I couldn't figure out how to do this with mutate() or transform() or some other more elegant method.
# Activity: 1=WALKING, 2=WALKING_UPSTAIRS, 3=WALKING_DOWNSTAIRS, 4=SITTING, 5=STANDING, 6=LAYING
for(j in 1:length(pared_data$activity)){
        if(pared_data[j,"activity"] == 1){ 
                pared_data[j,"activity"] <- "WALKING"
        }
        else if(pared_data[j,"activity"] == 2) {
                pared_data[j,"activity"] <- "WALKING_UPSTAIRS" 
        }
        else if(pared_data[j,"activity"] == 3){
                pared_data[j,"activity"] <- "WALKING_DOWNSTAIRS" 
        }
        else if(pared_data[j,"activity"] == 4) {
                pared_data[j,"activity"] <- "SITTING"
        }
        else if(pared_data[j,"activity"] == 5) {
                pared_data[j,"activity"] <- "STANDING"
        }
        else if(pared_data[j,"activity"] == 6) {
                pared_data[j,"activity"] <- "LAYING"
        }
        else {
                # This should never happen..... of course never say never...
                pared_data[j,"activity"] <- "NA"  
        }
}

# the paired data set with mean and standard deviations grouped by subject_id and activity
merged_tidy <- pared_data %>% group_by(subject_id, activity)

# summarized data with the mean of each variable.
means_tidy <- merged_tidy %>% summarize_each(funs(mean(., na.rm = TRUE)))

# write the data out to GettingData-CourseProject-TidyMeans.txt
write.table(means_tidy, file = "./GettingData/GettingData-CourseProject-TidyMeans.txt", row.name=FALSE)

##############################################################################################
#
# Extra stuff to help me write the code book
#
# Grab the original names from features.txt
original_names <- c("subject_id", "activity", features)
# Create a new data.frame with the original features names and the fixed names
cb <- cbind(original_names, new_names)
# make sure it's a data.frame
cb <- as.data.frame(cb)
# filter for only the mean and stardard deviation observations as wellas as subject_id and activity
cb <- filter(cb, grepl("subject_id|activity|mean|std", original_names))
#write out data fram to Codebook-features.txt. THIS IS NOT THE CODE BOOK.
write.table(cb, file = "./GettingData/Codebook-features.txt", row.name=FALSE)
#
#############################################################################################

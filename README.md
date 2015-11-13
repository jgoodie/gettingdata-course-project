# Coursera Getting and Cleaning Data Course Project

Repo for the Coursera Getting and Cleaning Data course project


Data Set used: [Data Set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


The run_analysis.R script takes the Human Activity Recognition Using Smartphones Data Set and merges 
and tidies all the testing and training data into one merged data set. See merged variable in script. 
Varible names are taken from the features.txt file and are coerced to be unique, then further 
processed to remove periods, dashes and parentheses. Finally all variable names are forced to lower
case. The data set is then pared down to only the mean and standard deviation observations. See 
pared_data variable in the script. The data is then ordered by subject_id and activity and stored in the 
merged_tidy variable in the script. Finally the the mean is taken for all the observations and written to
GettingData-CourseProject-TidyMeans.txt


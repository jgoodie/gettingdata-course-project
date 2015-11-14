# Code Book for Coursera Getting and Cleaning Data Course Project


Repeating README.md here for sake of clarity.


Data Set used: [Data Set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


The run_analysis.R script takes the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and merges 
and all the testing and training data into one merged data set. See "merged" variable in script. 
Varible names are taken from the features.txt file and are coerced to be unique, then further 
processed to remove periods, dashes and parentheses. Finally all variable names are forced to lower
case. The data set is then pared down to only the mean and standard deviation observations. See 
"pared_data" variable in the script. The data is then ordered by "subject_id" and "activity" and stored in the 
"merged_tidy" variable in the script. Finally the the mean is taken for all the observations, stored in the 
"means_tidy" variable and written to the file GettingData-CourseProject-TidyMeans.txt


Below is the translation from the features.txt to the variable names in GettingData-CourseProject-TidyMeans.txt


Original Feature Name 				New Variable Name

"subject_id"						"subject_id"

"activity" 							"activity"

"tBodyAcc-mean()-X" 				"tbodyaccmeanx"

"tBodyAcc-mean()-Y" 				"tbodyaccmeany"

"tBodyAcc-mean()-Z" 				"tbodyaccmeanz"

"tBodyAcc-std()-X" 					"tbodyaccstdx"

"tBodyAcc-std()-Y" 					"tbodyaccstdy"

"tBodyAcc-std()-Z" 					"tbodyaccstdz"

"tGravityAcc-mean()-X" 				"tgravityaccmeanx"

"tGravityAcc-mean()-Y" 				"tgravityaccmeany"

"tGravityAcc-mean()-Z" 				"tgravityaccmeanz"

"tGravityAcc-std()-X" 				"tgravityaccstdx"

"tGravityAcc-std()-Y" 				"tgravityaccstdy"

"tGravityAcc-std()-Z" 				"tgravityaccstdz"

"tBodyAccJerk-mean()-X" 			"tbodyaccjerkmeanx"

"tBodyAccJerk-mean()-Y" 			"tbodyaccjerkmeany"

"tBodyAccJerk-mean()-Z" 			"tbodyaccjerkmeanz"

"tBodyAccJerk-std()-X" 				"tbodyaccjerkstdx"

"tBodyAccJerk-std()-Y" 				"tbodyaccjerkstdy"

"tBodyAccJerk-std()-Z" 				"tbodyaccjerkstdz"

"tBodyGyro-mean()-X" 				"tbodygyromeanx"

"tBodyGyro-mean()-Y" 				"tbodygyromeany"

"tBodyGyro-mean()-Z" 				"tbodygyromeanz"

"tBodyGyro-std()-X" 				"tbodygyrostdx"

"tBodyGyro-std()-Y" 				"tbodygyrostdy"

"tBodyGyro-std()-Z" 				"tbodygyrostdz"

"tBodyGyroJerk-mean()-X" 			"tbodygyrojerkmeanx"

"tBodyGyroJerk-mean()-Y" 			"tbodygyrojerkmeany"

"tBodyGyroJerk-mean()-Z" 			"tbodygyrojerkmeanz"

"tBodyGyroJerk-std()-X" 			"tbodygyrojerkstdx"

"tBodyGyroJerk-std()-Y" 			"tbodygyrojerkstdy"

"tBodyGyroJerk-std()-Z" 			"tbodygyrojerkstdz"

"tBodyAccMag-mean()" 				"tbodyaccmagmean"

"tBodyAccMag-std()" 				"tbodyaccmagstd"

"tGravityAccMag-mean()" 			"tgravityaccmagmean"

"tGravityAccMag-std()" 				"tgravityaccmagstd"

"tBodyAccJerkMag-mean()" 			"tbodyaccjerkmagmean"

"tBodyAccJerkMag-std()" 			"tbodyaccjerkmagstd"

"tBodyGyroMag-mean()" 				"tbodygyromagmean"

"tBodyGyroMag-std()" 				"tbodygyromagstd"

"tBodyGyroJerkMag-mean()" 			"tbodygyrojerkmagmean"

"tBodyGyroJerkMag-std()" 			"tbodygyrojerkmagstd"

"fBodyAcc-mean()-X" 				"fbodyaccmeanx"

"fBodyAcc-mean()-Y" 				"fbodyaccmeany"

"fBodyAcc-mean()-Z" 				"fbodyaccmeanz"

"fBodyAcc-std()-X" 					"fbodyaccstdx"

"fBodyAcc-std()-Y" 					"fbodyaccstdy"

"fBodyAcc-std()-Z" 					"fbodyaccstdz"

"fBodyAcc-meanFreq()-X" 			"fbodyaccmeanfreqx"

"fBodyAcc-meanFreq()-Y" 			"fbodyaccmeanfreqy"

"fBodyAcc-meanFreq()-Z" 			"fbodyaccmeanfreqz"

"fBodyAccJerk-mean()-X" 			"fbodyaccjerkmeanx"

"fBodyAccJerk-mean()-Y" 			"fbodyaccjerkmeany"

"fBodyAccJerk-mean()-Z" 			"fbodyaccjerkmeanz"

"fBodyAccJerk-std()-X" 				"fbodyaccjerkstdx"

"fBodyAccJerk-std()-Y" 				"fbodyaccjerkstdy"

"fBodyAccJerk-std()-Z" 				"fbodyaccjerkstdz"

"fBodyAccJerk-meanFreq()-X" 		"fbodyaccjerkmeanfreqx"

"fBodyAccJerk-meanFreq()-Y" 		"fbodyaccjerkmeanfreqy"

"fBodyAccJerk-meanFreq()-Z" 		"fbodyaccjerkmeanfreqz"

"fBodyGyro-mean()-X" 				"fbodygyromeanx"

"fBodyGyro-mean()-Y" 				"fbodygyromeany"

"fBodyGyro-mean()-Z" 				"fbodygyromeanz"

"fBodyGyro-std()-X" 				"fbodygyrostdx"

"fBodyGyro-std()-Y" 				"fbodygyrostdy"

"fBodyGyro-std()-Z" 				"fbodygyrostdz"

"fBodyGyro-meanFreq()-X" 			"fbodygyromeanfreqx"

"fBodyGyro-meanFreq()-Y" 			"fbodygyromeanfreqy"

"fBodyGyro-meanFreq()-Z" 			"fbodygyromeanfreqz"

"fBodyAccMag-mean()" 				"fbodyaccmagmean"

"fBodyAccMag-std()" 				"fbodyaccmagstd"

"fBodyAccMag-meanFreq()"			"fbodyaccmagmeanfreq"

"fBodyBodyAccJerkMag-mean()" 		"fbodybodyaccjerkmagmean"

"fBodyBodyAccJerkMag-std()" 		"fbodybodyaccjerkmagstd"

"fBodyBodyAccJerkMag-meanFreq()" 	"fbodybodyaccjerkmagmeanfreq"

"fBodyBodyGyroMag-mean()" 			"fbodybodygyromagmean"

"fBodyBodyGyroMag-std()" 			"fbodybodygyromagstd"

"fBodyBodyGyroMag-meanFreq()" 		"fbodybodygyromagmeanfreq"

"fBodyBodyGyroJerkMag-mean()" 		"fbodybodygyrojerkmagmean"

"fBodyBodyGyroJerkMag-std()" 		"fbodybodygyrojerkmagstd"

"fBodyBodyGyroJerkMag-meanFreq()" 	"fbodybodygyrojerkmagmeanfreq"

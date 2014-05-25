##              Steps to create tidy data set

### Create training set

*Make sure all the files are in the working directory including this script file


*load the id of the subject
*change name of column
*load the activities
*change name of column
*change to factor
*load the activity labels
*rename colums
*tranform labels to char
*rename the levels of the activity using mapvalues from the plyr package
*cbind subject_train and y_train into subject_activity_train 
*read the trainingset
*load the features set
*rename colunms of training set
*cbind subject_activity_train and X-train into train


## Create test set

*load the id of the subject
*change name of column
*load the activities
*change name of column
*change to factor
*rename the levels of the activity using mapvalues from the plyr package
*cbind subject_test and y_test into subject_activity_test 
*read the testingset
*load the features set
*rename colunms of testing set
*cbind subject_activity_test and X-test into test



## Merge the training and the test sets to create one data set.

*rbind test and train to one dataset
dataset = rbind (train,test)

##Extracts only the measurements on the mean and standard deviation for each measurement. 

*subset

##Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

*install and load reshap2 package
*melt dataset
*calculate averages


##Appropriately labels the data set with descriptive activity names.

*replace "mean-X,Y,Z" with "Mean value  X, Y and Z directions."
*replace "std" with "Standard Deviation"
*remove brackets

##Write dataframe to file average.csv





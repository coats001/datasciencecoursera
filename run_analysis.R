###################################################################
###                First we build the traing set            #######
###################################################################

##Make sure all the files are in the working directory inluding this script file

#load the id of the subject
subject_train <- read.table("subject_train.txt", quote="\"")
#change name of column
colnames(subject_train) <-c("ID")

#load the activities
y_train <- read.table("y_train.txt", quote="\"")

#change name of column
colnames(y_train ) <-c("Activity")

#change to factor
y_train$Activity <- as.factor(y_train$Activity)

#load the activity labels
activity_labels <- read.table("activity_labels.txt", quote="\"")
#rename colums
colnames(activity_labels) <-c("level","label")
#tranform labels to char
activity_labels$label = as.character(activity_labels$label)

#rename the levels of the activity using mapvalues from the plyr package
library(plyr)
y_train$Activity <- mapvalues(y_train$Activity, from = activity_labels$level, to= activity_labels$label)

#cbind subject_train and y_train into subject_activity_train 
subject_activity_train <- cbind(subject_train,y_train)

#read the trainingset
X_train <- read.table("X_train.txt", quote="\"")
#load the features set
features <- read.table("features.txt", quote="\"")
#rename colunms of training set
colnames(X_train) <-features$V2

#cbind subject_activity_train and X-train into train
train <- cbind(subject_activity_train, X_train)


####################################
### REPEAT SAME FOR TEST SET
### except for activity labels
########
####################################
#load the id of the subject
subject_test <- read.table("subject_test.txt", quote="\"")
#change name of column
colnames(subject_test) <-c("ID")

#load the activities
y_test <- read.table("y_test.txt", quote="\"")

#change name of column
colnames(y_test ) <-c("Activity")

#change to factor
y_test$Activity <- as.factor(y_test$Activity)

#load the activity labels
#activity_labels <- read.table("C:/Users/coats001/Dropbox/coursera/data cleaning/prj/UCI HAR Dataset/activity_labels.txt", quote="\"")
#rename colums
#colnames(activity_labels) <-c("level","label")
#tranform labels to char
#activity_labels$label = as.character(activity_labels$label)

#rename the levels of the activity using mapvalues from the plyr package
library(plyr)
y_test$Activity <- mapvalues(y_test$Activity, from = activity_labels$level, to= activity_labels$label)

#cbind subject_test and y_test into subject_activity_test 
subject_activity_test <- cbind(subject_test,y_test)

#read the testingset
X_test <- read.table("X_test.txt", quote="\"")
#load the features set
features <- read.table("features.txt", quote="\"")
#rename colunms of testing set
colnames(X_test) <-features$V2

#cbind subject_activity_test and X-test into test
test <- cbind(subject_activity_test, X_test)


#Merges the training and the test sets to create one data set.
#rbind test and train to one dataset
dataset = rbind (train,test)

#Extracts only the measurements on the mean and standard deviation for each measurement. 
#subset
subdataset  = dataset[,grepl(paste0(c("ID","Activity","std()","mean()"),collapse="|"), colnames(dataset))]



##Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


#install and load reshap2 package
install.packages("reshape2")
library(reshape2)

#melt dataset
melted = melt(subdataset,id=c("ID","Activity"))
#calculate averages
averages = dcast(melted,ID+Activity ~variable,fun.aggregate=mean)

##Appropriately labels the data set with descriptive activity names.

#mean(): Mean value  X, Y and Z directions.
names(averages) <- gsub("Y", " Y direction", names(averages))
names(averages) <- gsub("Z", " Z direction", names(averages))
names(averages) <- gsub("X", " X direction", names(averages))
#replace "mean"
names(averages) <- gsub("mean()", " Average ", names(averages))
#replace "std"
names(averages) <- gsub("std()", " Standard Deviation ", names(averages))
#remove brackets
names(averages) <- gsub('\\()', "", names(averages))

##Write dataframe to file average.csv
write.csv(averages,"averages.csv")




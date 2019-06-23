#install dplyer
install.packages("dplyr")



#run the package
library(dplyr)



#set working directory
setwd("C:/Users/.Selasi/Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")



#Read and view data tables
X_test <- read.table("C:/Users/.Selasi/Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
View(X_test)

X_train <- read.table("C:/Users/.Selasi/Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
View(X_train)

y_test <- read.table("C:/Users/.Selasi/Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
View(y_test)

y_train <- read.table("C:/Users/.Selasi/Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
view(y_train)

subject_test <- read.table("C:/Users/.Selasi/Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
View(subject_test)

subject_train <- read.table("C:/Users/.Selasi/Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
View(subject_train)



#Read and view feature
features <- read.table("C:/Users/.Selasi/Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", quote="\"", comment.char="")
View(features)



#Read and view activity labels
activity_labels <- read.table("C:/Users/.Selasi/Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")
View(activity_labels)



#Assign column names
colnames(X_test) <- features[,2] 
colnames(X_train) <- features[,2]

colnames(y_test) <- "activityId"
colnames(y_train) <-"activityId"

colnames(subject_test) <- "subjectId"
colnames(subject_train) <- "subjectId"

colnames(activity_labels) <- c('activityId','activityType')



#Merge datasets
X_all <- rbind(X_test, X_train)
y_all <- rbind(y_test, y_train)
subject_all <- rbind(subject_test, subject_train)
AllinOne <- cbind(X_all, y_all, subject_all)




#****#




#Extracts only the measurements on the mean and std

colNames <- colnames(AllinOne)
mean_and_std <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)


MeanAndStd <- AllinOne[ , mean_and_std == TRUE]


DataWithNames <- merge(MeanAndStd, activity_labels,
                              by='activityId',
                              all.x=TRUE)


#Averages

tidydata <- aggregate(. ~subjectId + activityId, DataWithNames, mean)
tidydata <- tidydata[order(tidydata$subjectId, tidydata$activityId),]

write.table(tidydata, "tidydata.txt", row.name=FALSE)

if(!require("reshape")){install.packages("reshape")}
library(reshape)
#Read in header names and factor names for activity.
	mainheader<-{read.table("features.txt")[2]}
	activityFactor<-{read.table("activity_labels.txt")[2]}

#Combine all the columns for test set
	testData<-read.table("test/X_test.txt")
	testActivity<-read.table("test/y_test.txt")
	testSubject<-read.table("test/subject_test.txt")
	testSet<-cbind(testData,testActivity,testSubject) 

#Combine all columns for training set
	trainData<-read.table("train/X_train.txt")
	trainActivity<-read.table("train/y_train.txt")
	trainSubject<-read.table("train/subject_train.txt")
	trainSet<-cbind(trainData,trainActivity,trainSubject)

#Row bind 'test' and 'train' dataset. Then replace header names and convert activity values to factors.
	rawSet<-rbind(testSet,trainSet)
	names(rawSet)[1:length(testData)]  <-as.character(unlist(mainheader))
	names(rawSet)[length(testData)+1]  <-"activity"
	names(rawSet)[length(testData)+2]  <-"subject"
	rawSet$activity<-factor(rawSet$activity,labels=as.character(unlist(activityFactor)))
	

#Extract all columns containing "std" and "mean" into new variable, also include last 2 columns for activity and subject.
	extractedSet<-rawSet[,c(grep(".*std.*|.*mean.*",names(rawSet)),562:563)]

#Create tidy dataset 
	 meltedExtract<-melt(extractedSet,id=c("activity","subject"))
	 tidySet<-cast(meltedExtract, subject + activity ~ variable, mean)
         write.table(tidySet,"tidy_set.txt", row.names = FALSE)
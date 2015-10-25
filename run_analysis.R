
## sets working directory to folder with data, i.e. UCI HAR Dataset folder

setwd("path1")

## Read Data

test_X_test <- read.table("./test/X_test.txt") #2947 * 561
test_Y_test <- read.table("./test/y_test.txt") #2947 * 1
train_X_train <- read.table("./train/X_train.txt") # 7352 * 561
train_Y_train <- read.table("./train/y_train.txt") # 7352 * 1
activity_labels <- read.table("activity_labels.txt") # 6 * 2
features <- read.table("features.txt") # 561 * 2
test_subject_test <- read.table("./test/subject_test.txt") # 2947 * 1
train_subject_train <- read.table("./train/subject_train.txt") # 7352 * 1

## Merges data sets

X_Comb <- rbind(train_X_train, test_X_test) # 10299 * 561
Subject_Comb <- rbind(train_subject_train, test_subject_test) # 10299 * 1
Y_Comb <- rbind(train_Y_train, test_Y_test) # 10299 * 1

names(X_Comb) <- features[,2] ## step 4 is done here as i found it
## easier working once variable labels had been provided



## Extracts the means and Standard Deviations

means_std <- grepl("mean\\(\\)|std\\(\\)", features[,2]) # 561 * 1
#sum(means_std) I did that as a check
meanstd <- X_Comb[,means_std]

## Inserting Activity names to replace index numbers

meanstd <- cbind(Subject_Comb, meanstd) # including subject numbers
Activity <- sapply(Y_Comb, function(x){activity_labels[x,2]}) # Converting Activity
# labels to something that is readable and tidy

# table(Activity) -  this is a check that i did at this point

meanstd <- cbind(Activity, meanstd) # added descriptive activity labels

# added colnames for newly added columns

colnames(meanstd)[1] <-"Activity"  
colnames(meanstd)[2] <- "Subject"

##   Label the Dataset with Variable names.
##   The variable names were assigned earlier

## Average for each activity for each subject

split_meanstd <- split(meanstd, list(meanstd$Activity, meanstd$Subject)) #separates the data by activity and subject
split_meanstd_colmean <- sapply(split_meanstd, function(x) {colMeans(x[,3:ncol(x)])}) #calculates the mean for each subset
tidy_data <- t(split_meanstd_colmean) # transposes the matrix as Activity and Subject are now the observations
head(tidy_data) # check results

#adding Activity and Subject and also removing row names

r_names <- rownames(tidy_data)
split_r <- strsplit(r_names, "\\.")
act_sub <- t(as.data.frame(split_r))
tidy_data <- cbind(act_sub, tidy_data)
rownames(tidy_data) <- c()
colnames(tidy_data)[1] <-"Activity"
colnames(tidy_data)[2] <- "Subject"

## write to txt file
## Setting working directory to Assignment folder
setwd("path2")
write.table(tidy_data, file ="assignment.txt")
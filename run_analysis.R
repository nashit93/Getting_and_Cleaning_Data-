setwd("/Users/Allu/Downloads/UCI HAR Dataset 2/")
# Importing All the datas
train_raw <- read.table('train/X_train.txt');
test_raw <- read.table('test/X_test.txt');
sub_train <- read.table("train/subject_train.txt");
sub_test <- read.table("test/subject_test.txt");
y_test <- read.table("test/y_test.txt");
y_train <- read.table("train/y_train.txt");
features <- read.table('features.txt');
activities <- read.table('activity_labels.txt')

# Merging All the DataSets
merged_raw <- rbind(x.train, x.test);
merged_sub <- rbind(sub_train,sub_test);
merged_y <- rbind(y_train,y_test);



#Extracting The Features
mean_std_values <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])

raw_mean_sd_values <- merged_raw[, mean_std_values]




# Descriptive activity names
names(raw_mean_sd_values) <- features[mean_std_values, 2]
names(mean_std_values) <- tolower(names(mean_std_values)) 
names(mean_std_values) <- gsub("\\(|\\)", "", names(mean_std_values))


activities[, 2] <- tolower(as.character(activities[, 2]))
activities[, 2] <- gsub("_", "", activities[, 2])

merged_y[, 1] = activities[merged_y[, 1], 2]
colnames(merged_y) <- 'activity'
colnames(merged_sub) <- 'subject'

data <- cbind(merged_sub, raw_mean_sd_values, merged_y)
write.table(data, 'Project/merged.txt', row.names = F)

# Average of each variable for each activity and each subject. 
average <- aggregate(x=data, by=list(activities=data$activity, subj=data$subject), FUN=mean)
average <- average[, !(colnames(average.df) %in% c("subj", "activity"))]
str(average)
write.table(average, 'Project/average.txt', row.names = F)



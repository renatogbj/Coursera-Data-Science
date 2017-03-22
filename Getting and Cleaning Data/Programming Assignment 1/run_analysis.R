library(dplyr)
library(tidyr)
library(stringr)

if (!dir.exists('UCI HAR Dataset')) {
    download.file('http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip',
                  destfile = 'UCI HAR Dataset.zip', method = 'curl')
    unzip('UCI HAR Dataset.zip')
}

# Pre-process feature names
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
features <- features[, 2]

# Rename duplicated feature names to make them unique
# Those won't be used anyway, but it is needed to avoid errors later on
for (i in 1:length(duplicated(features))) {
    if (duplicated(features)[i]) {
        features[i] <- paste0(features[i], "_", i)
    }
}


#################################################################
#                             Part 1                            #
#                                                               #
# Merges the training and the test sets to create one data set. #
#################################################################

# Read the train dataset features and class, then bind them together
train_ft <- read.table("UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)
train_cls <- read.table("UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE)
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE)
names(train_ft) <- features
names(train_cls) <- "activity"
names(train_subject) <- "subject"
train <- cbind(train_subject, train_ft, train_cls)

# Read the test dataset features and class, then bind them together
test_ft <- read.table("UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE)
test_cls <- read.table("UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE)
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE)
names(test_ft) <- features
names(test_cls) <- "activity"
names(test_subject) <- "subject"
test <- cbind(test_subject, test_ft, test_cls)

# Merge train and test datasets
full <- rbind(train, test)


###########################################################################################
#                                           Part 2                                        #
#                                                                                         #
# Extracts only the measurements on the mean and standard deviation for each measurement. #
###########################################################################################

# This will select only features with the '-mean()' and '-std()' measurements
full <- select(full, matches("-mean\\(\\)|-std\\(\\)|activity|subject"))


###########################################################################
#                                   Part 3                                #
#                                                                         #
# Uses descriptive activity names to name the activities in the data set. #
###########################################################################

# Set labels to activity class
full$activity[full$activity == 1] <- "Walking"
full$activity[full$activity == 2] <- "Walking Upstairs"
full$activity[full$activity == 3] <- "Walking Downstairs"
full$activity[full$activity == 4] <- "Sitting"
full$activity[full$activity == 5] <- "Standing"
full$activity[full$activity == 6] <- "Laying"
full$activity <- as.factor(full$activity)
full$subject <- as.factor(full$subject)

######################################################################
#                               Part 4                               #
#                                                                    #
# Appropriately labels the data set with descriptive variable names. #
######################################################################

# Note: part of this has been done earlier by setting feature names to the variable they represent
# Below, the selected features will be given more descriptive names

# Remove parenthesis and replace minus sign
names(full) <- gsub("\\(", "", names(full))
names(full) <- gsub("\\)", "", names(full))
names(full) <- gsub("-", "_", names(full))

# Improve readability
names(full) <- sub('Mag', 'Magnitude', names(full))
names(full) <- sub('Acc', 'Acceleration', names(full))
names(full) <- sub('Gyro', 'Gyroscope', names(full))

# Replace first 't' and 'f' with 'time' and 'frequency', respectively
names(full) <- sub("^t", "time_", names(full))
names(full) <- sub("^f", "frequency_", names(full))

# This was duplicated for some reason
names(full) <- sub("BodyBody", "Body", names(full))


################################################################################################
#                                               Part 5                                         #
#                                                                                              #
# From the data set in step 4, creates a second, independent tidy data set with the average of #
# each variable for each activity and each subject.                                            #
################################################################################################

# Gather all measures into a single column
res <- gather(full, domain_signal_dimension, measure, matches("^time_|^frequency_"))

# Separate the domain ('time' or 'frequency') from the signal being measured
# and from the type of statistical ('mean' or 'std') calculated within each dimension
res <- separate(res, col = domain_signal_dimension, into = c("domain", "signal", "statistic", "dimension"), fill = "right")

# Since the magnitude measures are independent of the dimension
# they will be united to avoid NAs in the 'dimension' column
res <- unite(res, signal, signal, dimension)
res$signal <- sub("_NA", "", res$signal)

# Improve readability in the signal feature
res$signal <- gsub("([A-Z])", " \\1", res$signal)
res$signal <- sub("_ ([X-Z])", " in the \\1 axis", res$signal)
res$signal <- str_trim(res$signal, side = "left")

# Turn the new features to factor
res$domain <- as.factor(res$domain)
res$signal <- as.factor(res$signal)
res$statistic <- as.factor(res$statistic)

# Calculate the mean of each variable (represented in the signal feature) for each activity
res <- res %>% group_by(signal, activity) %>% mutate(mean_activity = mean(measure))

# And for each subject
res <- res %>% group_by(signal, subject) %>% mutate(mean_subject = mean(measure))


########
# Save #
########
write.table(res, file = "human-activity-recognition-tidy-data.txt", row.names = FALSE)


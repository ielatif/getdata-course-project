if (!require("reshape2")) {
    install.packages("reshape2")
}

require("reshape2")

# Returns one data set by reading and merging all component files.
# Data set comprises of the X values, Y values and Subject IDs.
# The directory indicates the path where the data files can be found.
# The file_suffix indicates the file name suffix to be used to create the complete file name.
#
# This also subsets the data to extract only the measurements on the mean and standard deviation for each measurement.
# The required columns in the subset is determined by selecting only those columns that have either "mean()" or "std()" in their names.
# Subsetting is done early on to help reduce memory requirements.
readData <- function(file_suffix, directory) {
    file_path <- file.path(directory, paste0("y_", file_suffix, ".txt"))
    y_data <- read.table(file_path, header=F, col.names=c("ActivityID"))
    
    file_path <- file.path(directory, paste0("subject_", file_suffix, ".txt"))
    subject_data <- read.table(file_path, header=F, col.names=c("SubjectID"))
    
    # read the column names
    data_cols <- read.table("./UCI HAR Dataset/features.txt", header=F, as.is=T, col.names=c("MeasureID", "MeasureName"))
    
    # read the X data file
    file_path <- file.path(directory, paste0("X_", file_suffix, ".txt"))
    data <- read.table(file_path, header=F, col.names=data_cols$MeasureName)
    
    # names of subset columns required
    subset_data_cols <- grep(".*mean\\(\\)|.*std\\(\\)", data_cols$MeasureName)
    
    # subset the data (done early to save memory)
    data <- data[,subset_data_cols]
    
    # append the activity id and subject id columns
    data$ActivityID <- y_data$ActivityID
    data$SubjectID <- subject_data$SubjectID
    
    # return the data
    data
}

# read test data set
testData <- readData("test", "./UCI HAR Dataset/test")

# read test data set
trainData <- readData("train", "./UCI HAR Dataset/train")

# Merge both train and test data sets
mergeData <- function() {
    data <- rbind(testData, trainData)
    cnames <- colnames(data)
    cnames <- gsub("\\.+mean\\.+", cnames, replacement="Mean")
    cnames <- gsub("\\.+std\\.+",  cnames, replacement="Std")
    colnames(data) <- cnames
    data
}

# Add the activity names as another column
applyActivityLabel <- function(data) {
    activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=F, as.is=T, col.names=c("ActivityID", "ActivityName"))
    activity_labels$ActivityName <- as.factor(activity_labels$ActivityName)
    data_labeled <- merge(data, activity_labels)
    data_labeled
}

# Combine training and test data sets and add the activity label as another column
getMergedLabeledData <- function() {
    applyActivityLabel(mergeData())
}

# Create a tidy data set that has the average of each variable for each activity and each subject.
getTidyData <- function(merged_labeled_data) {
    # melt the dataset
    id_vars = c("ActivityID", "ActivityName", "SubjectID")
    measure_vars = setdiff(colnames(merged_labeled_data), id_vars)
    melted_data <- melt(merged_labeled_data, id=id_vars, measure.vars=measure_vars)
    
    # recast 
    dcast(melted_data, ActivityName + SubjectID ~ variable, mean)    
}

tidy_data <- getTidyData(getMergedLabeledData())

write.table(tidy_data, file = "./tidy_data.txt")
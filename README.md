Peer-Assessed Programming Assignment for Getting and Cleaning Data
==================

This repository contains my solution for peer-assessed programming assignment in Getting and Cleaning Data class.

`run_analysis.R` is a script that tidies up and produces aggregate data for the original data set[1].

The script will attempt to retrieve the dataset automatically (this is controlled by the `download.file.automatically` variable, as HTTPS support may be unavailable or defunct in some environment - if that is the case, the zip file should be put in the working directory manually), and will unpack it afterwards - unless the data is already present.

The training and test sets are merged together, provided with meaningful labels, activity labels are converted to sensible names and only the mean and SD observations are retained. The resulting data set is written to a CSV file in the working directory.

After that, the script produces averages for all subject-activity groups, and writes a second CSV file in the working directory with the resulting data set.

The `run_analysis.R` script is commented to indicate which parts of the code are responsible for which transformations. See `CodeBook.md` for additional information on resulting data sets.

Reference:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


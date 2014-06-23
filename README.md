Peer-Assessed Programming Assignment for Getting and Cleaning Data
==================

This repository contains my solution for peer-assessed programming assignment in Getting and Cleaning Data class.

`run_analysis.R` is a script that tidies up and produces aggregate data for the original data set.

Suppose the directory "UCI HAR Dataset" contaning the data is in the current directory. 

The training and test sets are merged together, provided with meaningful labels, activity labels are converted to sensible names and only the mean and SD observations are retained. The resulting data set is written to a text file in the working directory.

The `run_analysis.R` script is commented to indicate which parts of the code are responsible for which transformations. 

See `CodeBook.md` for additional information on resulting data sets.




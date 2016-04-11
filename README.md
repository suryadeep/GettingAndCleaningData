# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Downloads the dataset from source if it does not already exist in the working directory
2. Loads the activity and feature info
3. Loads both the training and test datasets
4. Filters the datasets keeping only those columns which reflect a mean or standard deviation
5. Loads the activity and subject data for each dataset
6. Merges thr required columns with the dataset
7. Merges the two datasets
8. Converts the `activity` and `subject` columns into factors
9. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.

The end result is shown in the file `tidy.txt`.


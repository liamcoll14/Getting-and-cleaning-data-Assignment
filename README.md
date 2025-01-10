# Getting-and-cleaning-data-Assignment

Data was downloaded and unzipped to work area from the URL provided using code:\
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"\
download.file(fileURL, filename, method="curl")\
unzip(filename) 

Once this is in place run_analysis.R is the script to read in required data. 
dplyr package will need to be run before run_analysis.R can be submitted.  

## run_analysis.R\
Reads in all the data needed and formats column names ready for merging.
Data is then merged and only relevant mean/std columns are selected.
From here more descriptive names are applied to columns and then the means of
each column are calculated grouped by subject and activity.

## tidy_data.txt\
Text file of the output dataset from run_analysis.R. This lists the average of
any wearable means/stds by subject and by activity

## CodeBook.md\
CodeBook to explain in more detail how run_analysis.R collects, formats and transforms data to create tidy_data.txt.


# Getting_and_cleaning_data
assignment submission

## Instructions on how to operate the run_analysis.R file

1) Please first download the file to your drive and unzip it. The submission form says that the file should "the code should have a file run_analysis.R in the main directory that can be run as long as the Samsung data is in your working directory"

2) then open run_analysis.R. Please note that you will need to first input the path where the data is downloaded. This will be the UCI HAR Dataset folder. Please do not alter the format that the folder is in after you unzipped it.

3) Firstly the script will read all of the data

4) After that it is going to merge the data. Please note that at this step, i also included the descriptive variable names. I did this because i found it easier to work with it once it had variable names. I think this is what was wanted in step 4 of the questions

5) After that it extracts the variables that are means or standard deviations

6) After that the actual descriptive activity names were included rather than the activity reference number

7) After that the average of each variable by subject and activity was calculated. I did this through a split and sapply function. Please note that i then went and added labels for activity and subject.

8) Finally i created a txt file using write.table. **Please set a location to write the file to**
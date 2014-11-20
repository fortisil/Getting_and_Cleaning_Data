The file run_analysis.R prepare tidy data that can be used for later analysis. It first Merges 
the training and the test sets to create one data set using rbind function and store the merges files into a data frame.
It than extracts only the measurements on the mean and standard deviation for each measurement by reading the file features.txt.
The results also stored in a new data frame for further analysis. The new data frame called "X" .
After that, the program uses descriptive activity names to name the activities in the data set
by reading the file "activity_labels.txt"
The activities names are:
1	walking
2	2	walkingupstairs
3	3	walkingdownstairs
4	4	sitting
5	5	standing
6	6	laying



The program also appropriately labels the data set with descriptive names: all feature names (attributes) and activity names are converted to lower case, 
underscores and brackets () are removed. Then it merges  all to a file name "merged_clean_datd.txt".

Finally, the script creates a 2nd, independent tidy data set with the average of each measurement for each activity and each subject. The result is saved as 
file name "data_set_with_the_averages.txt", a 180x68 data frame, where as before, the first column contains subject IDs, the second column contains activity 
names (see below), and then the averages for each of the 66 attributes are in columns 3...68. There are 30 subjects and 6 activities, thus 180 rows in this 
data set with averages.
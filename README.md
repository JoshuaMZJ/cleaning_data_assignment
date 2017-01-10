1) Check that the reshape package is installed. If it's not, use install.packages to install it.
2) Read in features.txt and activity_labels.txt for the header names and factors to convert the activity numbers into descriptive text.
3) Using read.table, read in all the data sets for the training and test sets and combine them into one dataframe with cbind and rbind.
4) Replace the default header names in the dataframe with the lists from step 2.
5) Using grep() function, we create a new data set from the combined set earlier to take in columns containing 'std' and' mean'.
6) Lastly, we use the melt and cast functions from reshape package to create a tidy data set that has the mean of all the column data.
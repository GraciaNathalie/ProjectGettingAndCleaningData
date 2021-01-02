#Merges the training and the test set to create one data set
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
Subject <- rbind(subject_train,subject_test)
All_Data <- cbind(Subject, y, x)

#Extracts only the measurements on the mean and standard deviation
#for each measurement

ExtractedData <- All_Data %>% select(subject, code, contains("mean"), contains("std"))

#Use desc activity names to name the activities in the data set
names(All_Data)[2] = "activity"
names(All_Data) <- gsub("^t", "Time", names(All_Data))
names(All_Data) <- gsub("^f", "Frequency", names(All_Data))
names(All_Data) <- gsub("Acc", "Accelerometer", names(All_Data))
names(All_Data) <- gsub("Gyro", "Gyroscope", names(All_Data))
names(All_Data) <- gsub("Mag", "Magnitude", names(All_Data))
names(All_Data) <- gsub("BodyBody", "Body", names(All_Data))

#Independent tidy data set
Tidy1 <- All_Data %>%
        group_by(Subject, activity) %>%
        summarise_all(funs(mean))
write.table(Tidy1, file = "TidyData.txt", row.name = FALSE)
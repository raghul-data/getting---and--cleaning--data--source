x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged_data <- cbind(subject, y, x)
tidydata <- merged_data%>% select(subject, code, contains("mean"), contains("std"))
tidydata$code <- activities[tidydata$code, 2]
names(tidydata) [2] ="activity"
names(tidydata ) <- gsub("acc", "accelerometer", names(tidydata))
names(tidydata) <- gsub("gyro", "gyroscope", names(tidydata))
names(tidydata) <- gsub("bodybody", "body", names(tidydata))
names(tidydata) <- gsub("mag", "magnitude", names(tidydata))
names(tidydata) <- gsub("^t", "time", names(tidydata))
names(tidydata) <- gsub("^f", "frequency", names(tidydata))
names(tidydata) <- gsub("tbody", "timebody", names(tidydata))
names(tidydata) <- gsub("-mean()", "Mean", names(tidydata), ignore.case = TRUE )
names(tidydata) <- gsub("-std()", "STD", names(tidydata), ignore.case = TRUE)
names(tidydata) <- gsub("-freq()", "Frequency", names(tidydata), ignore.case = TRUE)
names(tidydata) <- gsub("angle", "Angle", names(tidydata))
names(tidydata) <- gsub("gravity", "Gravity", names(tidydata))

finaldata <- tidydata%>%
  group_by(subject, activity)%>%
  summarise_all(funs(mean))
write.table(finaldata, "finaldata.txt", row.name = FALSE)

str(finaldata)
finaldata
  
  
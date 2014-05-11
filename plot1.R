# this script generates a data frame from the
# specified file based on the supplied query
# string.  This query depends on the loading
# of the "sqldf" library.  The data frame is
# used as input(s) to the required plotting
# functions.

## data frame ##

### install and load the "sqldf" library
install.packages("sqldf")
library("sqldf")

### initialize variables used in "sql" file query
theFile <- "household_power_consumption.txt"
theQuery <- "SELECT * from file WHERE Date ='1/2/2007' OR Date = '2/2/2007'"

### open the read file connection and
### return the query results as data frame
theData <- read.csv2.sql(theFile, theQuery, sep = ";")

### close the read file connection
close(theFile)

## plot1 ##

### initiate plot device with plot name and size
png(file="plot1.png",width=480,height=480)

### execute the plotting command
hist(theData$Global_active_power, xlab = "Global Active Power (kilowatts)",
     col = "red", main = "Global Active Power")

### close the plot device
dev.off()
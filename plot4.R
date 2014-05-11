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

## plot4 ##

### initial date variable to proper 
### format for input to plotting operation
theDays <- strptime(paste(theData$Date, theData$Time), format='%d/%m/%Y %H:%M:%S')

### initiate plot device with plot name and size
png(file="plot4.png",width=480,height=480)

### set plot to two (2) rows and two (2) columns
par(mfrow = c(2, 2))

### execute the plotting commands

#### plot command for row 1 column 1
plot(theDays, theData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

#### plot command for row 1 column 2
plot(theDays, theData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

#### plot commands for row 2 column 1
plot(theDays, theData$Sub_metering_1, type = "l", col = "black",
     xlab = "", ylab = "Energy sub metering")
points(theDays, theData$Sub_metering_2, type = "l", col = "red")
points(theDays, theData$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1), lwd = c(1, 1, 1), col = c("black","red", "blue"),
       bty = "n")

#### plot command for row 2 column 2
plot(theDays, theData$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")

### close the plot device
dev.off()
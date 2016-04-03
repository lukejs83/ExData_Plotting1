library(dplyr)

#only select dates of interest
low = 66637
high = 69517
n = high-low

#define data file name and classes
datafile <- "household_power_consumption.txt"
classes <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")

#load data
powerdata <- read.table(datafile, header = FALSE, sep = ";", colClasses = classes, 
                   skip =low, nrow=n, na.strings = "?")

#get names
col_names <- read.table(datafile, header = TRUE, sep = ";", colClasses = classes, 
                    nrow=1, na.strings = "?")
names(powerdata) <- names(col_names)

#convert date and time variables to Date/Time classes
powerdata$DateTime <- strptime(paste(powerdata$Date,powerdata$Time), format = "%d / %m / %Y %H:%M:%S")

#########
#Plot 4
########


png(filename ="plot4.png",width = 480, height = 480)
par(mfrow = c(2, 2))


#A
plot(powerdata$DateTime,powerdata$Global_active_power,type = "l", xlab="", 
     ylab="Global Active Power (kilowatts)")

#B
plot(powerdata$DateTime, powerdata$Voltage, ylab = "Voltage", xlab="dateTime",
     type = "l")

#C
plot(powerdata$DateTime,powerdata$Sub_metering_1,type = "n", xlab="", 
     ylab="Energy sub metering")

lines(powerdata$DateTime,powerdata$Sub_metering_1)
lines(powerdata$DateTime,powerdata$Sub_metering_2,col = "Red")
lines(powerdata$DateTime,powerdata$Sub_metering_3,col = "Blue")

labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
labelcolors <- c("Black","Red","Blue")

legend("topright",legend = labels, col = labelcolors, lty = c(1,1,1),bty = "n")

#D
plot(powerdata$DateTime, powerdata$Global_reactive_power, ylab = "Gate_reactive_power", xlab="dateTime",
     type = "l")


dev.off()


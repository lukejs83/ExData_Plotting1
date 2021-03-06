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
#Plot 1
########

png(filename ="plot1.png",width = 480, height = 480)

hist(powerdata$Global_active_power, col='Red', xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main = "Global Active Power")


dev.off()




library(data.table)
library(PCICt)

# Code to download the zip file from internet and unzip the file 

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
unzip(temp)
unlink(temp)

# Code to structure the data in each columns as mentioned in the assignment.It
# also replaces the values with ? into NA so that we can use the different
# functions to subset the data and get rid of NA values easily
# we have converted the data types of the columns from factor to character
# and time to POSIXct as well as date to R format


housePowerCnsp <- read.table(file="./household_power_consumption.txt",header=TRUE,sep=";",na.string="?")
housePowerCnsp$DateTime <- strptime(paste(housePowerCnsp$Date,housePowerCnsp$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
housePowerCnsp$Date <- as.character(housePowerCnsp$Date)
housePowerCnsp$Time <- as.character(housePowerCnsp$Time)
housePowerCnsp$Time <- strptime(housePowerCnsp$Time,"%H:%M:%S")
housePowerCnsp$Date <- as.Date(housePowerCnsp$Date,"%d/%m/%y")

housePowerCnsp$Global_active_power[housePowerCnsp$Global_active_power=="?"] <- "NA"
housePowerCnsp$Global_reactive_power[housePowerCnsp$Global_reactive_power=="?"] <- "NA"
housePowerCnsp$Voltage[housePowerCnsp$Voltage=="?"] <- "NA"
housePowerCnsp$Global_intensity[housePowerCnsp$Global_intensity=="?"] <- "NA"
housePowerCnsp$Sub_metering_1[housePowerCnsp$Sub_metering_1=="?"] <- "NA"
housePowerCnsp$Sub_metering_2[housePowerCnsp$Sub_metering_2=="?"] <- "NA"
housePowerCnsp$Sub_metering_3[housePowerCnsp$Sub_metering_3=="?"] <- "NA"

housePowerCnsp1 <- housePowerCnsp[housePowerCnsp$DateTime >= as.POSIXlt("2007-02-01 00:00:00"),]
housePowerCnsp1 <- housePowerCnsp1[housePowerCnsp1$DateTime <= as.POSIXlt("2007-02-03 00:00:00"),]
housePowerCnsp1$Global_active_power <- as.numeric(housePowerCnsp1$Global_active_power)
housePowerCnsp1$Global_reactive_power <- as.numeric(housePowerCnsp1$Global_reactive_power)
housePowerCnsp1$Voltage <- as.numeric(housePowerCnsp1$Voltage)
housePowerCnsp1$Global_intensity <- as.numeric(housePowerCnsp1$Global_intensity)
housePowerCnsp1$Sub_metering_1 <- as.numeric(housePowerCnsp1$Sub_metering_1)
housePowerCnsp1$Sub_metering_2 <- as.numeric(housePowerCnsp1$Sub_metering_2)
housePowerCnsp1$Sub_metering_3 <- as.numeric(housePowerCnsp1$Sub_metering_3)

# code for Plot 4

png(filename="Plot4.png",width=480,height=480,units="px")

par(mfcol=c(2,2))

plot(housePowerCnsp1$DateTime,housePowerCnsp1$Global_active_power,
     type="lines",xlab=" ",ylab="Global Active Power (kilowatts)");



plot(housePowerCnsp1$DateTime,housePowerCnsp1$Sub_metering_1,
     type="lines",xlab=" ",ylab="Energy Sub metering",col="black");
par(new=TRUE)
plot(housePowerCnsp1$DateTime,housePowerCnsp1$Sub_metering_2,
     type="lines",xlab=" ",ylab=" ",axes=FALSE,col="red");
par(new=TRUE)
plot(housePowerCnsp1$DateTime,housePowerCnsp1$Sub_metering_3,
     type="lines",xlab=" ",ylab=" ",axes=FALSE,na.rm=TRUE,col="blue");
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "o",
       lwd = 0.2, cex = 0.2, col = c("black", "blue", "red"), lty = c(1, 1, 1), pch = c(NA, NA, NA))

plot(housePowerCnsp1$DateTime,housePowerCnsp1$Voltage,
     type="lines",xlab="datetime",ylab="Voltage");

plot(housePowerCnsp1$DateTime,housePowerCnsp1$Global_reactive_power,
     type="lines",xlab="datetime",ylab="Global Reactive Power (kilowatts)")


dev.off()

url1 <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## I used "downloader" package to download zip file
library(downloader)
download(url1, dest="./data/PwrCons.zip", mode="wb")

## Unzipping file into folder "Data" in wd
unzip("./data/PwrCons.zip", exdir="./data")

sampleset <- read.table("./data/household_power_consumption.txt",
                        header=TRUE, sep=";", nrows=5)
classes <- sapply(sampleset, class)

DT <- read.table("./data/household_power_consumption.txt",
                 header=TRUE, sep=";", stringsAsFactors=FALSE, fill=TRUE,
                 colClasses=classes, comment.char="?", quote="")

## Adding POSIXct variable containing time and date
DT <- transform(DT, Obs.time=strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))

## Subsetting to only include data from 2007-02-01 and 2007-02-02
wDT <- DT[which(DT$Date %in% c('1/2/2007','2/2/2007')), ]

## Creating a plot on screen device - I use Windows
par(mfrow=c(2,2), mar=c(4,4,1,1))				
plot(wDT$Obs.time, wDT$Global_active_power, type = "l", lwd="1",
     xlab="", ylab="Global Active Power (kilowatts)")			
plot(wDT$Obs.time, wDT$Voltage, type = "l", lwd="1", xlab="datetime",
     ylab="Voltage")			
plot(wDT$Obs.time, wDT$Sub_metering_1, type = "l", lwd="1", xlab="",
     ylab="Energy sub metering")
lines(wDT$Obs.time, wDT$Sub_metering_2, type = "l", lwd=1, col="red")				
lines(wDT$Obs.time, wDT$Sub_metering_3, type = "l", lwd=1, col="blue")				
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1)		
plot(wDT$Obs.time, wDT$Global_reactive_power, type = "l", lwd="1",
     xlab="datetime", ylab="Global_reactive_power")
dev.off()

## Creating a plot in png device
png(file="plot4.png", width=480, height=480)	
par(mfrow=c(2,2), mar=c(4,4,1,1))				
plot(wDT$Obs.time, wDT$Global_active_power, type = "l", lwd="1",
     xlab="", ylab="Global Active Power (kilowatts)")			
plot(wDT$Obs.time, wDT$Voltage, type = "l", lwd="1", xlab="datetime",
     ylab="Voltage")			
plot(wDT$Obs.time, wDT$Sub_metering_1, type = "l", lwd="1", xlab="",
     ylab="Energy sub metering")
lines(wDT$Obs.time, wDT$Sub_metering_2, type = "l", lwd=1, col="red")				
lines(wDT$Obs.time, wDT$Sub_metering_3, type = "l", lwd=1, col="blue")				
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1)		
plot(wDT$Obs.time, wDT$Global_reactive_power, type = "l", lwd="1",
     xlab="datetime", ylab="Global_reactive_power")
dev.off()
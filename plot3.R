# Script plot3.R
# Description
# Creates the plot3.png

# Create directory, load the zip file and unzip it
zipFileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destFile = "exdata-data-household_power_consumption.zip"
download.file(zipFileUrl, destfile=destFile, method="curl")
unzip(destFile)

# Load and subset data
df <- read.csv(file="household_power_consumption.txt", header=T, sep=';', colClasses=c("character","character","double","double","double","double","double","double","numeric"),na.strings="?")
df$rDate <-as.Date(strptime(df$Date,"%d/%m/%Y"))
sdf<-subset(df, df$rDate >= as.Date("2007-02-01") & df$rDate <= as.Date("2007-02-02"))
sdf$DateTime <-paste(sdf$Date, sdf$Time, sep=" ")
sdf$rDateTime <- as.POSIXct(strptime(sdf$DateTime, "%d/%m/%Y %H:%M:%S"))

# Plot3
png(filename="plot3.png", width=480, height=480) ## Open Png device; 
## Create plot and send to a file (no plot appears on screen)
with(sdf, plot(rDateTime, Global_active_power, type="n", ylab="Energy sub metering", xlab="", ylim=c(0, 38)))
with(sdf, lines(rDateTime, Sub_metering_1, col = "black"))
with(sdf, lines(rDateTime, Sub_metering_2, col = "red"))
with(sdf, lines(rDateTime, Sub_metering_3, col = "blue"))
legend("topright", lwd=1, lty=c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off() ## Close the Png file device


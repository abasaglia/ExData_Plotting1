# Script plot1.R
# Description
# Creates the plot1.png

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


# Plot1
png(filename="plot1.png", width=480, height=480) ## Open Png device; 
## Create plot and send to a file (no plot appears on screen)
hist (sdf$Global_active_power, breaks=15, col="Red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off() ## Close the Png file device

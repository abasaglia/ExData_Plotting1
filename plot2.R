# Script plot2.R
# Description
# Creates the plot2.png

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

# Plot2
png(filename="plot2.png", width=480, height=480) ## Open Png device; 
## Create plot and send to a file (no plot appears on screen)
with(sdf, plot(rDateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off() ## Close the Png file device

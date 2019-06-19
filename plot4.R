library(data.table)

# Unzip data file
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("data.zip")) {
  download.file(url, file.path(path, "data.zip"))
  unzip(zipfile = "data.zip")
}

# Read the data separated by ';' and with missing values coded as '?'
data <- read.table(
  "./household_power_consumption.txt",
  header = TRUE,
  sep = ';',
  na = '?'
)

# Take a subset of data for the dates 2007-02-01 and 2007-02-02
sdata <- subset(data, as.Date(strptime(data$Date, "%d/%m/%Y")) >= "2007-02-01"
                & as.Date(strptime(data$Date, "%d/%m/%Y")) <= "2007-02-02")
datetime <- strptime(paste(sdata$Date, sdata$Time), "%d/%m/%Y %H:%M:%S")

# Open a graphic device png
png(file="plot4.png", width=480, height=480)

# Change mfcol to fit 4 plots
par(mfcol = c(2,2))

# Plot1
plot(datetime,
     sdata$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

# Plot2
plot(datetime,
     sdata$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering")

# Add another plot
lines(datetime,
      sdata$Sub_metering_2,
      col="red")

lines(datetime,
      sdata$Sub_metering_3,
      col="blue")

# Add a legend
legend("topright",
       inset=.02, 
       box.lty=0,
       lty=1,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"))

# Plot3
plot(datetime,
     sdata$Voltage,
     type="l",
     ylab="Voltage")

# Plot 4
plot(datetime,
     sdata$Global_reactive_power,
     type="l",
     ylab="Global_reactive_power")

# Close the device
dev.off()
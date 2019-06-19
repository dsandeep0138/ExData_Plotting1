library(data.table)

# Unzip data file
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, file.path(path, "data.zip"))
unzip(zipfile = "data.zip")

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
png(file="plot2.png", width=480, height=480)

# Plot
plot(datetime,
     sdata$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

# Close the device
dev.off()
# Download and unzip
if (!file.exists('data.zip')) {
    download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
                  destfile = 'data.zip', method = 'curl')
    unzip('data.zip')
}

data <- read.table('household_power_consumption.txt', header = TRUE, sep = ';', na.strings = '?')

# Convert Date and subset
data$Date <- paste(data$Date, data$Time)
data$Date <- strptime(data$Date, format = "%d/%m/%Y %H:%M:%S")

data <- subset(data, format(`Date`, '%Y-%m-%d') >= "2007-02-01" &
                   format(`Date`, '%Y-%m-%d') <= "2007-02-02")

# Set graphics device
png("plot3.png")

# Plot
with(data, plot(Date, Sub_metering_1, type = "n",
                xlab = "", ylab = "Energy sub metering"))
lines(data$Date, data$Sub_metering_1, col = "black")
lines(data$Date, data$Sub_metering_2, col = "red")
lines(data$Date, data$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()

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
png("plot2.png")

# Plot
with(data, plot(Date, Global_active_power, type = "l",
                xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.off()

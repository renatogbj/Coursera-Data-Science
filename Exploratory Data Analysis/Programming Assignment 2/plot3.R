library(ggplot2)
library(dplyr)

if (!file.exists('data.zip')) {
    download.file(url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip',
                  method = 'curl', destfile = 'data.zip')
    unzip('data.zip')
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$type <- as.factor(NEI$type)

baltimore <- NEI %>% filter(fips == "24510") %>% group_by(year, type) %>%
    mutate(total.by.year = sum(Emissions))

png("plot3.png")

ggplot(baltimore, aes(x = year, y = log10(total.by.year), color = type)) +
    geom_line() +
    xlab('Year') +
    ylab('Total PM25 Emissions (log10)') +
    ggtitle('Baltimore City Total PM25 Emissions by Year and Type') +
    theme_bw()

dev.off()

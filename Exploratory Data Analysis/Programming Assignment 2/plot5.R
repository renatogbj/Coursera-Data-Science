library(dplyr)

if (!file.exists('data.zip')) {
    download.file(url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip',
                  method = 'curl', destfile = 'data.zip')
    unzip('data.zip')
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEISCC <- merge(NEI, SCC, by = "SCC")

NEISCC.motor <- NEISCC %>% filter(fips == "24510" & type == "ON-ROAD") %>%
    group_by(year) %>% mutate(total.by.year = sum(Emissions))

png("plot5.png")

ggplot(NEISCC.motor, aes(x = year, y = log10(total.by.year))) +
    geom_line() +
    xlab('Year') +
    ylab('Total PM25 Motor Vehicle-related Emissions (log10)') +
    ggtitle('USA Total PM25 Motor Vehicle Related Emissions from 1999 to 2008') +
    theme_bw()

dev.off()

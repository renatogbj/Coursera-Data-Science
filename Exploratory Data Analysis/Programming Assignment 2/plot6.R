library(dplyr)

if (!file.exists('data.zip')) {
    download.file(url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip',
                  method = 'curl', destfile = 'data.zip')
    unzip('data.zip')
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEISCC <- merge(NEI, SCC, by = "SCC")

NEISCC.motor.baltimore <- NEISCC %>% filter(fips == '24510' & type == 'ON-ROAD') %>%
    group_by(year) %>% mutate(total.by.year = sum(Emissions))
NEISCC.motor.baltimore$City <- 'Baltimore City'

NEISCC.motor.la <- NEISCC %>% filter(fips == '06037' & type == 'ON-ROAD') %>%
    group_by(year) %>% mutate(total.by.year = sum(Emissions))
NEISCC.motor.la$City <- 'Los Angeles County'

both <- rbind(NEISCC.motor.baltimore, NEISCC.motor.la)

png("plot6.png")

ggplot(both, aes(x = year, y = log10(total.by.year), color = City)) +
    geom_line() +
    xlab('Year') +
    ylab('Total PM25 Motor Vehicle-related Emissions (log10)') +
    ggtitle('Baltimore and LA Total PM25 Motor Vehicle Related Emissions by Year') +
    theme_bw()

dev.off()

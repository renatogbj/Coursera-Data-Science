if (!file.exists('data.zip')) {
    download.file(url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip',
                  method = 'curl', destfile = 'data.zip')
    unzip('data.zip')
}

NEI <- readRDS("summarySCC_PM25.rds")


baltimore <- NEI %>% filter(fips == "24510") %>% group_by(year) %>%
    mutate(total.by.year = sum(Emissions))

png("plot2.png")

with(baltimore, plot(year, log10(total.by.year),
                    type = "l",
                    xlab = "Year", ylab = "Total PM25 Emissions (log10)",
                    main = "Baltimore City Total PM25 Emission from 1999 to 2008"))

dev.off()

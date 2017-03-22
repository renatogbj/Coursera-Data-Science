pollutantmean <- function(directory, pollutant, id = 1:332) {
    values <- vector()
    for (i in id) {
        file <- if (i < 10) {
            paste(directory, "00", i, ".csv", sep = "")
        } else if (i < 100) {
            paste(directory, "0", i, ".csv", sep = "")
        } else {
            paste(directory, i, ".csv", sep = "")
        }
        data <- read.csv(file, header = TRUE)
        values <- c(values, data[,pollutant])
    }
    mean(values, na.rm = TRUE)
}
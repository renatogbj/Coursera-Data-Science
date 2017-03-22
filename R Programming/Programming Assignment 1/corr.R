corr <- function(directory, threshold = 0) {
    r <- vector()
    # comp <- complete(directory, 1:332)
    # View(comp)
    k <- 1
    for (i in 1:332) {
        comp <- complete(directory, i)
        if (comp["nobs"] > threshold) {
            file <- if (i < 10) {
                paste(directory, "00", i, ".csv", sep = "")
            } else if (i < 100) {
                paste(directory, "0", i, ".csv", sep = "")
            } else {
                paste(directory, i, ".csv", sep = "")
            }
            data <- read.csv(file)
            r[k] <- cor(data[,"sulfate"], data[,"nitrate"], use = "complete")
            k <- k + 1
        }
    }
    r
}
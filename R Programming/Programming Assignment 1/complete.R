complete <- function(directory, id = 1:332) {
    result <- data.frame()
    #colnames(result) <- c("id", "nobs")
    for (i in id) {
        file <- if (i < 10) {
            paste(directory, "00", i, ".csv", sep = "")
        } else if (i < 100) {
            paste(directory, "0", i, ".csv", sep = "")
        } else {
            paste(directory, i, ".csv", sep = "")
        }
        data <- read.csv(file)
        complete_data <- data[!is.na(data[,"sulfate"]) & !is.na(data[,"nitrate"]),]
        complete_cases <- length(complete_data[,"ID"])
        result <- rbind(result, data.frame(id = i, nobs = complete_cases))
    }
    result
}
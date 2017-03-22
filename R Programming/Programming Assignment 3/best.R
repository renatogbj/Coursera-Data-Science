best <- function(state, outcome) {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    data[, 11] <- as.numeric(data[, 11])
    data[, 17] <- as.numeric(data[, 17])
    data[, 23] <- as.numeric(data[, 23])
    
    ## Check that state and outcome are valid
    if (!(state %in% data$State)) {
        stop("invalid state")
    }
    if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) {
        stop("invalid outcome")
    }
    
    ## Return hospital name in that state with lowest 30-day death rate
    col <- ifelse(outcome == "heart attack", 11,
                          ifelse(outcome == "heart failure", 17, 23))
    
    min_rate <- min(data[data$State %in% state, col], na.rm = TRUE)
    hospital <- data$Hospital.Name[data$State %in% state &
                     data[, col] == min_rate &
                     !is.na(data[, col])]
    sort(hospital)[1]
}
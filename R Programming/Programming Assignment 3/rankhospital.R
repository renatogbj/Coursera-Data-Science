rankhospital <- function(state, outcome, num = "best") {
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
    
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    col <- ifelse(outcome == "heart attack", 11,
                  ifelse(outcome == "heart failure", 17, 23))
    
    data <- data[data$State %in% state & !is.na(data[, col]),]
    data <- data[order(data[, col], data[, 2], na.last = TRUE), ]
    
    num <- ifelse(num == "best", 1, ifelse(num == "worst", nrow(data), num))
    
    data[num, 2]
}
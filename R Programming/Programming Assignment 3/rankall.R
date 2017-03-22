rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    data[, 11] <- as.numeric(data[, 11])
    data[, 17] <- as.numeric(data[, 17])
    data[, 23] <- as.numeric(data[, 23])
    
    ## Check that state and outcome are valid
    if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) {
        stop("invalid outcome")
    }
    
    ## For each state, find the hospital of the given rank
    col <- ifelse(outcome == "heart attack", 11,
                  ifelse(outcome == "heart failure", 17, 23))
    
    data <- data[order(data[, 7], data[, col], data[, 2], na.last = TRUE), ]
    data <- data[!is.na(data[, col]), ]
    
    num <- ifelse(num == "best", 1, num)
    
    s <- split(data, data$State)
    s <- lapply(s, FUN = function(x) { x[ifelse(num=="worst",nrow(x),num), 2] })
    
    st <- names(s)
    hospital <- unlist(s, use.names = FALSE)
    
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    data.frame(hospital = hospital, state = st)
}
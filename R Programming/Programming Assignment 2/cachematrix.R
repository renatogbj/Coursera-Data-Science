# Functions to create and manipulate cache of a matrix and its inverse.

# Create a list of functions to allow caching a matrix and its inverse.

makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y) {
        x <<- y
        inv <- NULL
    }
    get <- function() x
    setinv <- function(inverse) inv <<- inv
    getinv <- function() inv
    list(set=set, get=get, setinv=setinv, getinv=getinv)
}


# Lookup the cache for the value of the inverse of the matrix 'x'.
# If it has been calculated already, then returns it.
# Otherwise, calculate it, save it on the cache and returns it.

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    inv <- x$getinv()
    if (!is.null(inv)) {
        message("getting cached matrix")
        return (inv)
    }
    data <- x$get()
    inv <- solve(data, ...)
    x$setinv(inv)
    inv
}

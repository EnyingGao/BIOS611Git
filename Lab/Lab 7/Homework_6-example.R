## Homework 6 general comments.

## When coding you want to avoid
## A. Errors
## B. BUDs (bottleneck, unnecessary, duplicated): optimization


# 1. When writing a function,
# try to avoid repetition by defining a new object or 
# by using a simple function like %in% instead of bunch of `|` (or).

  # Students' example
  (class(object)== "matrix" | class(object)=="array" | class(object)=="data.frame")
  
  # Better example
  class.obj = class(object)
  class.obj %in% c("matrix", "array", "data.frame")
  
  # example answer 1
  dim2 <- function(object) {
    class.obj <- class(object)
    out <- if (class.obj %in% c("matrix", "array", "data.frame")) {
        dim(object)
      } else if (class.obj %in% c("vector", "list")){
        length(object)
      } # is `else {NULL}` needed? No.
    return(out)
  }
  dim2(lm(1~1)); dim2(matrix(1,2,2)); dim2(list(1,2,3)); dim2(data.frame(1,2))
  
  # example answer 2: a student's answer
  dim2 <- function(object) {
    if (is.vector(object)) {
      length(object)
    } else {
      dim(object)
    }
  }
  dim2(lm(1~1)); dim2(matrix(1,2,2)); dim2(list(1,2,3)); dim2(data.frame(1,2))
  
# 2. `==TRUE` is unnecessary
  # unnecessary
  if (is.vector(x)==T) {
    
  }
  
  # okay
  if (is.vector(x)) {
    
  }
  
# 3. Coding convention
  # One of coding rules: NEVER change lines before `else`!
  # Read this style guide: https://google.github.io/styleguide/Rguide.xml
  
  # Bad example
  if ( ) {
    
  }
  else if ( ) {
    
  }

  # Good example
  if () {
    
  } else if ( ) {
    
  }
  
# 4. indexing in for loop
  # instead of pulling out the index,
  for (i in 1:length(files)) {
    read.csv(files[i])
  }
  
  # you can pull out the elements themselves.
  for (file in files) {
    read.csv(file)
  }
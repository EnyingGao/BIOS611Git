### data structures
  
  ## vector-type
    # vector
    1:7
    letters
    
    # matrix
    matrix(1:9, 3, 3)
    matrix(letters, 5, 3)
    
    # array
    array(1:15, dim = c(5, 3))
    array(1:30, dim = c(5, 3, 2))
    
  ## list-type
    # list
    list(1:3, letters, LETTERS)
    list(1, 2, 3, letters, LETTERS)
    
    # data.frame
    data.frame(1:26, letters, LETTERS)
    data.frame(number = 1:26, abc = letters, ABC = LETTERS)
    
  ## Access to data
    a = matrix(1:9, 3, 3, dimnames = list(1:3, letters[1:3]))
    
    # how to get number 5?
    a[2, 2]
    a["2", "b"]
    a[5]
    
    a.df = as.data.frame(a)
    a.df[2, 2]
    a.df["2", "b"]
    a.df[5]
    a.df[[2]]
    
    
    
### loop
    abc <- read.table(paste0(path, "exercise.dat"), header=T)
    
    head(abc)  

  ## for
    for (i in 3:9) {
      hist(abc[,i], main = names(abc)[i])
    }
    
    for (i in 3:9) {
      hist(abc[, i], main = names(abc)[i])
    }
    
    for (i in 1:10) {
      print(i^2)
    }
    
    a = 0
    for (i in 1:10) {
      a = a + i^2
    }
    a
    
    for (i in names(abc)[3:9]) {
      hist(abc[,i], main=i)
    }
    
    for (i in 3:9) {
      ggplot(abc, aes(x = y1)) + geom_histogram()
    }
    
    i = 1
    while (i < 10) {
      print(i)
      i = i + 1
    }
    
    i = 1
    repeat {
      print(i)
      i = i + 1
      if (i >= 10) break
    }
    
    data.by.center = array(1:27, c(3, 3, 3), 
                          dimnames = list(sample = 1:3, 
                                          variable = c("y1", "y2", "y3"), 
                                          center = LETTERS[1:3]))
    
    set.seed(1)
    xyz <-     
      list(fruit = c("apple", "banana", "apple", "grape", "tomato"),
           letters = sample(letters, 5),
           numbers = sample(1:10, 5, replace = TRUE))
    
    data.by.center = array(1:27, c(3, 3, 3), 
                           dimnames = list(sample = 1:3, 
                                           variable = c("y1", "y2", "y3"), 
                                           center = LETTERS[1:3]))
    apply(data.by.center, c(1, 2), mean)
    
    
    result <- list()
    for (i in 1:9) {
      result[[i]] <- table(abc[, i])
    }
    
    
    result <- list()
    for (i in 3:9) {
      result[[i]] <- 
        data.frame(x = abc[, i]) %>% ggplot(aes(x=x)) + geom_density()
    }
    
      
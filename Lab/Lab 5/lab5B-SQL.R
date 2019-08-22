################## DBI package ##################
# references: https://db.rstudio.com/getting-started/
# references: https://shiny.rstudio.com/articles/overview.html


### 0. install DBI package
install.packages("DBI")
install.packages("RMySQL")
library(DBI)


### 1. Setting up connection
  conn <- dbConnect(
    drv = RMySQL::MySQL(),
    dbname = "shinydemo",
    host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
    username = "guest",
    password = "guest")

### 2. List up tables
  dbListTables(conn)

### 3. Query
  dbGetQuery(conn, "SELECT * FROM City LIMIT 5;")
  
  # or
  rs <- dbSendQuery(conn, "SELECT * FROM City LIMIT 5;")
  dbFetch(rs)

### 4. Closing connection
  dbDisconnect(conn)

  
################## sqldf package ##################
# references: http://dept.stat.lsa.umich.edu/~jerrick/courses/stat701/notes/sql.html
 
### 0. package
  # detach("package:RMySQL", unload=TRUE)    # Removes interference from RMySQL package, if you did library(RMySQL).
  install.packages("sqldf")
  library(sqldf)
  
### 1. Query  
  sqldf('SELECT age, circumference FROM Orange WHERE Tree = 1 ORDER BY circumference ASC')
  sqldf('SELECT * FROM iris')
  
  
  
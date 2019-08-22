number_extract1 <- function(x) {
  as.numeric(
    substr(x, 1, str_locate(x, "\\[")-2)
  )
}

number_extract2 <- function(x) {
  as.numeric(
    str_extract(x, "\\d+\\d*")
  )
}
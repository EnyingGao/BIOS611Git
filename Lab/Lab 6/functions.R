compositional <- function(data, margin) {
  a <- apply(data, margin, function(x) {x/sum(x)})
  if (margin == 1) {a <- t(a)}
  return(a)
}

scatter <- function (x.index, y.index, data = dat2) {
  x <- data[x.index,-1] %>% unlist
  y <- data[y.index,-1] %>% unlist
  data.frame(x = x, y = y) %>% 
    ggplot(aes(x = x, y = y)) +
    geom_point() +
    xlab(data[x.index, 1] %>% as.character()) +
    ylab(data[x.index, 1] %>%  as.character())
}

scatterPDF <- function (filename, x.index, y.index, data) {
  pdf(filename)
  stopifnot(length(x.index) == length(y.index))
  if (length(x.index) != length(y.index)) {warning("lengths do not match.")}
  for (i in 1:length(x.index)) {
    scatter(x.index[i], y.index[i], data = data) %>%  print
  }
  dev.off()
}
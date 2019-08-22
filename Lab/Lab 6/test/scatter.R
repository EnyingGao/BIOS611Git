scatter <- function (x.index, y.index, data = dat2) {
  x <- data[x.index,-1] %>% unlist
  y <- data[y.index,-1] %>% unlist
  data.frame(x = x, y = y) %>% 
    ggplot(aes(x = x, y = y)) +
    geom_point() +
    xlab(data[x.index, 1] %>% as.character()) +
    ylab(data[x.index, 1] %>%  as.character())
}
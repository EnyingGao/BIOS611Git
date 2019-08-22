set.seed(1)
dat <- matrix(rpois(24, rep(1:4, each = 6)), 6)

apply(dat, 1, sum)
dat / apply(dat, 1, sum)

apply(dat, 2, sum)
t(t(dat) / apply(dat, 2, sum))

# 1 needs to transpose, 2 doesn't
apply(dat, 1, function(x) {x/sum(x)}) %>% t
apply(dat, 2, function(x) {x/sum(x)})

# formals
# body
compositional <- function(data, margin) {
  a <- apply(data, margin, function(x) {x/sum(x)})
  if (margin == 1) {a <- t(a)}
  return(a)
}

compositional(dat, 1)

library(tidyverse)
dat2 <- read_tsv("GSE92332_AtlasFullLength_TPM.txt")
head(dat2)

x <- dat2[1,-1] %>% unlist
y <- dat2[2,-1] %>% unlist

# To do a ggplot, we need data frame
data.frame(x = x, y = y) %>% 
  ggplot(aes(x = x, y = y)) +
  geom_point()

# Create a function
scatter <- function (x.index, y.index, data = dat2) {
  x <- data[x.index,-1] %>% unlist
  y <- data[y.index,-1] %>% unlist
  data.frame(x = x, y = y) %>% 
    ggplot(aes(x = x, y = y)) +
    geom_point() +
    xlab(data[x.index, 1] %>% as.character()) +
    ylab(data[x.index, 1] %>%  as.character())
}
# If we use dat2 a lot, we could specify in the function, but we can also change to other functions below
scatter(4, 3, data = dat)

pdf("example.pdf")
scatter(5, 3, data = dat2)
dev.off()

x.vec = 11:20
y.vec = 21:30
pdf("example.pdf")
for (i in 1:10) {
  scatter(x.vec[i], y.vec[i], data = dat2) %>%  print
}
dev.off()

# Write scatterPDF function
x.vec = 11:20
y.vec = 21:30
scatterPDF <- function (filename, x.index, y.index, data) {
  pdf(filename)
  stopifnot(length(x.index) == length(y.index))
  if (length(x.index) != length(y.index)) {warning("lengths do not match.")}
  for (i in 1:length(x.index)) {
    scatter(x.index[i], y.index[i], data = data) %>%  print
  }
  dev.off()
}

scatterPDF("example2.pdf", 11:15, 21:23, data = dat2)

or
scatterPDF <- function (filename, x.index, y.index, ...) {
  pdf(filename)
  for (i in 1:length(x.index)) {
    scatter(x.index[i], y.index[i], ...) %>%  print
  }
  dev.off()
}



compositional <- function(data, margin) {
  a <- apply(data, margin, function(x) {x/sum(x)})
  if (margin == 1) {a <- t(a)}
  return(a)
}
library(tidyverse)
library(testthat)
source("functions.R")

set.seed(1)
dat <- matrix(rpois(24, rep(1:4, each = 6)), 6)
dat2 <- read_tsv("GSE92332_AtlasFullLength_TPM.txt")

expect_equal(abs(5), 5)
expect_equal(abs(5), 4)

expect_is(scatter(1, 2, dat2), "ggplot")
expect_is(scatter(1, 2, dat2), "data.frame")

expect_error(compositional(dat, 1))
expect_error(scatterPDF(1, 2, dat3))

test_that("scatter", {
  expect_is(scatter(1,2,dat2),"ggplot")
  expect_error(scatter(1,2,dat3))
  # use expect_warning because we wrote that when encountering error, return a warning
  expect_warning(scatterPDF("example3.pdf", 1:5, 2:3, data = dat2))
})
# test_that won't stop in the middle

test_dir(".", reporter = "summary")

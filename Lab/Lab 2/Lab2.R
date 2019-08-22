library(dplyr)

fev <- read.csv('fev.csv', header = T)

fev %>%
  group_by(id) %>% 
  mutate(baseage = min(age), time = age - baseage) %>% 
  ggplot(aes(time, logfev1, col = as.factor(id))) +
  geom_line()

fev %>%
  group_by(id) %>% 
  mutate(baseage = min(age), baseht = min(ht), time = age - baseage) %>% 
  filter(baseage < 7 | baseht < 1.2) %>% 
  select(-age, -ht)

library(tidyr)
data.wide  <- data.frame(name = c( "Wilbur", "Petunia", "Gregory"),
                        a = c(67, 80, 64), b = c(56, 90, 50))
data.long <-
  data.wide  %>% 
  gather(key = drug, value = heartrate, a:b)

data.long  %>%
  spread (key = info, value = time)

set.seed(10)
data.wide  <- data.frame(
  id = 1:4,
  trt = sample(rep(c('control', 'treatment'), each = 2)),
  work.T1 = runif(4),
  home.T1 = runif(4),
  work.T2 = runif(4),
  home.T2 = runif(4)
)

set.seed(10)
data.long  <- data.wide %>%
  gather (key = info, value = time, -id, -trt)

library(knitr)
library(psych)
describe(iris) %>% kable
describeBy(iris, group = "Species")$setosa %>% kable

table(mtcars$cyl, mtcars$gear)
# table(row, column)

table(mtcars$cyl, mtcars$gear, mtcars$vs)

aggregate(Sepal.Length ~ Species, data = iris, FUN = mean)

# Data Visualization

data <- read.csv(file = 'fevRaw.csv')
data2 <- read.csv(file = 'fev.csv')
data2$id <- factor(data2$id)
data$id <- facto(data$id)
names(data2)
data.long <- melt(data2, id.vars = c('id','age'), measure.vars = c('ht', 'longfev1'))
data.long <- data2 %>% gather(key = 'variable', value = 'value', ht, logfev1)


# %*% calculate the density

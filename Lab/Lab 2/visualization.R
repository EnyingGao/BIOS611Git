setwd("~/Documents/bios611/lab2/")

library(reshape2)
library(ggplot2)
library(plotly)

data <- read.csv(file = "fevRaw.csv")
data2 <- read.csv(file = "fev.csv")
data2$id <- factor(data2$id)
data$id <- factor(data$id)
names(data2)
data.long <- melt(data2,id.vars = c("id", "age"), measure.vars = c("ht","logfev1"))
data.long <- data2 %>% gather(key = "variable", value = "value", ht, logfev1)

ggplot(data.long, aes(x=age, y=value)) +
  geom_line(aes(colour=id))+
  geom_point(aes(colour=id))+
  geom_smooth(method=lm,  linetype="dashed",
              color="darkred", fill="blue") +
  facet_grid(. ~ variable)

######### plotly from ggplot ###################
gg <- ggplot(data2, aes(x=age, y=logfev1))+
  geom_line(aes(colour=id))+
  geom_point(aes(colour=id))

p1 <- ggplotly(gg)
p1 #can double click on legend to isolate


################ plotly ##################
p2 <- plot_ly(data.long, x = ~value, color = ~variable, type = "box")
p2

p3 <- plot_ly(data, x=~ht,y=~age,z=~logfev1 ) 
p3

m <- matrix(rnorm(50*50), 50, 50)
p4 <- plot_ly(x = 1:50, y=1:50, z = m) %>% add_surface()
p4

x.norm = seq(-2,2,by = 0.05)
y.norm = seq(-2,2,by = 0.05)
m <- matrix(dnorm(x.norm)%*%t(dnorm(y.norm)), length(x.norm), length(y.norm))
p5 <- plot_ly(x = x.norm, y = y.norm, z = m) %>% add_surface()
p5



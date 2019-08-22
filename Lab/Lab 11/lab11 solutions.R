# Problem 1
WorldPhones %>% 
  data.frame() %>% 
  add_rownames("year") %>% 
  mutate(year = as.numeric(year)) %>% 
  gather(key = continent, value = phones, - year)  -> dat

lm.1 <- dat %>% 
  lm(phones ~ year * continent, .)
  
dat %>%
  add_predictions(lm.1) %>% 
  ggplot(aes(year, phones, col = continent)) +
  geom_point() +
  geom_line(aes(year, pred, col = continent)) +
  ylab("Number of phones")

# Problem 2
attitude

knn.tab <- data_frame(k = 1:10, wss = map_dbl(k, ~kmeans(attitude, .)$tot.withinss))
knn.tab %>%
  ggplot(aes(k, wss)) +
  geom_line()

k=3
km <- kmeans(attitude, 3)

attitude %>% 
  mutate(cluster = as.factor(km$cluster)) %>% 
  ggplot(aes(learning, complaints, col = cluster)) + 
  geom_point()


attitude %>% 
  mutate(cluster = as.factor(km$cluster)) %>% 
  ggplot(aes(learning, complaints, col = cluster)) + 
  geom_point() +
  geom_point(data= as.data.frame(km$centers), 
             aes(learning, complaints), col = "black", size=3)

  


library('tidyverse')

names <- c("S1","S2","S3","S4","S5")
hours_spent <- c(5,10,17,29,37)
high_score <- c(100,200,250,370,510)
data <- data.frame(names, hours_spent, high_score)
view(data)
data2 <- tibble(names, hours_spent, high_score)
view(data2)

ggplot(data, aes(hours_spent, high_score)) +
  geom_point() +
  geom_text(label = names)

?geom_text

ggplot(data, aes(hours_spent, high_score)) +
  geom_point() +
  geom_text(label = names, nudge_y = 20)

#======================================================
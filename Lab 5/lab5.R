library('tidyverse')

names <- c("S1","S2","S3","S4","S5")
hours_spent <- c(5,10,17,29,37)
high_score <- c(100,150,330,370,510)
data <- data.frame(names, hours_spent, high_score)
view(data)
data2 <- tibble(names, hours_spent, high_score)
view(data2)
data
ggplot(data, aes(hours_spent, high_score)) +
  geom_point() +
  geom_text(label = names)

?geom_text

ggplot(data, aes(hours_spent, high_score)) +
  geom_point() +
  geom_text(label = names, nudge_y = 20)

# Install ggrepel package
install.packages("ggrepel")
library("ggrepel")

ggplot(data, aes(hours_spent, high_score)) +
  geom_point() +
  geom_label_repel(label = names)

?geom_label_repel

#======================================================

age_group <- c('A','B','A','B','A')
data$age_group <- age_group

data


ggplot(data, aes(x = hours_spent, y = high_score, color = age_group)) +
  geom_line() +
  geom_label_repel(aes(label = age_group),
                    nudge_x = .75) +
  theme(legend.position = "none")


#======================================================================

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour = factor(cyl))) + 
  labs(
    x = "Engine displacement (litres)", 
    y = "Highway miles per gallon", 
    colour = "Number of cylinders",
    title = "Mileage by engine size and cylinders",
    subtitle = "Source: http://fueleconomy.gov"
  )


values <- seq(from = -2, to = 2, by = .01)
df <- data.frame(x = values, y = values ^ 3)
ggplot(df, aes(x, y)) + 
  geom_path() + 
  labs(y = quote(f(x) == x^3))

df <- data.frame(trt = c("a", "b", "c"), resp = c(1.2, 3.4, 2.5))
ggplot(df, aes(resp, trt)) + 
  geom_point() + 
  geom_text(aes(label = paste0("(", resp, ")")), nudge_y = -0.25) + 
  xlim(1, 3.6)

#one of the parameter is check_overlap. 
#If check_overlap = TRUE, overlapping labels 
#will be automatically removed from the plot. 
#The algorithm is simple: labels are plotted in 
#the order they appear in the data frame; 
#if a label would overlap with an existing point, 
#it’s omitted.

ggplot(mpg, aes(displ, hwy)) + 
  geom_text(aes(label = model)) + 
  xlim(1, 8)
ggplot(mpg, aes(displ, hwy)) + 
  geom_text(aes(label = model), check_overlap = TRUE) + 
  xlim(1, 8)

#At first glance this feature does not appear very useful, 
#but the simplicity of the algorithm comes in handy. 
#If you sort the input data in order of priority the 
#result is a plot with labels that emphasise important 
#data points.

#A variation on geom_text() is geom_label(): 
#it draws a rounded rectangle behind the text. 
#This makes it useful for adding labels to plots with 
#busy backgrounds:

label <- data.frame(
  waiting = c(55, 80), 
  eruptions = c(2, 4.3), 
  label = c("peak one", "peak two")
)

ggplot(faithfuld, aes(waiting, eruptions)) +
  geom_tile(aes(fill = density)) + 
  geom_label(data = label, aes(label = label))

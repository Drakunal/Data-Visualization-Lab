#install.packages("tidyverse")
library(tidyverse)
#package::function()
#ggplot2::ggplot()


#Let’s use our first graph to answer a question:
#Do cars with big engines use more fuel than cars with small engines?
#You probably already have an answer, but try to make your answer precise.
#What does the relationship between engine size and fuel efficiency look like?
#Is it positive? Negative? Linear? Nonlinear?
mpg
#to know more about the dataset
?mpg

#plot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

#The plot shows a negative relationship between engine size (displ) and fuel efficiency (hwy).
#In other words, cars with big engines use more fuel.



#syntax
#ggplot(data = <DATA>) + 
#  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))




#-------------------------------------------------------------------------------------------
#“The greatest value of a picture is when it forces us to notice what we never expected to see.” — John Tukey
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

#ggplot2 will automatically assign a unique level of the aesthetic (here a unique color) 
#to each unique value of the variable, a process known as scaling. 
#ggplot2 will also add a legend that explains which levels correspond to which values.






#In the above example, we mapped class to the color aesthetic, but we could have mapped class to the size
#aesthetic in the same way. In this case, the exact size of each point would reveal its class affiliation. 
#We get a warning here, because mapping an unordered variable (class) to an ordered aesthetic (size) is not
#a good idea.

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

#Or we could have mapped class to the alpha aesthetic, which controls the transparency of the points, 
#or to the shape aesthetic, which controls the shape of the points.

# based on transparency
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# based on shapes
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
#SUV gone

# set the aesthetic properties of your geom manually
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

#Here, the color doesn’t convey information about a variable, 
#but only changes the appearance of the plot. To set an aesthetic manually, 
#set the aesthetic by name as an argument of your geom function; i.e. it goes outside of aes().


#What is wrong here?????
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))

# install.packages("tidyverse")
library(tidyverse)
# package::function()
# ggplot2::ggplot()


# Let’s use our first graph to answer a question:
# Do cars with big engines use more fuel than cars with small engines?
# You probably already have an answer, but try to make your answer precise.
# What does the relationship between engine size and fuel efficiency look like?
# Is it positive? Negative? Linear? Nonlinear?
mpg
# to know more about the dataset
?mpg

# plot
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

# The plot shows a negative relationship between engine size (displ) and fuel efficiency (hwy).
# In other words, cars with big engines use more fuel.



# syntax
# ggplot(data = <DATA>) +
#  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))




#-------------------------------------------------------------------------------------------
# “The greatest value of a picture is when it forces us to notice what we never expected to see.” — John Tukey
#--------------------------------------------------------------------------------------------
# Aesthetics
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

# ggplot2 will automatically assign a unique level of the aesthetic (here a unique color)
# to each unique value of the variable, a process known as scaling.
# ggplot2 will also add a legend that explains which levels correspond to which values.






# In the above example, we mapped class to the color aesthetic, but we could have mapped class to the size
# aesthetic in the same way. In this case, the exact size of each point would reveal its class affiliation.
# We get a warning here, because mapping an unordered variable (class) to an ordered aesthetic (size) is not
# a good idea.

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

# Or we could have mapped class to the alpha aesthetic, which controls the transparency of the points,
# or to the shape aesthetic, which controls the shape of the points.

# based on transparency
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# based on shapes
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
# SUV gone

# set the aesthetic properties of your geom manually
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# Here, the color doesn’t convey information about a variable,
# but only changes the appearance of the plot. To set an aesthetic manually,
# set the aesthetic by name as an argument of your geom function; i.e. it goes outside of aes().




# Exercises
# What is wrong here?????
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))


# What happens if you map an aesthetic to something other than a variable name, like aes(colour = displ < 5)?
# What happens if you map the same variable to multiple aesthetics?



#---------------------------------------------------------------------------------------------
# Geometric Objects
# A geom is the geometrical object that a plot uses to represent data.
# People often describe plots by the type of geom that the plot uses.
# For example, bar charts use bar geoms, line charts use line geoms,
# boxplots use boxplot geoms, and so on. Scatterplots break the trend; they use the point geom.


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))


# smooth line fitted to the data
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

# Every geom function in ggplot2 takes a mapping argument.
# However, not every aesthetic works with every geom. You could set the shape of a point,
# but you couldn’t set the “shape” of a line. On the other hand, you could set the linetype of a line.
# geom_smooth() will draw a different line, with a different linetype, for each unique value of the
# variable that you map to linetype.



ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))


# Here geom_smooth() separates the cars into three lines based on their drv value,
# which describes a car’s drivetrain. One line describes all of the points with a 4 value,
# one line describes all of the points with an f value, and one line describes all of the points with an r
# value. Here, 4 stands for four-wheel drive, f for front-wheel drive, and r for rear-wheel drive.




ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )





# To display multiple geoms in the same plot, add multiple geom functions to ggplot():
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))


# This, however, introduces some duplication in our code.
# Imagine if you wanted to change the y-axis to display cty instead of hwy.
# You’d need to change the variable in two places, and you might forget to update one.
# You can avoid this type of repetition by passing a set of mappings to ggplot(). ggplot2 will
# treat these mappings as global mappings that apply to each geom in the graph.
# In other words, this code will produce the same plot as the previous code:

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()



# If you place mappings in a geom function, ggplot2 will treat them as local mappings for the layer.
# It will use these mappings to extend or overwrite the global mappings for that layer only.
# This makes it possible to display different aesthetics in different layers.


ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth()





# You can use the same idea to specify different data for each layer.
# Here, our smooth line displays just a subset of the mpg dataset,
# the subcompact cars. The local data argument in geom_smooth() overrides
# the global data argument in ggplot() for that layer only.


ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)


# Exercises
# 1) What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?

# 2) Run this code in your head and predict what the output will look like.
# Then, run the code in R and check your predictions.

# ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
# geom_point() +
# geom_smooth(se = FALSE)


# 3) What does show.legend = FALSE do? What happens if you remove it?

# 4) What does the se argument to geom_smooth() do?

# 5) Will these two graphs look different? Why/why not?

# first
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

# second
ggplot() +
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

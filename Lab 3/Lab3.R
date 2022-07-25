library('tidyverse')
#---------------------------------------------------------
#Facets
#---------------------------------------------------------

#One way to add additional variables is with aesthetics. 
#Another way, particularly useful for categorical variables, 
#is to split your plot into facets, subplots that each 
#display one subset of the data.

?mpg

#To facet your plot by a single variable, 
#use facet_wrap(). The first argument of facet_wrap() 
#should be a formula, which you create with ~ followed
#by a variable name (here “formula” is the name of
#a data structure in R, not a synonym for “equation”). 
#The variable that you pass to facet_wrap() 
#should be discrete.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

#To facet your plot on the combination of two variables, 
#add facet_grid() to your plot call. 
#The first argument of facet_grid() 
#is also a formula. This time the formula should 
#contain two variable names separated by a ~.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
#If you prefer to not facet in the rows or columns dimension, 
#use a . instead of a variable name, e.g. 
#+ facet_grid(. ~ cyl).
#Exercise
# 1) What happens if you facet on a continuous variable?
  
# 2) What do the empty cells in plot with facet_grid(drv ~ cyl)
# mean? How do they relate to this plot?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))


# 3) What plots does the following code make? What does . do?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)


# 4) Take the first faceted plot in this section:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)


#What are the advantages to using faceting instead 
#of the colour aesthetic? 
#What are the disadvantages? 
#How might the balance change if you had a larger dataset?


  
# 5) Read ?facet_wrap. What does nrow do? 
#What does ncol do? What other options control the
#layout of the individual panels? Why doesn’t 
#facet_grid() have nrow and ncol arguments?
  
# 6) When using facet_grid() you should 
#usually put the variable with more unique 
#levels in the columns. Why?


#---------------------------------------------------------
#Statistical Transformation
#---------------------------------------------------------
diamonds

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))



demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))

ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )


#Exercises




#---------------------------------------------------------
#Position Adjustments
#---------------------------------------------------------

#There’s one more piece of magic associated with bar charts.
#You can colour a bar chart using either the colour
#aesthetic, or, more usefully, fill:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))



#Note what happens if you map the fill 
#aesthetic to another variable, like clarity: 
#the bars are automatically stacked. 
#Each colored rectangle represents a combination 
#of cut and clarity.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))


#The stacking is performed automatically by the 
#position adjustment specified by the position argument. 
#If you don’t want a stacked bar chart, 
#you can use one of three other options: 
#"identity", "dodge" or "fill".




# ---- position = "identity" 
# will place each object exactly where it falls in 
#the context of the graph. This is not very useful 
#for bars, because it overlaps them. 
#To see that overlapping we either need to make the 
#bars slightly transparent by setting alpha to a small
#value, or completely transparent by setting fill = NA.
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")
#The identity position adjustment is more useful for 2d geoms, 
#like points, where it is the default.


# ---- position = "fill" works like stacking, 
#but makes each set of stacked bars the same 
#height. This makes it easier to compare proportions 
#across groups.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")



# ---- position = "dodge" places overlapping objects 
#directly beside one another. This makes it easier to 
#compare individual values.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")




#There’s one other type of adjustment that’s not 
#useful for bar charts, but it can be very 
#useful for scatterplots. Recall our first scatterplot. 
#Did you notice that the plot displays only 126 points,
#even though there are 234 observations in the dataset?



#The values of hwy and displ are rounded so the points 
#appear on a grid and many points overlap each other.
#This problem is known as overplotting.
#This arrangement makes it hard to see where the mass
#of the data is. Are the data points spread 
#equally throughout the graph, or
#is there one special combination of hwy and displ that
#contains 109 values?

#You can avoid this gridding by setting 
#the position adjustment to “jitter”. 
#position = "jitter" adds a small amount 
#of random noise to each point. This spreads 
#the points out because no two points are likely
#to receive the same amount of random noise.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

#Adding randomness seems like a strange way to 
#improve your plot, but while it makes your graph 
#less accurate at small scales, it makes your graph
#more revealing at large scales. 
#Because this is such a useful operation, 
#ggplot2 comes with a shorthand for 
#geom_point(position = "jitter"): geom_jitter().

#To learn more about a position adjustment, 
#look up the help page associated with 
#each adjustment: 
#?position_dodge, ?position_fill, ?position_identity,
#?position_jitter, and ?position_stack.


#Exercises
# 1) What is the problem with this plot? 
#How could you improve it?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()

# 2) What parameters to geom_jitter() control the amount of jittering?
  
# 3) Compare and contrast geom_jitter() with geom_count().

# 4) What’s the default position adjustment for 
#geom_boxplot()?
#Create a visualisation of the mpg dataset that 
#demonstrates it.

#---------------------------------------------------------
#Coordinate systems
#---------------------------------------------------------

#Coordinate systems are probably the most complicated 
#part of ggplot2. The default coordinate system is the 
#Cartesian coordinate system where the x and y positions 
#act independently to determine the location of each point. 
#There are a number of other coordinate systems that are 
#occasionally helpful.

#coord_flip() switches the x and y axes. 
#This is useful (for example), 
#if you want horizontal boxplots. 
#It’s also useful for long labels: 
#it’s hard to get them to fit without overlapping on the x-axis.
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()


#coord_quickmap() sets the aspect ratio 
#correctly for maps. This is very important 
#if you’re plotting spatial data with ggplot2 
nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()




#coord_polar() uses polar coordinates. 
#Polar coordinates reveal an interesting connection 
#between a bar chart and a Coxcomb chart.
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()


#Exercises
# 1) Turn a stacked bar chart into a pie chart using 
# coord_polar().

# 2) What does labs() do? Read the documentation.

# 3) What’s the difference between coord_quickmap() 
#and coord_map()?
  
# 4) What does the plot below tell you about
#the relationship between city and highway mpg? 
#Why is coord_fixed() important? What does geom_abline() do?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed()
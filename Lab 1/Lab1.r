#setwd("give the path")
airquality = read.csv('airquality.csv',header=TRUE, sep=",")

#data exploration
str(airquality)


head(airquality)
tail(airquality)

summary(airquality)


#some basic plots using the Base R functions
plot(airquality$Ozone)


#plot between ozone and wind value
plot(airquality$Ozone, airquality$Wind) #shows negative correlation


plot(airquality)

#We get a matrix of scatterplots which is a correlation matrix of all the columns.
#The plot above instantly shows that:
  
#  --The level of Ozone and Temperature is correlated positively.
#  --Wind speed is negatively correlated to both Temperature and Ozone level.
#We can quickly discover the relationship between variables by merely looking
#at the plots drawn between them.







#The plot function has an argument called type which can take in values like
#p: points, l: lines,b: both etc. This decides the shape of the output graph.

# points and lines 
plot(airquality$Ozone, type= "b")

# high density vertical lines.
plot(airquality$Ozone, type= "h")
#checkout more about plot
?plot()



#adding labels, title and color

plot(airquality$Ozone, xlab = 'ozone Concentration',
     ylab = 'No of Instances', main = 'Ozone levels in NY city', col = 'green')

# Horizontal bar plot
barplot(airquality$Ozone, main = 'Ozone Concenteration in air',
        xlab = 'ozone levels', col= 'green',horiz = TRUE)


# Vertical bar plot
barplot(airquality$Ozone, main = 'Ozone Concenteration in air',
        xlab = 'ozone levels', col='red',horiz = FALSE)

#histogram
hist(airquality$Solar.R)


hist(airquality$Solar.R, main = 'Solar Radiation values in air',xlab = 'Solar rad.', col='red')


#boxplot
#Single box plot
boxplot(airquality$Solar.R)
# Multiple box plots
boxplot(airquality[,0:4], main='Multiple Box plots')


#grid of charts

#There is a very interesting feature in R
#which enables us to plot multiple charts at once.
#This comes in very handy during the EDA since the need to plot
#multiple graphs one by one is eliminated.
#For drawing a grid, the first argument should specify
#certain attributes like the margin of the grid(mar),
#no of rows and columns(mfrow), whether a border is to be included(bty)
#and position of the labels(las: 1 for horizontal, las: 0 for vertical).

par(mfrow=c(3,3), mar=c(2,5,2,1), las=1, bty="n")
plot(airquality$Ozone)
plot(airquality$Ozone, airquality$Wind)
plot(airquality$Ozone, type= "c")
plot(airquality$Ozone, type= "s")
plot(airquality$Ozone, type= "h")
barplot(airquality$Ozone, main = 'Ozone Concenteration in air',xlab = 'ozone levels', col='green',horiz = TRUE)
hist(airquality$Solar.R)
boxplot(airquality$Solar.R)
boxplot(airquality[,0:4], main='Multiple Box plots')


#Refer to this for the attributes in the above - http://rfunction.com/archives/1302

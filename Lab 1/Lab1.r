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

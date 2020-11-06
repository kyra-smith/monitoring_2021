# comment

# R code for plotting the relationship amongn ecological variables
# sp package is for spatial data 
# packages have reference manuals and vignettes!
# R journal lists and describes packages

# how to install a package
install.packages("sp")
# call library
library(sp)

# load dataset
data(meuse)

# look inside the dataset
meuse

# view data in table using "View" function (capitalization is important)
View(meuse)

# see the head of the dataset (first 6 rows)
head(meuse)

# exercise: mean of all variables
summary(meuse)

# make a plot of relationship between Cadmium and Zinc (x vs y ; cadmium vs zinc)
# first, define cadmium and zinc
cadmium<-meuse$cadmium
zinc<-meuse$zinc
# then plot them against each other
plot(cadmium,zinc)
# jazz it up
plot(cadmium, zinc, col="pink", cex=3 main="Cd vz Zn")

# Question: how to pair only the elements parts of the dataset (so just the four metals)
# can also use "attach" function instead of "$"
attach(meuse)
plot(cadmium, zinc)
plot(cadmium, lead)

# want to make scatter plot matrix
pairs(meuse)

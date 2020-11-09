#### Friday, November 6, 2020 ####
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

#### Monday, November 9, 2020 ####

# 2020-11-09
# lecture #2 ecological variables

# call library for sp
library(sp)

# load dataset
data(meuse)

# see data
meuse

# look at the first 6 rows
head(meuse)

# how to make a scatterplot with just the metals
# need just columns 3,4,5,6
# use a quadratic bracket to include the four columns and all the rows)
# use a comma to introduce new argument, so the above line says (start from 3, go to 6)

pairs(meuse[,3:6])

# Q: How does R know we are talking about columns and not rows? A: columns are the default; we would have to tell it more in order to isolate rows
# Q: does R start counting from 0 or 1? A: 1

# another method
pairs(~cadmium + copper + lead + zinc, data=meuse)

# "~" means "equal"
# so the pairs will = what follows the tilde

# time to prettify the graph
# change the colour
 pairs(~cadmium + copper + lead + zinc, data=meuse, col="sienna1")
 
# we can also change the colours of the individual graphs using the par() function

# now change the symbols to a filled triangle
pairs(~cadmium + copper + lead + zinc, data=meuse, col="sienna1", pch=17)
# no increase size of triangles
pairs(~cadmium + copper + lead + zinc, data=meuse, col="sienna1", pch=17, cex=2.5)



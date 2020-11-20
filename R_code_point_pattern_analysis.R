#### 2020-11-20 ####
# lecture 5 # point pattern analysis
# install package "spatstat"
install.packages("spatstat")
library(spatstat)

# set working directory
setwd("C:/Lab/")

# covid data
covid<-read.csv("covid_agg.csv", header=TRUE) 
covid

# attach covid data
attach(covid)

# we need to explain to R what coordinates we are using, their range, and their name
# lets's make a planar point pattern in spatstat
# tell R what to use for: x, y, lower limit of x, upper limit of x, lower limit of y, upper limit of y
# so even though the data doesn't range from -180 to 180 and -90 to 90, that is the size of the map we want to make
covid_planar<-ppp(lon,lat,c(-180, 180), c(-90, 90))

# now we can make the density
density_map<-density(covid_planar)

# plot the density map
plot(density_map)

# we can show the points layered on top of the map 
points(covid_planar)

# we can change the colours of the map
# '100' tells R how many colours to use in the palette
cl<-colorRampPalette(c('yellow','orange','red'))(100)
plot(density_map,col=cl)

# put countries on top of the map
# need a new package "rgdal"
install.packages("rgdal")


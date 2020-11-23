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

#### 2020-11-23 ####
# lecture 6 # point pattern analysis

# repeat previous lesson in R, then continue below
# open rgdal library
library(rgdal)

# import coastlines
coastlines<-readOGR("ne_10m_coastline.shp")
coastlines

# plot covid map again with coastlines
plot(density_map)
points(covid_planar)
plot(coastlines, add = TRUE) # say "add  = TRUE" so that R knows we do want to add coastlines to the existing map, and not create a new one

# change the colour ramp
# change point symbol
cl <- colorRampPalette(c('pink','green','orange','red','magenta'))(100) # 
plot(density_map, col = cl)
points(covid_planar, pch = 19) # one point per country, no matter how many cases they have, so density is much higher in Europe just because there are more countries in a smaller space 
plot(coastlines, add = TRUE)

cl <- colorRampPalette(c('pink','green','orange','red','magenta'))(100) # 
plot(density_map, col = cl)
points(covid_planar, pch = 19, cex = 0.5)
plot(coastlines, add = TRUE)

# save as a .png file
png("figure1.png")
cl <- colorRampPalette(c('pink','green','orange','red','magenta'))(100) #
plot(density_map, col = cl)
points(covid_planar, pch = 19, cex = 0.5)
plot(coastlines, add = TRUE)
dev.off()

# save as a .pdf
pdf("figure1.pdf")
cl <- colorRampPalette(c('pink','green','orange','red','magenta'))(100) # 
plot(density_map, col = cl)
points(covid_planar, pch = 19, cex = 0.5)
plot(coastlines, add = TRUE)
dev.off()

# use ggsave to alter size of saved image

# interpolating case data
# tell R to use cases
# this shifts the density to the number of cases per country ? Watch lecture
marks(covid_planar)<-cases
cases_map<-Smooth(covid_planar)
plot(cases_map, col = cl)
points(covid_planar)
plot(coastlines, add = T)

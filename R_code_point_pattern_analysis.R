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

### 2020-11-27 ###
# lecture 7

# interpolate new data
# plotting points with different sizes related to covid data together with the interpolated map

# set working directory
setwd("C:/Lab/")

# covid data
covid<-read.csv("covid_agg.csv", header=TRUE) 
covid

# attach covid data
attach(covid)

# load spatstat and rgdal
library(spatstat)
library(rgdal)

# install sf
install.packages("sf")
library(sf)

# load covid data
covid<-read.csv("covid_agg.csv", header=TRUE) 
covid

# check data
head(covid)

# attach covid
attach(covid)

# watch lecture and add comments
covid_planar <- ppp(lon, lat, c(-180,180), c(-90,90))


# add colour palette
Spoints <- st_as_sf(covid, coords = c("lon", "lat"))
marks(covid_planar) <- cases # interpolation
cases_map <- Smooth(covid_planar) # interpolation
cl <- colorRampPalette(c('lightpink2','lightsalmon','tomato1','red3','maroon'))(100)
density_map <- density(covid_planar)
plot(density_map)
plot(cases_map, col = cl)
plot(coastlines, add = T)
plot(Spoints, cex=Spoints$cases/10000, col = 'purple3', lwd = 3, add=T)

# plot points according to number of cases?
plot(Spoints, cex=Spoints$cases, col = 'purple3', lwd = 3, add=T)

# divide cases by 10 000
cl <- colorRampPalette(c('lightpink2','lightsalmon','tomato1','red3','maroon'))(100)
plot(cases_map, col = cl)
plot(Spoints, cex=Spoints$cases/10000, col = 'purple3', lwd = 3, add=T)

coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)

#### 2020-11-30 ####
# lecture 8 # UTMs and Leonardo's data

# set working directory
setwd("C:/Lab/")

# load Zabotti data (about the lagoon)
lagoon<-read.csv("dati_zabotti.csv", header=TRUE, sep=",") # says that commas separate the data (not sure if this is necessary)
lagoon

# call library 'spatstat'
library(spatstat)

# check, attach, summarize the data
head(lagoon)
attach(lagoon)
summary(lagoon)

# need to make a density and a smooth map
# need to explain to using 'marks'
# first make a ppp something
lagoon_ppp <- ppp(x, y, c(2300000,2325000), c(5005000,5045000))

# plot density map
density_map<-density(lagoon_ppp)
plot(density_map)
# add points to the map of sites where data was taken
points(lagoon_ppp)

#### 2020-12-04 ####
# lecture 8 # interpolation

# set working directory
setwd("C:/Lab/")

# load library
library(spatstat)

# load RData
load("point_pattern_analysis.RData")
# see list of files inside the Rdata (# remember that you called it 'lagoon', not 'leo' in the last lecture)
ls()

# check and attach the data
head(leo)
attach(leo)

# something
marks(leo_ppp)<-chlh
chlh_map<-Smooth(leo_ppp)
plot(chlh_map)
point(leo_ppp)

# there is too much blue, so we will make a new palette
cl<-colorRampPalette(c('yellow','orange','red','green'))(100)
plot(chlh_map, col=cl)
points(leo_ppp)

# chlorophyll on the west side is lowers
# the green part of the map is the part of the lagoon with the highest productivity
# he wants us to do the same thing but for chlorophyll in the sediments (chls)

marks(leo_ppp)<-chls
chls_map<-Smooth(leo_ppp)
plot(chls_map)
points(leo_ppp)

# there is too much blue, so we will make a new palette
cl<-colorRampPalette(c('yellow','orange','red','green'))(100)
plot(chls_map, col=cl)
points(leo_ppp)

# make a multipanel
# par function
# mf = "multiframe"
# mfrow = "I want these many rows and columns in the panel
#par(mfrow = c(1,3)) means I want 1 row and 3 columns

# density map first
plot(density_map,col=cl)
points(leo_ppp)

# then map of chlorophyll in water (chlh)
plot(chlh_map, col=cl)
points(leo_ppp)

# then map of chlorophyll in sediments (chls)
plot(chls_map, col=cl)
points(leo_ppp)

# altogether now
par(mfrow = c(1,3))
plot(density_map,col=cl)
points(leo_ppp)
plot(chlh_map, col=cl)
points(leo_ppp)
plot(chls_map, col=cl)
points(leo_ppp)

# exercise: do it again, but with 3 rows and 1 column

par(mfrow = c(3,1))
plot(density_map,col=cl)
points(leo_ppp)
plot(chlh_map, col=cl)
points(leo_ppp)
plot(chls_map, col=cl)
points(leo_ppp)





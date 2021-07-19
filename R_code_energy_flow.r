# R_code_ecosystem_functions.r
### 2021-01-15###

# R code to view biomass over the world and calculate changes in ecosystem functions
# energy
# chemical cycling
# proxies

# install packages with copNDVI
install.packages("rasterdiv")
install.packages("rasterVis")

library(rasterVis)
library(rasterdiv)

data(copNDVI)
plot(copNDVI)

# we should remove the blue and brown parts because we don't need them
# why do we have these values(253:255)?
# an image can be coded in diff manners (simplest: 0-100; simple: 0-255 (8 bit))
# 1 bit is 2 (2^1=2) values (0 or 1)
# 8 bit is 256 (2^8 = 256)values
# 0-255
# 253, 254, 255 are codes for the blue values (set by the package)
# we must reclassify them to be "NA"

copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
levelplot(copNDVI)

# levelplot will show the values of NDVI in each column and row
# points will be connected to form a line graph

# let's play with colours
# our eyes are drawn to yellow, so it is used to deceive us
# clymin = "colour yellow minimum"
clymin<-colorRampPalette(c('yellow','red','blue'))(100)
plot(copNDVI,col=clymin)

# switch yellow to the intermediate part
# clymed = "colour yellow medium"
clymed<-colorRampPalette(c('red','yellow','blue'))(100)
plot(copNDVI,col=clymed)

# switch yellow to the maxima part
# clymax = "colour yellow maximum"
clymax<-colorRampPalette(c('red','blue','yellow'))(100)
plot(copNDVI,col=clymax)

# let's reorder the colours by how well we see them (Blue --> red --> yellow)
clymax2<-colorRampPalette(c('blue','red','yellow'))(100)
plot(copNDVI,col=clymax2)

# let's use par() to put them side by side and compare impact of colour use
par(mfrow=c(1,2))
clymin<-colorRampPalette(c('yellow','red','blue'))(100)
plot(copNDVI,col=clymin)
clymax2<-colorRampPalette(c('blue','red','yellow'))(100)
plot(copNDVI,col=clymax2)

# crop the map to see only Italy
# 0-20 is the longitude (x); 35-55 is the latitude (y)
# c(xmin,xmam,ymin,ymax)
italy_ext<-c(0,20,35,55)
copNDVI_Italy<-crop(copNDVI,italy_ext)
# plot using the blue-->red-->yellow colour palette
plot(copNDVI_Italy,col=clymax2)

copNDVI10 <- aggregate(copNDVI, fact=10)
levelplot(copNDVI10)

copNDVI100 <- aggregate(copNDVI, fact=100)
levelplot(copNDVI100)

####################################
# Deforestation Example
### 2021-01-18 ###

# library(ggplot2)

# myPalette <- colorRampPalette(c('white','green','dark green'))
# sc <- scale_colour_gradientn(colours = myPalette(100), limits=c(1, 8))

# ggR(copNDVI, geom_raster = TRUE) +
# scale_fill_gradientn(name = "NDVI", colours = myPalette(100))+
# labs(x="Longitude",y="Latitude", fill="")+
#   theme(legend.position = "bottom") +
#  NULL

# R code for energy flow 2

#### 2021-01-18 ####
# lecture 13 

# Deforestation example
# load libraries
library(raster)
library(RStoolbox)


#set working directory
setwd("C:/Lab/") 

# need to use 'brick'
# import deforestation photos

defor1 <- brick("defor1_.jpg")
defor2 <- brick("defor2_.jpg")

# we can look at the details of the .jpg
defor1

# b/c the min value = 0 and max = 255, this is an 8 bit photo
# 1 bit has 2^1 (2) outcomes: 0,1
# 2 bit has 2^2 (4) outcomes: 00, 01, 10, 11
# we can assign values to these outcomes (so 00->0, 01->1, 10->2, 11->3)
# then we assign a colour to each value (so we have four colours)
# 8 bit has 2^8 (256) outcomes, so the values are 0 to 255, and we have 256 colours

# RGB scheme
# we have three bands (1,2,3)
# band1: NIR, defor1_.1
# band2: red, defor1_.2 (the landscape as scene by sensors that see only the red wavelengths)
# band3: green

# by assiging NIR band to the red component, we are telling R to display Near Infrared as the colour red
# this shows vegetation as red bc leaves reflect NIR 
# if we assigned the NIR to the green component will display vegetation at green
# "stretch" enhances the colours

plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")


# Exercise: put images one beside the other with par()
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

# the amount of sediment in the water changes the colour of the water
# in defor1, there was probably more sediement in the water
# clearer water will absorb more NIR light, returning a black colour in the image

# calculate the vegetation indices
# each band ranges from 0 - 255, so let's say the NIR in plants is represented by 250
# plants absorb red light, so lets say red is represented by 10
# dvi = different vegetation index = NIR-Red = 250-10 = 240
# calcualte DVI again, at a later date, and compare to see if there was a change


# dvi for the first period
dvi1 <- defor1$defor1_.1 - defor1$defor1_.2

# when we pull up the summary of defor1, it tells us the name of the layers
# defor1_.1 is the NIR band, defor1_.2 is the red band
# we want R to go through defor1 pixel by pixel and subtract the value of the pixels in the red band from the pixels in the NIR band

dev.off()# undoes the par function
plot(dvi1)

# the higher the amount of biomass, the higher the DVI, the darker the green

# let's change the colour
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi1, col=cl)

# dvi2 after the cut!
dvi2 <- defor2$defor2_.1 - defor2$defor2_.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi2, col=cl)

# put images one beside the other with par()
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI before cut")
plot(dvi2, col=cl, main="DVI after cut")

# difference biomass before cut and after cut
difdvi <- dvi1 -dvi2
dev.off()
plot(difdvi)

cldif <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cldif, main="amount of energy lost!")

# shows the frequencies of differences in DVI
hist(difdvi, col="red")

####### final par!
# defor1
# defor2
# dvi1
# dvi2
# difdvi
# histogram


par(mfrow=c(3,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")
plot(dvi1, col=cl, main="biomass before cut")
plot(dvi2, col=cl, main="biomass after cut")
plot(difdvi, col=cldif, main="amount of energy lost!")
hist(difdvi, col="red")









# R_code_ecosystem_functions.r

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

# library(ggplot2)

# myPalette <- colorRampPalette(c('white','green','dark green'))
# sc <- scale_colour_gradientn(colours = myPalette(100), limits=c(1, 8))

# ggR(copNDVI, geom_raster = TRUE) +
# scale_fill_gradientn(name = "NDVI", colours = myPalette(100))+
# labs(x="Longitude",y="Latitude", fill="")+
#   theme(legend.position = "bottom") +
#  NULL


setwd("~/lab/")
# setwd("/Users/utente/lab") #mac
# setwd("C:/lab/") # windows

library(raster)

defor1 <- brick("defor1_.jpg") 
defor2 <- brick("defor2_.jpg") 

# band1: NIR, defor1_.1
# band2: red, defor1_.2
# band3: green

plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

dvi1 <- defor1$defor1_.1 - defor1$defor1_.2 

# defor2
# band1: NIR, defor2_.1
# band2: red, defor2_.2

dvi2 <- defor2$defor2_.1 - defor2$defor2_.2 

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
par(mfrow=c(1,2))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

difdvi <- dvi1 - dvi2

cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)

hist(difdvi)










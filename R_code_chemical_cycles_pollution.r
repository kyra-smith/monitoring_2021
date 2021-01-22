#### 2021-01-20 ####
# lecture 14 

# R_code_chemical_cycles_pollution.r

# set working directory and load libraries
setwd("C:/Lab/") 
library(raster)

# import images
EN01 <- raster("EN_0001.png")
EN02 <- raster("EN_0002.png")
EN03 <- raster("EN_0003.png")
EN04 <- raster("EN_0004.png")
EN05 <- raster("EN_0005.png")
EN06 <- raster("EN_0006.png")
EN07 <- raster("EN_0007.png")
EN08 <- raster("EN_0008.png")
EN09 <- raster("EN_0009.png")
EN10 <- raster("EN_0010.png")
EN11 <- raster("EN_0011.png")
EN12 <- raster("EN_0012.png")
EN13 <- raster("EN_0013.png")

# Otherwise: (this is another way to import them, and make a stack (which we will do at the end))
# rlist <- list.files(pattern="EN")
# rlist 
# list_rast <- lapply(rlist, raster)
# ENstack <- stack(list_rast)

cl <- colorRampPalette(c('red','orange','yellow'))(100) # red=min NO2, yellow=max NO2 

par(mfrow=c(1,2))
plot(EN01, col=cl)
plot(EN13, col=cl)

dev.off()
difno2 <- EN01 - EN13
cldif <- colorRampPalette(c('blue','black','yellow'))(100) # 
plot(difno2, col=cldif)

# Do you want a video? Here it is!
# https://www.r-bloggers.com/2018/10/the-av-package-production-quality-video-in-r/

# we did not make a video
# video like
# plot(EN01, col=cl)
# plot(EN02, col=cl)
# plot(EN03, col=cl)
# plot(EN04, col=cl)
# plot(EN05, col=cl)
# plot(EN06, col=cl)
# plot(EN07, col=cl)
# plot(EN08, col=cl)
# plot(EN09, col=cl)
# plot(EN10, col=cl)
# plot(EN11, col=cl)
# plot(EN12, col=cl)
# plot(EN13, col=cl)

par(mfrow=c(4,4))
plot(EN01, col=cl)
plot(EN02, col=cl)
plot(EN03, col=cl)
plot(EN04, col=cl)
plot(EN05, col=cl)
plot(EN06, col=cl)
plot(EN07, col=cl)
plot(EN08, col=cl)
plot(EN09, col=cl)
plot(EN10, col=cl)
plot(EN11, col=cl)
plot(EN12, col=cl)
plot(EN13, col=cl)


# make a stack
EN <- stack(EN01,EN02,EN03,EN04,EN05,EN06,EN07,EN08,EN09,EN10,EN11,EN12,EN13)
plot(EN, col=cl)

# plot(RGB)
# put EN01 (the first image) as blue, EN13 as red, and EN07 as green
# if one colour shows up more than the others, it means the values were highest in that month for that pixel
dev.off()
plotRGB(EN, red=EN13, green=EN07, blue=EN01, stretch="lin")

# boxplot
# dev.off()
# we are making a boxplot with the stack
# orient the boxes horizontally
boxplot(EN,horizontal=T,axes=T,outline=F,col="red",xlab="NO2 - 8bit", ylab="Period")

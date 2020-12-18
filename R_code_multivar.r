# R_code_multivar.r
# R code for multivariate analysis

#### 2020-12-11 ####
# lecture 9 # multivariate analysis

# set working directory
setwd("C:/Lab/")

# install.packages("vegan")
library(vegan)

# load biomes Rdata
load("biomes_multivar.RData")

# see list of files inside the Rdata
ls()

# check data
head(biomes)

# DEtrended CORrespondence ANAlysis
multivar <- decorana(biomes)
multivar

# add together all the eigenvalues, then take the ratio of each eigenvalue against the sum
# the two DCAs that when added together sum to 50+% are the two DCAs used in the multivariate plot

plot(multivar) # do not closed it after shown!!!

# biomes types
head(biomes_types)

attach(biomes_types)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind = "ehull", lwd=3)
# or col=1:4
# "ordiellipse" tells R to put an ellipse in the ordination
# "multivar" applies it to the plot we already made
# "type" tells it to organize by biome type
# "col=c(...)" assigns colours to each biome type
# "kind" tells it what shape to use

ordispider(multivar, type, col=c("black","red","green","blue"), label = T) 
# "orderspider" makes a web, like a spider
# "type" tells it to organize by biome type
# "col=c(...)" assigns colours to each biome type
# "label = T" tell it to include the labels for biome types

# save graphs as pdf
pdf("figure_multivar.pdf")
plot(multivar)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind = "ehull", lwd=3) 
ordispider(multivar, type, col=c("black","red","green","blue"), label = T)  

# 2020-11-13
# lecture #3 spatial elements

# R spatial

# call the "sp" library
library(sp)

# load data "meuse"
data(meuse)
head(meuse)

# what are the main coordinates of the data? x and y
# tell R what the coordinates are
# the tilde, "~", groups several things together
coordinates(meuse)=~x+y
# if we just plot the set of coordinates as is, 
plot(meuse)

# make a new "fancy" plot with some of the elements
# let's look at zinc only
# use spplot to plot elements like zinc
# we can colour the points to indicate zinc level (?)
spplot(meuse,"zinc",main="Concentration of Zinc")

# this produces scatterplot of zinc, with values split into groups based on concentration (kind of like a binned distribution), and assigned a colour to differentiate them
# now do the same for copper (I added basic axis labels)
spplot(meuse,"copper",main="Concentration of Copper",xlab="x",ylab="y")

# now put zinc and copper together but in two different panels
# we are going to make an array (a set of objects)
# need to use the "c" 
spplot(meuse,c("zinc","copper"),main="Concentration of Zinc and Copper",xlab="x",ylab="y")

# problem: they will use the same legend, so copper has lower values than zinc but their values are grouped the same way, so all of copper's values fall into the lowest group
# zinc has higher values in the west (left side of the graph) 
# because of a river? 
# zinc anc copper are near the river, so the river is bringing toxic metals to the area

# we can use another function, "bubble", which creates a bubble plot
# uses bubble dimensions instead of colours to communicate data
bubble(meuse,"zinc")

# do the same for lead
bubble(meuse,"lead")

# again, the western part is higher
# change colour
bubble(meuse,"lead",col="red")

#### 2020-11-16 ####
# lecture #4 # installing the ggplot2 library 

# 2020-11-16
# lecture #4 # installing the ggplot2 library 

# load the library
library(ggplot2)

# make a dataframe
# biofuels
biofuels<-c(120, 200, 350, 570, 750) #create an array using 'c'

# oxidative enzymes
oxidative<-c(1200, 1300, 21000, 34000, 50000)

# making a dataframe
d<-data.frame(biofuels,oxidative)

# make a graph using ggplot
fig1<-ggplot(d,aes(x=biofuels, y=oxidative))+ geom_point ()
fig1

# making it fancy by changing the point size and colour
fig2<-ggplot(d,aes(x=biofuels, y=oxidative))+ geom_point (size = 5, col = "blue")
fig2

# can do this with lines too
fig3<-ggplot(d,aes(x=biofuels, y=oxidative))+ geom_line ()
fig3

# let's use a higher size and different colour
# points and lines
fig4<-ggplot(d,aes(x=biofuels, y=oxidative))+ geom_point (size = 5, col = "blue")+ geom_line()
fig4

# we can use polygons, too
fig5<-ggplot(d,aes(x=biofuels, y=oxidative))+ geom_polygon ()
fig5

# time to import data
# tell R where to draw datasets from
# set working directory
setwd("C:/Users/kyras/Documents/First Term/Monitoring Ecosystems/Lab/")

# call the data
covid<-read.csv("covid_agg.csv", header=TRUE)
covid


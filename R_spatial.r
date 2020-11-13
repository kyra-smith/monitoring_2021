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

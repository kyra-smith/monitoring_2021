#always include comments - he will check this on the exam
#We are going to make measurements of primate abundance at different sites
#put a 'c' before the array of data, label it 'primates'
primates<-c(3, 5, 9, 15, 40) 
primates
#new set
crabs<-c(100, 70, 30, 10, 5)
crabs
#first plot in R
plot(primates, crabs)
#changing the colour of the points
plot(primates,crabs,col="red")
#change shape of points (pch = "point character") to filled diamond
plot(primates,crabs,col="red", pch=18)
#character exaggeration (changing the size of the points); doubling the size, so we use "2"
plot(primates,crabs,col="red", pch=18, cex = 2)
#add graph title
plot(primates,crabs,col="red", pch=18, cex = 2, main = "Battle of the Orders")
#make a table about the data (a dataframe)
#first column we want is the primates
ecoset<-data.frame (primates, crabs)
ecoset
#Ask "What is the mean number of crabs and the mean number of primates?"
mean(primates)
mean(crabs)
#get a summary of the data
summary(ecoset)

##Generate Heatmap for Yelp Review
library(ggmap)
library(ggplot2)
library(hexbin)
library (reshape2)

setwd("\\\\engin-labs.m.storage.umich.edu/xutao/windat.v2/Desktop/ioe568")
map <- get_map(location=c(lon=-79.976389, lat=40.439722), zoom=12, maptype='roadmap', color='bw')
ldata <- read.csv('pitt.csv')#file.choose())
positions <- data.frame(lon=ldata[,2], lat=ldata[,3], star=ldata[,4])


positions$star_cuts <- cut(positions$star, breaks=c(0.5,1,1.5,2,2.5,3,3.5,4,4.5,5))
positions$star <- as.factor(positions$star)
ggmap(map) + geom_point(data=positions, size=4, aes(colour=star_cuts), alpha=0.7) +
ggtitle('Pittsburgh Restaurants and Ratings')+
#scale_colour_manual(values=c("#1A9338","#328535","#4A7732","#62692F","#7A5B2C","#924D29","#AA3F26","#C23123","#FFFD52","#F3161E"),labels=c("1","1.5","2","2.5","3","3.5","4","4.5","5","5.5"),name="Star\nRating")
#scale_colour_manual(values=c("#05014C","#200343","#3B063B","#560932","#710C2A","#8D0F21","#A81219","#C31510","#DE1808","#FA1B00"),labels=c("1 Star","1.5 Star","2 Star","2.5 Star","3 Star","3.5 Star","4 Star","4.5 Star","5 Star","5.5 Star"),name="Star Rating")
scale_colour_manual(values=c("#D60A23","#B0282A","#8B4631","#656438","#40823F","#1BA147","#177C74","#1358A2","#0F34D0","#0B10FE"),labels=c("1","1.5","2","2.5","3","3.5","4","4.5","5","5.5"),name="Star\nRating")

.libPaths(new=c("R/library", .libPaths()))

rm(list=ls())

args = (commandArgs(trailingOnly=TRUE))
if(length(args) == 1){
  dataname = args[1]
} else {
  cat('usage: Rscript Proj1.R <data name>\n', file=stderr())
  stop()
}


library(tsfknn) 

stock=read.csv(dataname)

#data cleaning and processing
#choosing opening stock price records everyday
stock=stock[,c(1,5)] #take date and opening
#two line restrict time to date, dont modify it!
ndata=10
stock$date=substr(stock$date,1,ndata)
# take first unique date row out
index=!duplicated(stock$date)
newstock=stock[index,]
##########################modified from here 
#prepare dataset, all days for forecast, except 20 days for testing
stklength=dim(newstock)[1]
partstock=newstock[1:(stklength-20),]
testpoint=newstock[(stklength-19):(stklength),]$open

#forcast 40 days, with 20 days testing and 20 days showing real forecast
#train data from 2022-04-01 to 2022-09-23
knn1 <- knn_forecasting(partstock$open, h=40, k = 5, lags = 1:30)
# save plot to png
job=dataname  #job here is job or stock name shown in plot main and png name
pngname=paste(job,".png",sep="")#add the job name in the first paste input, here is .
mainname=paste('knn ts Prediction of ',job,sep="")
png(file=pngname,width = 960,height=600)
plot(knn1)
points((stklength-19):(stklength),testpoint,col='blue',pch=20)
legend('topleft',legend = c("prediction","training","testing"),col = c('red','black','blue'),pch=20)
title(main=mainname,ylab="stock price")
dev.off()

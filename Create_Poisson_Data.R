library(pracma)
library(plotly)


#const
setwd("~/Desktop/ba")
dimension = 3
numbers_of_elements = 100000

#init data frames
mydataframe <- data.frame(matrix(0,nrow= numbers_of_elements,ncol = dimension))
size_of_dim <- ceiling(nthroot(numbers_of_elements,dimension))

#add values
for (i in 1:dimension){
  mydataframe[,i] <- runif(numbers_of_elements,0,1)
}
mydataframe <- data.frame(mydataframe)


## Write into TXT
write.table(list(numbers_of_elements, dimension),file = "data.txt",append=FALSE,row.names = FALSE,col.names = FALSE,sep = ",")
write.table(mydataframe,file = "data.txt",append = TRUE,row.names = FALSE,col.names = FALSE,sep = ",")



library(pracma)
library(plotly)
packageVersion('plotly')


#const
setwd("~/Desktop/ba")
dimension = 3
numbers_of_elements = 50

#init data frames
mydataframe <- data.frame(matrix(0,nrow= numbers_of_elements,ncol = dimension))
size_of_dim <- ceiling(nthroot(numbers_of_elements,dimension))

#add values
for (i in 1:3){
  mydataframe[,i] <- sample(1:size_of_dim,size=50,replace=TRUE)
}

# remove unique 
while( nrow(unique(mydataframe)) != numbers_of_elements){
  mydataframe <- unique(mydataframe)
  mydataframe2 <- data.frame(matrix(0,nrow= (numbers_of_elements-nrow(mydataframe)),ncol = dimension))
  for (i in 1:3){
    mydataframe2[,i] <- sample(1:size_of_dim,size=(numbers_of_elements-nrow(mydataframe)),replace=TRUE)
  }
  mydataframe2
  mydataframe <- rbind(mydataframe,mydataframe2)
} 


#plot
mydataframe <- data.frame(mydataframe)
p <- plot_ly(mydataframe, x = mydataframe$X1  , y = mydataframe$X2 , z = mydataframe$X3) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'X1'),
                      yaxis = list(title = 'X2'),
                      zaxis = list(title = 'X3')))
p

## Write into TXT
write.table(list(numbers_of_elements, dimension),file = "data.txt",append=FALSE,row.names = FALSE,col.names = FALSE,sep = ",")
write.table(mydataframe,file = "data.txt",append = TRUE,row.names = FALSE,col.names = FALSE,sep = ",")



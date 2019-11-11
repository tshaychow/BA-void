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
  mydataframe[,i] <- runif(numbers_of_elements,0,1)
}

#plot
mydataframe <- data.frame(mydataframe)
p <- plot_ly(mydataframe, x = mydataframe$X1  , y = mydataframe$X2 , z = mydataframe$X3) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'X',nticks = 20,range=c(0,1)),
                      yaxis = list(title = 'Y',nticks = 20,range=c(0,1)),
                      zaxis = list(title = 'Z',nticks = 20,range=c(0,1)),
                      aspectmode='cube'))
p

## Write into TXT
write.table(list(numbers_of_elements, dimension),file = "data.txt",append=FALSE,row.names = FALSE,col.names = FALSE,sep = ",")
write.table(mydataframe,file = "data.txt",append = TRUE,row.names = FALSE,col.names = FALSE,sep = ",")



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
head(mydataframe)

#add values
for (i in 1:3){
  mydataframe[,i] <- sample(1:size_of_dim,size=50,replace=TRUE)
}
head(mydataframe)

#plot
mydataframe <- data.frame(mydataframe)
p <- plot_ly(mtcars, x = mydataframe$X1  , y = mydataframe$X2 , z = mydataframe$X3) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'X1'),
                      yaxis = list(title = 'X2'),
                      zaxis = list(title = 'X3')))
p

## Write into TXT
write.table(list(numbers_of_elements, dimension),file = "data.txt",append=FALSE,row.names = FALSE,col.names = FALSE)
write.table(mydataframe,file = "data.txt",append = TRUE,row.names = FALSE,col.names = FALSE)



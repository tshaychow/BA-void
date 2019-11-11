x <- dataframe[void_index,]$V1
y <- dataframe[void_index,]$V2
z <- dataframe[void_index,]$V3

x_d <- dataframe[data_index,]$V1
y_d <- dataframe[data_index,]$V2
z_d <- dataframe[data_index,]$V3

p <-  plot_ly(x = ~x_d, y = ~y_d, z = ~z_d,type = "scatter3d") %>%
  add_trace(x = ~x, y = ~y, z = ~z,type = "mesh3d")  %>%
  layout(scene = list(xaxis = list(title = 'X',nticks = 20,range=c(0,1)),
                      yaxis = list(title = 'Y',nticks = 20,range=c(0,1)),
                      zaxis = list(title = 'Z',nticks = 20,range=c(0,1)),
                      aspectmode='cube'))
p
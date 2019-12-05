p <- plot_ly(dataframe, x = dataframe$V1  , y = dataframe$V2 , z = dataframe$V3,text = 1:nrow(dataframe)) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'X',nticks = 20,range=c(0,1)),
                      yaxis = list(title = 'Y',nticks = 20,range=c(0,1)),
                      zaxis = list(title = 'Z',nticks = 20,range=c(0,1)),
                      aspectmode='cube'))
p


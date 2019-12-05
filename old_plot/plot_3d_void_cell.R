x_v <- dataframe[void_index,]$V1
y_v <- dataframe[void_index,]$V2
z_v <- dataframe[void_index,]$V3

x_d <- dataframe[data_index,]$V1
y_d <- dataframe[data_index,]$V2
z_d <- dataframe[data_index,]$V3



p <- plot_ly(type = "scatter3d",mode = 'markers') %>%
  add_markers(x = x_d,
              y = y_d,
              z = z_d,
              text = data_index,
              size = 1,
              marker = list(color = 'rgb(0, 0, 0)',size = 5)) %>% 
  add_markers(x = x_v,
              y = y_v,
              z = z_v,
              text = void_index,
              marker = list(size = kNN_mean_distance[void_index]*250,
                            color = group_frame[void_index], 
                            opacity = 0.99,
                            colorscale = 'Rainbow', 
                            showscale = TRUE),
              showlegend = FALSE) %>%
  layout(scene = list(xaxis = list(title = 'X',nticks = 20,range=c(0,1)),
                      yaxis = list(title = 'Y',nticks = 20,range=c(0,1)),
                      zaxis = list(title = 'Z',nticks = 20,range=c(0,1)),
                      aspectmode='cube'))
p

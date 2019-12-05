void_index <- which(group_frame %in% void_cells)
data_index <- which(group_frame %in% data_cells)

x_v <- subvoid_frame[,1]
y_v <- subvoid_frame[,2]
z_v <- subvoid_frame[,3]

x_d <- dataframe[data_index,]$V1
y_d <- dataframe[data_index,]$V2
z_d <- dataframe[data_index,]$V3


p <- plot_ly(type = "scatter3d",mode = 'markers') %>%
  add_markers(subvoid_frame,
              x = x_d,
              y = y_d,
              z = z_d,
              text = data_index,
              size = 1,
              marker = list(color = 'rgb(0, 0, 0)',size = 5)) %>% 
  add_markers(dataframe[data_index,],
              x = x_v,
              y = y_v,
              z = z_v,
              text = void_cells,
              marker = list(size = kNN_mean_distance[void_cells]*550,
                            color = c(1:length(x_v)), 
                            opacity = 0.99,
                            colorscale = 'Rainbow', 
                            showscale = TRUE),
              showlegend = FALSE) %>%
  layout(scene = list(xaxis = list(title = 'X',nticks = 20,range=c(0,1)),
                      yaxis = list(title = 'Y',nticks = 20,range=c(0,1)),
                      zaxis = list(title = 'Z',nticks = 20,range=c(0,1)),
                      aspectmode='cube'))
p

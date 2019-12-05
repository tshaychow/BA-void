x_v <- subvoid_frame[,1]
y_v <- subvoid_frame[,2]
z_v <- subvoid_frame[,3]


start_slice <- 0.38
end_slice <- 0.44
## V2 is the Y axis
slice_dataframe <- dataframe[which(dataframe$V2 > start_slice & dataframe$V2 < end_slice),]


x_d <- slice_dataframe$V1
y_d <- slice_dataframe$V2
z_d <- slice_dataframe$V3




p <- plot_ly(type = "scatter3d",mode = 'markers') %>%
  add_markers(x = x_d,
              y = y_d,
              z = z_d,
              text = row.names(slice_dataframe),
              size = 1,
              marker = list(color = 'rgb(0, 0, 0)',size = 5)) %>% 
  add_markers(x = x_v,
              y = y_v,
              z = z_v,
              text = void_cells,
              marker = list(size = kNN_mean_distance[void_cells]*500,
                            color = c(1:length(x_v)), 
                            opacity = 0.99,
                            colorscale = 'Rainbow', 
                            showscale = TRUE),
              showlegend = FALSE) %>%
  layout(scene = list(xaxis = list(title = 'X',range=c(0,1)),
                      ## defined Y as sliced part
                      yaxis = list(title = 'Y',range=c(start_slice,end_slice)),
                      zaxis = list(title = 'Z',range=c(0,1))))
p

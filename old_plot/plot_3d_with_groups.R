x <- dataframe$V1
y <- dataframe$V2
z <- dataframe$V3

p <- plot_ly(type = "scatter3d",mode = 'markers') %>%
  add_markers(x = x,
              y = y,
              z = z,
              text = seq(1:header[1]),
              marker = list(color = 'rgb(0,0,0)',
                            size = 5),
              showlegend = FALSE) %>% 
  add_markers(x = x,
              y = y,
              z = z,
              text = seq(1:header[1]),
              marker = list(size = kNN_mean_distance*250,
                            color = group_frame, 
                            opacity = 0.99,
                            colorscale = 'Rainbow', 
                            showscale = TRUE),
              showlegend = FALSE)%>%
  layout(scene = list(xaxis = list(title = 'X',nticks = 20,range=c(0,1)),
                      yaxis = list(title = 'Y',nticks = 20,range=c(0,1)),
                      zaxis = list(title = 'Z',nticks = 20,range=c(0,1)),
                      aspectmode='cube'))
p
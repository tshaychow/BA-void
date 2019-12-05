p1 <- plot_ly(z = mean_data_cell_frame[1,,], type = "heatmap")

p2<- plot_ly(z = mean_data_cell_frame[2,,], type = "heatmap")

p3 <- plot_ly(z = mean_data_cell_frame[3,,], type = "heatmap")

p4 <- plot_ly(z = mean_data_cell_frame[4,,], type = "heatmap")

p <- subplot(p1,p2,p3,p4)
p
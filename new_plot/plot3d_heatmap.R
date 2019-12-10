p1 <- plot_ly(z = data_cell_frame[1,,], colors = "Greys",type = "heatmap")
p2 <- plot_ly(z = data_cell_frame[2,,], colors = "Greys", type = "heatmap")
p3 <- plot_ly(z = data_cell_frame[3,,], colors = "Greys", type = "heatmap")
p4 <- plot_ly(z = data_cell_frame[4,,], colors = "Greys", type = "heatmap")



# p5 <- plot_ly(z = data_cell_frame[5,,], type = "heatmap")
# p6 <- plot_ly(z = data_cell_frame[6,,], type = "heatmap")
# p7 <- plot_ly(z = data_cell_frame[7,,], type = "heatmap")
# p8 <- plot_ly(z = data_cell_frame[8,,], type = "heatmap")
# p9 <- plot_ly(z = data_cell_frame[9,,], type = "heatmap")
# p10<- plot_ly(z = data_cell_frame[10,,], type = "heatmap")


p <- subplot(p1,p2,p3,p4,nrows = 4)
p
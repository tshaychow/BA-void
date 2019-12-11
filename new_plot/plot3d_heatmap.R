p1 <- plot_ly(z = flipud(data_cell_frame[,,1]), colors = "Greys",type = "heatmap")
p2 <- plot_ly(z = flipud(data_cell_frame[,,2]), colors = "Greys", type = "heatmap")
p3 <- plot_ly(z = flipud(data_cell_frame[,,3]), colors = "Greys", type = "heatmap")
p4 <- plot_ly(z = flipud(data_cell_frame[,,4]), colors = "Greys", type = "heatmap")
p5 <- plot_ly(z = flipud(data_cell_frame[,,5]), colors = "Greys", type = "heatmap")
p6 <- plot_ly(z = flipud(data_cell_frame[,,6]), colors = "Greys", type = "heatmap")
p7 <- plot_ly(z = flipud(data_cell_frame[,,7]), colors = "Greys", type = "heatmap")
p8 <- plot_ly(z = flipud(data_cell_frame[,,8]), colors = "Greys", type = "heatmap")
p9 <- plot_ly(z = flipud(data_cell_frame[,,9]), colors = "Greys", type = "heatmap")
p10<- plot_ly(z = flipud(data_cell_frame[,,10]), colors = "Greys", type = "heatmap")


p <- subplot(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,nrows = 5)
p


remove("p1","p2","p3","p4","p5","p6","p7","p8","p9","p10","p")

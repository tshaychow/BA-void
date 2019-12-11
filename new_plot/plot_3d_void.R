
tmp_data_frame <- data_cell_frame

for (index in 1:length(tmp_data_frame)){
  if(index %in% void_index){
    tmp_data_frame[index] <-1
  } else {
    #normal data marked as 0
    tmp_data_frame[index] <- 0
  }
  
}


tmp_data_frame

p1 <- plot_ly(z = flipud(tmp_data_frame[,,1]), colors = "Greys", type = "heatmap")
p2 <- plot_ly(z = flipud(tmp_data_frame[,,2]), colors = "Greys", type = "heatmap")
p3 <- plot_ly(z = flipud(tmp_data_frame[,,3]), colors = "Greys", type = "heatmap")
p4 <- plot_ly(z = flipud(tmp_data_frame[,,4]), colors = "Greys", type = "heatmap")
p5 <- plot_ly(z = flipud(tmp_data_frame[,,5]), colors = "Greys", type = "heatmap")
p6 <- plot_ly(z = flipud(tmp_data_frame[,,6]), colors = "Greys", type = "heatmap")
p7 <- plot_ly(z = flipud(tmp_data_frame[,,7]), colors = "Greys", type = "heatmap")
p8 <- plot_ly(z = flipud(tmp_data_frame[,,8]), colors = "Greys", type = "heatmap")
p9 <- plot_ly(z = flipud(tmp_data_frame[,,9]), colors = "Greys", type = "heatmap")
p10<- plot_ly(z = flipud(tmp_data_frame[,,10]), colors = "Greys", type = "heatmap")

w1 <- plot_ly(z = flipud(data_cell_frame[,,1]), colors = "Greys",type = "heatmap")
w2 <- plot_ly(z = flipud(data_cell_frame[,,2]), colors = "Greys", type = "heatmap")
w3 <- plot_ly(z = flipud(data_cell_frame[,,3]), colors = "Greys", type = "heatmap")
w4 <- plot_ly(z = flipud(data_cell_frame[,,4]), colors = "Greys", type = "heatmap")
w5 <- plot_ly(z = flipud(data_cell_frame[,,5]), colors = "Greys", type = "heatmap")
w6 <- plot_ly(z = flipud(data_cell_frame[,,6]), colors = "Greys", type = "heatmap")
w7 <- plot_ly(z = flipud(data_cell_frame[,,7]), colors = "Greys", type = "heatmap")
w8 <- plot_ly(z = flipud(data_cell_frame[,,8]), colors = "Greys", type = "heatmap")
w9 <- plot_ly(z = flipud(data_cell_frame[,,9]), colors = "Greys", type = "heatmap")
w10<- plot_ly(z = flipud(data_cell_frame[,,10]), colors = "Greys", type = "heatmap")




p <- subplot(p1,w1,p2,w2,p3,w3,p4,w4,p5,w5,p6,w6,p7,w7,p8,w8,p9,w9,p10,w10,nrows = 5)
p



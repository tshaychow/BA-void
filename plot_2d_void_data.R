
tmp_data_frame <- data_cell_frame

for (index in 1:length(tmp_data_frame)){
  if(index %in% void_index){
    tmp_data_frame[index] <-0
  } else {
    #normal data marked as 0
    tmp_data_frame[index] <- 1
  }
  
}

tmp_data_frame

p1 <- plot_ly(z = tmp_data_frame, colors = "Greys", type = "heatmap")

w1 <- plot_ly(z = data_cell_frame, colors = "Greys",type = "heatmap")




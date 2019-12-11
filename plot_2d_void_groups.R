
tmp_data_frame <- data_cell_frame
groups <- unique(group_frame)
group_colour <- 1:length(groups)

for (index in 1:length(tmp_data_frame)){
  c_index <- which ( groups %in% group_frame[index] )
  tmp_data_frame[index] <- group_colour[c_index]
}


tmp_data_frame <- matrix(tmp_data_frame,nrow = 10)

p2 <- plot_ly(z = tmp_data_frame,colors = colorRamp(c("white", "blue")), type = "heatmap")
w2 <- plot_ly(z = data_cell_frame,type = "heatmap")





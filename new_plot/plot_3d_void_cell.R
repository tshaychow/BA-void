void_index <- which(group_frame %in% void_cells)
data_index <- which(group_frame %in% data_cells)

tmp_data_frame <- mean_data_cell_frame

for (index in 1:length(tmp_data_frame)){
  if(index %in% data_index){
    # change to length(group_frame)/2 for even colors
    tmp_data_frame[index] <- 0
  }else{
    tmp_data_frame[index] <- group_frame[index]
  }
  
}


tmp_data_frame



p1 <- plot_ly(z = flipud(tmp_data_frame[,,1]), type = "heatmap",colors = "Greys",zauto = FALSE, zmin = 0, zmax = length(group_frame))
p2 <- plot_ly(z = flipud(tmp_data_frame[,,2]), type = "heatmap",colors = "Greys",zauto = FALSE, zmin = 0, zmax = length(group_frame))
p3 <- plot_ly(z = flipud(tmp_data_frame[,,3]), type = "heatmap",colors = "Greys",zmin = 0,zmax = length(group_frame), zauto=FALSE)
p4 <- plot_ly(z = flipud(tmp_data_frame[,,4]), type = "heatmap",colors = "Greys",zmin = 0,zmax = length(group_frame), zauto=FALSE)


# p5 <- plot_ly(z = tmp_data_frame[5,,], type = "heatmap")
# p6 <- plot_ly(z = tmp_data_frame[6,,], type = "heatmap")
# p7 <- plot_ly(z = tmp_data_frame[7,,], type = "heatmap")
# p8 <- plot_ly(z = tmp_data_frame[8,,], type = "heatmap")
# p9 <- plot_ly(z = tmp_data_frame[9,,], type = "heatmap")
# p10<- plot_ly(z = tmp_data_frame[10,,], type = "heatmap")


p <- subplot(p1,p2,p3,p4,nrows = 4,shareX = TRUE)
p
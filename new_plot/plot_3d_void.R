void_index <- which(group_frame %in% void_cells)
data_index <- which(group_frame %in% data_cells)

tmp_data_frame <- mean_data_cell_frame

for (index in 1:length(tmp_data_frame)){
  if(group_frame[index] %in% void_index){
    tmp_data_frame[index] <-group_frame[index] 
  } else {
    #normal data marked as 0
    tmp_data_frame[index] <- 0
  }
  
}


tmp_data_frame



p1 <- plot_ly(z = flipud(tmp_data_frame[,,1]), type = "heatmap",zauto = FALSE, zmin = 0, zmax = length(group_frame))
p2 <- plot_ly(z = flipud(tmp_data_frame[,,2]), type = "heatmap", zauto = FALSE, zmin = 0, zmax = length(group_frame))
p3 <- plot_ly(z = flipud(tmp_data_frame[,,3]), type = "heatmap", zmin = 0,zmax = length(group_frame), zauto=FALSE)
p4 <- plot_ly(z = flipud(tmp_data_frame[,,4]), type = "heatmap", zmin = 0,zmax = length(group_frame), zauto=FALSE)

p5 <- plot_ly(z = flipud(tmp_data_frame[,,5]), type = "heatmap", zauto = FALSE, zmin = 0, zmax = length(group_frame))
p6 <- plot_ly(z = flipud(tmp_data_frame[,,6]), type = "heatmap", zauto = FALSE, zmin = 0, zmax = length(group_frame))
p7 <- plot_ly(z = flipud(tmp_data_frame[,,7]), type = "heatmap", zmin = 0,zmax = length(group_frame), zauto=FALSE)
p8 <- plot_ly(z = flipud(tmp_data_frame[,,8]), type = "heatmap", zmin = 0,zmax = length(group_frame), zauto=FALSE)

p9 <- plot_ly(z = flipud(tmp_data_frame[,,9]), type = "heatmap", zauto = FALSE, zmin = 0, zmax = length(group_frame))
p10<- plot_ly(z = flipud(tmp_data_frame[,,10]), type = "heatmap", zauto = FALSE, zmin = 0, zmax = length(group_frame))




p <- subplot(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,nrows = 5,shareX = TRUE)
p
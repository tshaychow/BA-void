tmp_data_frame <- mean_data_cell_frame

for (index in 1:length(tmp_data_frame)){
  tmp_data_frame[index] <- group_frame[index]
}

tmp_data_frame

p1 <- plot_ly(z = tmp_data_frame[1,,],type = "heatmap")
p2 <- plot_ly(z = tmp_data_frame[2,,], type = "heatmap")
p3 <- plot_ly(z = tmp_data_frame[3,,], type = "heatmap")
p4 <- plot_ly(z = tmp_data_frame[4,,], type = "heatmap")


# p5 <- plot_ly(z = tmp_data_frame[5,,], type = "heatmap")
# p6 <- plot_ly(z = tmp_data_frame[6,,], type = "heatmap")
# p7 <- plot_ly(z = tmp_data_frame[7,,], type = "heatmap")
# p8 <- plot_ly(z = tmp_data_frame[8,,], type = "heatmap")
# p9 <- plot_ly(z = tmp_data_frame[9,,], type = "heatmap")
# p10<- plot_ly(z = tmp_data_frame[10,,], type = "heatmap")


p <- subplot(p1,p2,p3,p4,nrows = 4)
p
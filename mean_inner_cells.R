## get surounding indices
mean_data_cell_frame <- data_cell_frame

# define a function to get all neighbours of inner indices
inner_neighbour <- function(position) {
  tmp <- position
  # first calculate inner indices
  for (dimension_index in 0:(dimension-1) ){
    # get left and right neighbours
    next_dim_shift <- cells_per_line^dimension_index
    tmp <- list(tmp-next_dim_shift, tmp, tmp+next_dim_shift)
    tmp <- unlist(tmp)
    
  }
  return(tmp)
}

for (index in 1:length(inner_indices)){
  tmp_index <- inner_indices[index]
  tmp_mean <- data_cell_frame[inner_neighbour(tmp_index)]
  mean_data_cell_frame[tmp_index]<- (mean(tmp_mean))
}


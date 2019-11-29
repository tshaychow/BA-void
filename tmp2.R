for (index in 1:length(inner_indices)){
  tmp_index <- inner_indices[index]
  tmp_mean <- data_cell_frame[inner_neighbour(tmp_index)]
  mean_data_cell_frame[tmp_index]<- (mean(tmp_mean))
}


## get surounding indices
mean_data_cell_frame <- data_cell_frame

# define a function to get all neighbours of inner indices
inner_neighbour <- function(position) {
  tmp <- position
  # first calculate inner indices
  for (dimension_index in 0:(dimension-1) ){
    
    last_list <- tmp
    # get left and right
    next_dim_shift <- cells_per_line^dimension_index
    tmp <- list(tmp-next_dim_shift, tmp+next_dim_shift)
    tmp <- unlist(tmp)
    
    # check wether new values are still in the frame realm
    
    # use base as an indicator of which line number has to be
    base <- floor((tmp-1)/cells_per_line^dimension_index)
    tmp[which(base!= 1)] <- cells_per_line^(dimension_index+1) + tmp[which(base!= 1)]
    tmp <- list(tmp,last_list)
    tmp <- unlist(tmp)
    cat(tmp)
    cat("\n")
    
  }
  return(tmp)
}

#-------------------------------------------------------
## get surounding indices
mean_data_cell_frame <- data_cell_frame

# define a function to get all neighbours of inner indices
inner_neighbour <- function(position) {
  tmp <- position
  # first calculate inner indices
  for (dimension_index in 0:(dimension-1) ){
    
    last_list <- tmp
    # get left and right
    next_dim_shift <- cells_per_line^dimension_index
    tmp <- list(tmp-next_dim_shift, tmp+next_dim_shift)
    tmp <- unlist(tmp)
    
    # check wether new values are still in the frame realm
    
    # use base as an indicator of which line number has to be
    if (dimension_index == 0){
      # transformation from first to second dimension special case
      base <- floor((tmp-1)/ (cells_per_line))
    }else{
      base <- floor((tmp-1)/ (cells_per_line^dimension_index))
    }
    # update values leftto realm
    tmp[which(base < floor(last_list/cells_per_line))] <- cells_per_line^(dimension_index+1) + tmp[which(base < floor(last_list/cells_per_line))]
    #update values right to realm
    tmp[which(base > floor(last_list/cells_per_line))] <- cells_per_line^(dimension_index+1) - tmp[which(base > floor(last_list/cells_per_line))]
    
    tmp <- list(tmp,last_list)
    tmp <- unlist(tmp)
    cat(tmp)
    cat("\n")
    
  }
  return(tmp)
}







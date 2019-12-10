# define a function to get all neighbours of inner indices
neighbours <- function(position) {
  next_neighbours <- position
  # first calculate inner indices
  for (dimension_index in 1:dimension ){
    
    # tmp save current list
    last_list <- next_neighbours
    last_list_tier <- floor((last_list-1)/const_cells_per_line^dimension_index) 
    
    # get left and right position
    next_dim_shift <- const_cells_per_line^(dimension_index-1)
    next_neighbours <- list(next_neighbours-next_dim_shift, next_neighbours+next_dim_shift)
    next_neighbours <- unlist(next_neighbours)
    
    #look which case we have by checking base and tier values
    next_neighbours_tier <- floor((next_neighbours-1)/const_cells_per_line^dimension_index) 
    
    tmp_length <- length(last_list)
    
    for (index in 1:tmp_length){
      actual_tier <- last_list_tier[index]
      
      tmp_tier <- c(next_neighbours_tier[index],next_neighbours_tier[index+tmp_length])
      
      
      # 1. case left is out of frame realm
      if(tmp_tier[1] < actual_tier){
        #calculate new position value 
        tmp <- const_cells_per_line^(dimension_index) + next_neighbours[index]
        next_neighbours[index] <- tmp
      }
      # 2. case left is out of frame realm
      if(tmp_tier[2] > actual_tier){
        #calculate new position value
        
        # wrapping
        if(const_filtermode == 1){
          tmp <- next_neighbours[index+tmp_length] - const_cells_per_line^(dimension_index) 
          # copy edge
        }else if(const_filtermode == 2){
          tmp <-last_list[index]
        }
        next_neighbours[index+tmp_length] <- tmp
      }
    }
    next_neighbours <- list(next_neighbours,last_list)
    next_neighbours <- unlist(next_neighbours)
  }
  return(next_neighbours)
}

tmp <- foreach(index = 1:length(data_cell_frame)) %dopar% {
  output <- mean(data_cell_frame[neighbours(index)])
}

data_cell_frame <- array(unlist(tmp),dim = rep(const_cells_per_line,dimension))


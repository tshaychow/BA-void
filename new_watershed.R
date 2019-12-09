

# define a function to get all neighbours
neighbours <- function(position) {
  next_neighbours <- position
  # first calculate inner indices
  for (dimension_index in 1:dimension ){
    
    # tmp save current list
    last_list <- next_neighbours
    last_list_tier <- floor((last_list-1)/cells_per_line^dimension_index) 
    
    # get left and right position
    next_dim_shift <- cells_per_line^(dimension_index-1)
    next_neighbours <- list(next_neighbours-next_dim_shift, next_neighbours+next_dim_shift)
    next_neighbours <- unlist(next_neighbours)
    
    #look which case we have by checking base and tier values
    next_neighbours_tier <- floor((next_neighbours-1)/cells_per_line^dimension_index) 
    
    tmp_length <- length(last_list)
    
    for (index in 1:tmp_length){
      actual_tier <- last_list_tier[index]
      
      tmp_tier <- c(next_neighbours_tier[index],next_neighbours_tier[index+tmp_length])
      
      # 1. case left is out of frame realm
      if(tmp_tier[1] < actual_tier){
        #calculate new position value 
        tmp <- last_list[index]
        next_neighbours[index] <- tmp
      }
      # 2. case left is out of frame realm
      if(tmp_tier[2] > actual_tier){
        #calculate new position value
        tmp <-last_list[index]
        next_neighbours[index+tmp_length] <- tmp
      }
    }
    next_neighbours <- list(next_neighbours,last_list)
    next_neighbours <- unlist(next_neighbours)
  }
  next_neighbours <- unique(next_neighbours)
  next_neighbours <- unlist(next_neighbours)
  return(next_neighbours)
}




group_frame <- c(seq(1:length(mean_data_cell_frame)))
number_of_groups <- length(unique(group_frame))

repeat{
  
  for (current_i in 1:length(mean_data_cell_frame)){
    current_node <- group_frame[current_i]
    
    # find current_nodes next possible greater radius node
    current_density <- mean_data_cell_frame[current_node]
    current_neighbours <- neighbours(current_node)
    neighbour_density <- mean_data_cell_frame[current_neighbours] 
    
    # check whether lowest denisty neighbor is lower than the point itself
    if (current_density < max(mean_data_cell_frame) ) {
      # update belonging list
      max_index <- which(neighbour_density %in% max(neighbour_density))
      next_node <- current_neighbours[max_index]
      group_frame[current_i] <- next_node[1]
    }else{
      next_node <- current_node
    }
    

    cat("index: ",current_i,"current node: ",current_node, mean_data_cell_frame[current_node], " ",next_node,mean_data_cell_frame[next_node]
        ," | note: ", group_frame[current_i] ,"\n")
  }
  cat("\n")
  
  # If no new groups can be formed, we will break out of the loop
  tmp_groups <- number_of_groups
  number_of_groups <- length(unique(group_frame))
  
  if(number_of_groups ==  tmp_groups){
    break
  }
}
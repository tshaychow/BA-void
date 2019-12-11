
group_frame <- c(seq(1:length(data_cell_frame[,,1])))
number_of_groups <- length(unique(group_frame))
dimension <- 2

repeat{
  for (current_i in 1:100){
    current_node <- group_frame[current_i]
    
    # find current_nodes next possible greater radius node
    current_density <- data_cell_frame[current_node]
    current_neighbours <- neighbours(current_node)
    current_neighbours <- unique(current_neighbours)
    current_neighbours <- unlist(current_neighbours)
    neighbour_density <- data_cell_frame[current_neighbours] 
    
    # check whether lowest denisty neighbor is lower than the point itself
    if (current_density < max(neighbour_density) ) {
      # update belonging list
      max_index <- which(neighbour_density %in% max(neighbour_density))
      next_node <- current_neighbours[max_index]
      group_frame[current_i] <- sort(next_node)[1]
    }else{
      next_node <- current_node
    }
    
    cat("index: ",current_i,"current node: ",current_node, data_cell_frame[current_node], " ",next_node,data_cell_frame[next_node]," | note: ", group_frame[current_i] ,"\n")
  }
  cat("\n")
  
  # If no new groups can be formed, we will break out of the loop
  tmp_groups <- number_of_groups
  number_of_groups <- length(unique(group_frame))
  
  if(number_of_groups ==  tmp_groups){
    break
  }
}

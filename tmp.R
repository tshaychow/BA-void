## get surounding indices
mean_data_cell_frame <- data_cell_frame

# define a function to get all neighbours of inner indices
inner_neighbour <- function(position) {
  next_neighbours <- position
  # first calculate inner indices
  for (dimension_index in 0:(dimension-1) ){
    
    # tmp save current list
    last_list <- next_neighbours
    
    # check wether new values are still in the frame realm
    # in wrapping around we does have 4 cases
    # 1. left out of matrix realm
    # 2. right out of matrix realm
    # 3. downside out of matrix realm
    # 4. upside out of matrix realm
    
    # calculate in which tier line values should be
    tier <- floor((last_list-1)/cells_per_line) 
    
    # get left and right position
    next_dim_shift <- cells_per_line^dimension_index
    next_neighbours <- list(next_neighbours-next_dim_shift, next_neighbours+next_dim_shift)
    next_neighbours <- unlist(next_neighbours)
    
    #look which case we have by checking base and tier values
    case_number_index <- list(NULL)
    base <- floor((next_neighbours-1)/ (cells_per_line))
    for (index in 1:length(tier)){
      # length(tier) is half of length(base), there that how we get each pair
      tmp_base <- c(base[index],base[index+(length(tier))])
      # left or right? 1 == left
      
      ### case erkennung hat noch fehler
      if(as.integer(which(tmp_base!=tier[index])) == 1){
        tmp_index <- index
      }else{
        tmp_index <- index + length(tier)
      }
      case_number_index <- list(case_number_index,tmp_index)
    }
    case_number_index <- unlist(case_number_index)
    
    for (index in 1:length(tier)){
      tmp_value <- next_neighbours[case_number_index[index]]
      cmp_value <- last_list[index]
      exponent <- ceiling(cmp_value/cells_per_line) 
      # 1. case left is out of frame realm
      if(tmp_value < cmp_value){
        #calculate new position value 
        tmp <- cells_per_line^(exponent) - tmp_value
        next_neighbours[case_number_index[index]] <- tmp
        next
      }
      # 2. case left is out of frame realm
      if(tmp_value > cmp_value){
        #calculate new position value
        tmp <- cells_per_line^(exponent) + tmp_value
        next_neighbours[case_number_index[index]] <- tmp
        next
      }
      next_neighbours <- unlist(next_neighbours)
    }
    next_neighbours <- list(next_neighbours,last_list)
    next_neighbours <- unlist(next_neighbours)
  }
  return(next_neighbours)
}




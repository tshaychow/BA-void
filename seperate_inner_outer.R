## seperate indices into border and inner matrix indices-----------

inner_indicies <- 2:(cells_per_line-1)

# get border indicies---------------------------------------------

# first calculate inner indicies

inner_line <- cells_per_line -2

if (dimension != 1){
  for (exponent in 1:(dimension-1)){
    
    # get inner indicies first
    # jump from current dimension to next
    inner_indicies <- inner_indicies + cells_per_line^(exponent)
    tmp <- list(NA) 
    
    # add new dimension indicies 
    for (index in 1:inner_line){
      tmp <- list(tmp,inner_indicies+cells_per_line^(exponent)*(index-1))
    }
    tmp <- unlist(tmp)
    inner_indicies <- tmp[!is.na(tmp)]
  }
}

inner_indicies <- inner_indicies[!is.na(inner_indicies)]
inner_indicies

# second calculate outer border indicies
indicies <- c(1:(cells_per_line^dimension))
outer_indicies <- which(indicies %in% inner_indicies == FALSE) 


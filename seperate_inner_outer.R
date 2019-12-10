## Output
# inner_indices 
# outer_indices

## seperate indices into border and inner matrix indices-----------
inner_indices <- 2:(const_cells_per_line-1)

# get border indices---------------------------------------------

# first calculate inner indices

inner_line <- const_cells_per_line -2

if (dimension != 1){
  for (exponent in 1:(dimension-1)){
    
    # get inner indices first
    # jump from current dimension to next
    inner_indices <- inner_indices + const_cells_per_line^(exponent)
    tmp <- list(NA) 
    
    # add new dimension indices 
    for (index in 1:inner_line){
      tmp <- list(tmp,inner_indices+const_cells_per_line^(exponent)*(index-1))
    }
    tmp <- unlist(tmp)
    inner_indices <- tmp[!is.na(tmp)]
  }
}

inner_indices <- inner_indices[!is.na(inner_indices)]
inner_indices

# second calculate outer border indices
indices <- c(1:(const_cells_per_line^dimension))
outer_indices <- which(indices %in% inner_indices == FALSE) 


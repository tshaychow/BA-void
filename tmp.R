

## get the mean ---------------------------------------------
# 1d : 2
# 2d : 7 = 2 + 5^1
# 3d : 32 = 5^2 +7
# 4d :  = 5^3 + 32

position_index <- 2
for (exponent in 1:(dimension-1)){
  position_index <- position_index + 5^exponent
}

## get surounding indices


inner_neighbour <- function(position) {
  tmp <- position
  # first calculate inner indicies
  for (dimension_index in 0:(dimension-1) ){
      # get left and right neighbours
      next_dim_shift <- cells_per_line^dimension_index
      tmp <- list(tmp-next_dim_shift, tmp, tmp+next_dim_shift)
      tmp <- unlist(tmp)

  }
  return(tmp)
}

mean(data_cell_matrix[inner_neighbour(inner_indicies[1])])



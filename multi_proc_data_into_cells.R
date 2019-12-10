
# divide dataframe into cells
cellsize <- 1/const_cells_per_line
data_cell_frame <- array(dim = (rep(const_cells_per_line,dimension)))


# modulo that also saves left over value 
modulo <- function(position){
  a <- floor(position/const_cells_per_line)
  b <- position %% const_cells_per_line
  c(a,b)
}


test <- foreach(cell_index = 1:length(data_cell_frame),.combine = c) %dopar% {
  
  # calculate position array from position value
  # 4 -> 0 1 0

  position_counter <- array(dim = dimension)
  tmp <- cell_index-1
  for (position_index in 1:dimension){
    tmp <- modulo(tmp)
    position_counter[position_index] <- tmp[2]
    tmp <- tmp[1]
  }

  # check all dimensions of possible data points
  cell_data <- which((dataframe[1] >= (cellsize * position_counter[1]) & dataframe[1]  < cellsize*(position_counter[1]+1)) ==TRUE)
  for (dimension_index in 2:dimension){
    tmp_pc <- position_counter[dimension_index]
    tmp_df <- dataframe[dimension_index]
    # possible data points in cell
    cell_data <- intersect(cell_data,which((tmp_df >= (cellsize * tmp_pc) & tmp_df < cellsize*(tmp_pc+1))))
  }
  
  # Replace NA with 0
  if (length(cell_data) == 0){
    tmp <- 0
  }else{
    tmp <- length(cell_data)
  }
  tmp
}

data_cell_frame <- array(test,dim = rep(const_cells_per_line,dimension))


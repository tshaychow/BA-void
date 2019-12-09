registerDoParallel(detectCores())


##output
#data_cell_frame

# divide dataframe into cells
cellsize <- 1/cells_per_line
data_cell_frame <- array(dim = (rep(cells_per_line,dimension)))

# fill data_cell_frame with amount of points in each cell
cell_dimension_counter <- array(rep(0,dimension),dimension)





modulo <- function(position){
  a <- floor(position/cells_per_line)
  b <- position %% cells_per_line
  c(a,b)
}


test <- foreach(cell_index = 1:length(data_cell_frame)) %dopar% {
  cell_data <- list(NA)

  # calculate position array from position value
  position_counter <- array()
  tmp <- cell_index-1
  for (position_index in 1:dimension){
    tmp <- modulo(tmp)
    position_counter <- list(position_counter, tmp[2])
    tmp <- tmp[1]
  }
  
  position_counter <- unlist(position_counter)
  position_counter <- position_counter[which(!is.na(position_counter))]

  # check all dimensions of possible data points
  for (dimension_index in 1:dimension){
    # possible data points in cell
    cell_data <- list(cell_data,which(dataframe[dimension_index] >= cellsize * position_counter[dimension_index] & dataframe[dimension_index]  < cellsize*(position_counter[dimension_index] +1)))
    # get next coordinates
    cell_dimension_counter[dimension] <- (cell_dimension_counter[dimension] + 1) %% cells_per_line
  }
  
  # reshape list for better computation
  cell_data <- unlist(cell_data)
  # Replace NA with 0
  data_index <- strtoi(names(which(table(cell_data) == dimension)))
  if (length(data_index) == 0){
    data_index <- 0
    tmp <- 0
  }else{
    tmp <- length(data_index)
  }
  tmp
}



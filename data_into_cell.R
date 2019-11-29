##output
# data_cell_frame

# divide dataframe into cells
cellsize <- 1/cells_per_line
data_cell_frame <- array(dim = (rep(cells_per_line,dimension)))

# fill data_cell_frame with amount of points in each cell
cell_dimension_counter <- array(rep(0,dimension),dimension)
dimension_counter <- 1


position_counter <- array(rep(0,dimension),dim = dimension)

for (cell_index in 1:length(data_cell_frame)){
  cell_data <- list(NA)
  for (dimension_index in c(1:dimension)){
    
    # possible data points in cell
    cell_data <- list(cell_data,which(dataframe[dimension_index] >= cellsize* position_counter[dimension_index] & dataframe[dimension_index]  < cellsize*(position_counter[dimension_index] +1)))
    
    # getnext coordinates
    cell_dimension_counter[dimension] <- (cell_dimension_counter[dimension] + 1) %% cells_per_line
  }
  
  # get next dimension coordinates
  pos_index <- 1
  position_counter[pos_index] <- position_counter[pos_index] + 1
  
  while (position_counter[pos_index] >= cells_per_line){
    position_counter[pos_index] <- position_counter[pos_index] %% cells_per_line
    if (position_counter[pos_index] != 0) {
      break;
    }
    pos_index <- pos_index %% dimension
    pos_index <- pos_index + 1
    position_counter[pos_index] <- position_counter[pos_index] + 1
  }
  
  # reshape list for better computation
  cell_data <- unlist(cell_data)
  # search for data which are in the cells
  data_index <- strtoi(names(which(table(cell_data) == dimension)))
  # replace NA with density of each cell
  if (length(data_index) == 0){
    data_index <- 0
    data_cell_frame[cell_index] <- 0
  }else{
    data_cell_frame[cell_index] <- length(data_index)
  }
  
}



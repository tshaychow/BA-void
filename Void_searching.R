cat("\014")
setwd("~/Desktop/ba")

## functions ---------------------------------------------------------
# modulo which also saves the left-over value 

modulo <- function(position){
  a <- floor(position/const_cells_per_line)
  b <- position %% const_cells_per_line
  c(a,b)
}

neighbours <- function(position) {
  next_neighbours <- position
  # first calculate inner indices
  for (dimension_index in 1:dimension ){
    
    # tmp save current list
    neighbour_list <- next_neighbours
    neighbour_list_tier <- floor((neighbour_list-1)/const_cells_per_line^dimension_index) 
    
    # get left and right position
    dim_shift <- const_cells_per_line^(dimension_index-1)
    next_neighbours <- list(next_neighbours-dim_shift, next_neighbours+dim_shift)
    next_neighbours <- unlist(next_neighbours)
    
    #look which case we have by checking base and tier values
    next_neighbours_tier <- floor((next_neighbours-1)/const_cells_per_line^dimension_index) 
    tmp_length <- length(neighbour_list)
    
    for (index in 1:tmp_length){
      actual_tier <- neighbour_list_tier[index]
      tmp_tier <- c(next_neighbours_tier[index],next_neighbours_tier[index+tmp_length])
      
      # 1. case left is out of frame realm
      if(tmp_tier[1] < actual_tier){
        #calculate new position value 
        
        # wrapping
        if(const_filtermode == 1){
          tmp <- const_cells_per_line^(dimension_index) + next_neighbours[index]
          # copy edge
        }else if(const_filtermode == 2){
          tmp <-neighbour_list[index]
        }
        next_neighbours[index] <- tmp
      }
      # 2. case right is out of frame realm
      if(tmp_tier[2] > actual_tier){
        #calculate new position value
        
        # wrapping
        if(const_filtermode == 1){
          tmp <- next_neighbours[index+tmp_length] - const_cells_per_line^(dimension_index) 
        # copy edge
        }else if(const_filtermode == 2){
          tmp <-neighbour_list[index]
        }
        next_neighbours[index+tmp_length] <- tmp
      }
    }
    next_neighbours <- list(next_neighbours,neighbour_list)
    next_neighbours <- unlist(next_neighbours)
  }
  return(next_neighbours)
}


## Libraries---------------------------------------------------------------------

library("pracma")
library("plotly")
library("ggplot2")
library("rlist")
library("foreach")
library("parallel")
library("iterators")
library("doParallel")


#for performance analysis
library("profvis")



## Const & Parameter-------------------------------------------------------------
profvis({
# 1 : wrap around, 2: copy edge
const_filtermode <- 1
const_cells_per_line <- 30
const_bool_plot <- FALSE
const_alpha <- 0.2

# parallel processing
cl <- makeCluster(detectCores())
registerDoParallel(cl)


## Read CSV/data------------------------------------------------------------------

# 1. Read CSV----------------------------------------------
# dataframe
dataframe <- read.csv("data.txt", sep = ",",header = FALSE)

# 2. Formate dataframe by seperating header and data-------
# header
# dimension
header <- dataframe[1,][!is.na(dataframe[1,])]
dataframe <- data.frame(dataframe[2:nrow(dataframe),])
rownames(dataframe) <- seq(length = nrow(dataframe))
dimension <- header[2]
numbers_of_elements <- nrow(dataframe)

## Apply smoothening filter--------------------------------------------------------

# data_cell_frame
# modulo function, neighbour

#system.time(
#  source("multi_proc_data_into_cells.R")
#)

#system.time( 
#  source("single_proc_data_into_cells.R")
#)


# 3. divide dataframe into cells----------------------------

cellsize <- 1/const_cells_per_line
data_cell_frame <- array(dim = (rep(const_cells_per_line,dimension)))


# 4. calculate densities for each cells---------------------

cell_densities <- foreach(cell_index = 1:length(data_cell_frame),.combine = c) %dopar% {
  
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

# 5. restructure density into matrix format --------------------

data_cell_frame <- array(cell_densities,dim = rep(const_cells_per_line,dimension))


# 6. delete vars for better performance ------------------------

remove(list = c("cell_densities","modulo","cellsize","dataframe"))


# 7. apply mean filter to cells --------------------------------
#system.time(
#  source("mean_data.R")
#)

mean_data<- foreach(index = 1:length(data_cell_frame)) %dopar% {
  output <- mean(data_cell_frame[neighbours(index)])
}
data_cell_frame <- array(unlist(mean_data),dim = rep(const_cells_per_line,dimension))


# 8. stop cluster and delete vars for performance --------------

remove("mean_data")


# 10. Density group finding via "watershed/waterfilling" ----------------------------
# group_frame
#system.time(
#  source("new_watershed.R")
#)


group_frame <- c(seq(1:length(data_cell_frame)))
number_of_groups <- length(unique(group_frame))
#change filter mode to copy edge, so we just consider actual neighbours
const_filtermode <- 2

repeat{
  for (index in 1:length(data_cell_frame)){
    current_node <- unlist(group_frame[index])
    
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
      group_frame[index] <- next_node
    }else{
      next_node <- current_node
      group_frame[index] <- next_node
    }
    
    #cat("index: ",index,"current node: ",current_node, data_cell_frame[current_node], " ",next_node,data_cell_frame[next_node]," | note: ", group_frame[index] ,"\n")
  }
  #cat("\n")
  
  # If no new groups can be formed, we will break out of the loop
  tmp_groups <- number_of_groups
  number_of_groups <- length(unique(group_frame))
  
  if(number_of_groups ==  tmp_groups){
    break
  }
}

stopCluster(cl)

remove("number_of_groups","tmp_groups","next_node","neighbour_density","current_neighbours","current_density","max_index","current_node")

# 11. define what a void is----------------------------------------------------
# void_index
# data_index

# if the density in a subvoid is less then the average, subvoid will be declared as a not void

cell_frame <- unique(group_frame)
data_per_cell <- table(group_frame)
density_per_radius <-  data_cell_frame[cell_frame] / data_per_cell

# determine whether data is real data or void
# True = is real data
# False = is void

tmp_index <- density_per_radius > const_alpha * mean(density_per_radius)
void_cells <- strtoi(names(tmp_index[which(tmp_index == FALSE)]))
data_cells <- strtoi(names(tmp_index[which(tmp_index == TRUE)]))

# 12. combining voids -----------------------------------------------------
void_index <- which(group_frame %in% void_cells)
data_index <- which(group_frame %in% data_cells)


remove("tmp_index","density_per_radius","data_per_cell","cell_frame")

## plot block ----------------------------------------------------------

if (dimension == 2){
# white is void
# black is data
a1 <-source("plot_2d_void_groups.R")
a2 <-source("plot_2d_void_data.R")
p <- subplot(p1,w1,p2,w2,nrows = 2)
p
}else if(dimension == 3){
p <-source("new_plot/plot_3d_void.R")
p
}


remove("tmp_data_frame","p1","p2","p3","p4","p5","p6","p7","p8","p9","p10","p")
remove("w1","w2","w3","w4","w5","w6","w7","w8","w9","w10")
})

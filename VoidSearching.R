cat("\014")
setwd("~/Desktop/ba")

## Libraries---------------------------------------------------------------------
library(pracma)
library(FNN)
library(pracma)
library(ggplot2)
library(plotly)
library(rlist)

## Const & Parameter-------------------------------------------------------------
# 1 : wrap around, 2: copy edge, 3
filtermode <- 1
cells_per_line <- 6
bool_plot <- FALSE


## Read CSV/data------------------------------------------------------------------

# 1. Read CSV----------------------------------------------
dataframe <- read.csv("data.txt", sep = ",",header = FALSE)


# 2. Formate dataframe by seperating header and data-------
# header
# dataframe
# dimension
header <- dataframe[1,][!is.na(dataframe[1,])]
dataframe <- data.frame(dataframe[2:nrow(dataframe),])
rownames(dataframe) <- seq(length = nrow(dataframe))
dimension <- header[2]

## Apply smoothening filter--------------------------------------------------------

# 1. divide dataframe into cells----------------------------
# data_cell_frame
source("data_into_cell.R")

# 2. seperate outer and inner indices-----------------------
# inner_indices 
# outer_indices
source("seperate_inner_outer.R")

# 3. calculate mean of inner cells--------------------------
# mean_data_cell_frame
source("mean_inner_cells.R")

# 4. calculate mean of outer cells according to parameter---
if (filtermode == 1){ 
  source("mean_outer_cells_wrap.R")
}else{
  source("mean_outer_cells_copy.R")
}

## Prepare data for kNN------------------------------------------------------------
# kNN_mean_distance

# for this calculatation we use the mean of dim*2 closest neighbors as the radius of the n dimensional sphere

kNN_data <- get.knn(mean_data_cell_frame, k=dimension*2, algorithm=c("kd_tree", "cover_tree", "CR", "brute"))
kNN_neighbors <- data.frame(kNN_data[1])
kNN_distance <- data.frame(kNN_data[2])
kNN_mean_distance <- rowMeans(kNN_distance)



## Density group finding via "watershed/waterfilling" ----------------------------
# group_frame

# We go through all densities via the weightened kNN adjacency matrix
group_frame <- c(seq(1:header[1]))
number_of_groups <- length(unique(group_frame))

repeat{
  
  for (current_i in seq(1:header[1])){
    current_node <- group_frame[current_i]
    # find current_nodes next possible greater radius node
    index <- which(kNN_mean_distance[c(kNN_neighbors[current_node,],recursive = TRUE)] %in% max(kNN_mean_distance[c(kNN_neighbors[current_node,],recursive = TRUE)]))
    next_node <- kNN_neighbors[current_node,index]
    next_node_distance <- kNN_mean_distance[next_node]
    
    # check wether lowest denisty neighbor is lower than the point itself
    if (kNN_mean_distance[current_node] < kNN_mean_distance[next_node]) {
      # update belonging list
      group_frame[current_i] <- next_node
    }  
    
    cat("index: ",current_i,"current node: ",current_node, " ",kNN_mean_distance[current_node],
        " | note: ",c(kNN_neighbors[current_i,index],recursive = TRUE)," ", kNN_mean_distance[index],
        " | next: ", group_frame[current_node] ,"\n")
  }
  cat("\n")
  
  # If no new groups can be formed, we will break out of the loop
  tmp_groups <- number_of_groups
  number_of_groups <- length(unique(group_frame))
  
  if(number_of_groups ==  tmp_groups){
    break
  }
}



## define what a void is----------------------------------------------------

# if the density in a subvoid is less then the average, subvoid will be declared as a not void
cell_frame = unique(group_frame)
data_per_cell = table(group_frame)
density_per_radius = kNN_mean_distance[cell_frame] / data_per_cell

#determin wether data is real data or void
tmp_index <- density_per_radius > mean(density_per_radius)
void_cells <- strtoi(rownames(tmp_index[which(tmp_index == TRUE)]))
data_cells <- strtoi(rownames(tmp_index[which(tmp_index == FALSE)]))

void_index <- which(group_frame %in% void_cells)
data_index <- which(group_frame %in% data_cells)


## combining voids ---------------------------------------------------------

#create new dataframe which holds cell and the subvoids
datalist = list()

for (i in c(1:length(void_cells))){
  # get index of each vell with its subvoids 
  subvoid_index <- void_index[which(group_frame[void_index]  %in% void_cells[i])]
  if(length(subvoid_index) != 0){
  tmp <- dataframe[subvoid_index,]
  # use mean as new coordinate
  datalist[[i]] <- colMeans(tmp)
  }else{
    
  }
}

subvoid_frame <- do.call(rbind, datalist)




## plot block --------------------------------------------------------

if (bool_plot){
## slices ------------------------------------------------------------
#take slice from the Y axis 
p <- source("plot_3d_slice.R")
p

## 3d plot data frame with combined void -----------------------------
p <- source("plot_3d_void.R")
p

## 3d plot data frame with voids cells-------------------------------

p <- source("plot_3d_void_cell.R")
p

## 3d subvoid-group plot---------------------------------------------
p <- source("plot_3d_with_groups.R")
p

## 3d density plot---------------------------------------------------
p <- source("plot_3d_with_denisity.R")
p

## 3d data plot-------------------------------------- 
p <- source("plot_3d_all_data.R")
p
}





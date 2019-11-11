cat("\014")
setwd("~/Desktop/ba")

## Libraries-------------------------------------------

library(pracma)
library(FNN)
library(pracma)
library(ggplot2)
library(plotly)


## Read CSV/data---------------------------------------

# header = number of elements and dimension 
# dataframes = coordinates of data
dataframe <- read.csv("data.txt", sep = ",",header = FALSE)

header <- dataframe[1,][!is.na(dataframe[1,])]
dataframe <- data.frame(dataframe[2:nrow(dataframe),])
rownames(dataframe) <- seq(length = nrow(dataframe))


## Prepare data for denisty calculation with kNN--------

#for this calculatation we use the mean of dim*2 closest neighbors as the radius of the n dimensional sphere
kNN_data <- get.knn(dataframe, k=header[2]*2, algorithm=c("kd_tree", "cover_tree", "CR", "brute"))
kNN_neighbors <- data.frame(kNN_data[1])
kNN_distance <- data.frame(kNN_data[2])
kNN_mean_distance <- rowMeans(kNN_distance)


## 3d density plot-------------------------------------- 
p <- source("plot_3d_with_denisity.R")
p


## Density group finding via "watershed/waterfilling"

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
  
  # If no new groups can be formed, we will break
  tmp_groups <- number_of_groups
  number_of_groups <- length(unique(group_frame))
  
  if(number_of_groups ==  tmp_groups){
    break
  }
}

## 3d subvoid-group plot--------------------------------------
p <- source("plot_3d_with_groups.R")
p


# define what a void is---------------------------------------

# if the density in a subvoid is less then the average, subvoid will be declared as a not void

cell_frame = unique(group_frame)
data_per_cell = table(group_frame)
density_per_radius = kNN_mean_distance[cell_frame] / data_per_cell

void_index <- density_per_radius > mean(density_per_radius)
void_cells <- strtoi(rownames(void_index[which(void_index == TRUE)]))
data_cells <- strtoi(rownames(void_index[which(void_index == FALSE)]))

void_index <- which(group_frame %in% void_cells)
data_index <- which(group_frame %in% data_cells)

## 3d plot data frame with voids-------------------------------
p <- source("plot_3d_void.R")
p


# slices
# density field
# combining voids



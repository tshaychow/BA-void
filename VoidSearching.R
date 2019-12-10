cat("\014")
setwd("~/Desktop/ba")

## Libraries---------------------------------------------------------------------
library("pracma")
library("FNN")
library("pracma")
library("ggplot2")
library("plotly")
library("rlist")
library("parallel")
library("MASS")
library("foreach")
library("iterators")
library("doParallel")
library("bigstatsr")

library("profvis")



## Const & Parameter-------------------------------------------------------------
# 1 : wrap around, 2: copy edge
const_filtermode <- 1
const_cells_per_line <- 10
const_bool_plot <- FALSE
const_alpha <- 0.1

# parallel processing
cl <- makeCluster(detectCores())
registerDoParallel(cl)


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



## 3d data plot-------------------------------------- 
if(const_bool_plot == TRUE){
  p <- source("old_plot/plot_3d_all_data.R")
  p
}


## Apply smoothening filter--------------------------------------------------------

# 1. divide dataframe into cells----------------------------
# data_cell_frame

system.time(
source("multi_proc_data_into_cells.R")
)

#system.time( 
#  source("single_proc_data_into_cells.R")
#)


remove(list = c("test","modulo","cellsize","dataframe"))

# 2. calculate mean of outer cells according to parameter---
# data_cell_frame now has 
system.time(
  source("mean_data.R")
)
stopCluster(cl)
remove("tmp","neighbours")

## Density group finding via "watershed/waterfilling" ----------------------------
# group_frame

# We go through all densities via the weightened kNN adjacency matrix
system.time(
source("new_watershed.R")
)

## define what a void is----------------------------------------------------
# void_index
# data_index

# if the density in a subvoid is less then the average, subvoid will be declared as a not void
cell_frame = unique(group_frame)
data_per_cell = table(group_frame)
density_per_radius = mean_data_cell_frame[cell_frame] / data_per_cell

# determine whether data is real data or void
# True = is real data
# False = is void

tmp_index <- density_per_radius > const_alpha * mean(density_per_radius)
void_cells <- strtoi(names(tmp_index[which(tmp_index == FALSE)]))
data_cells <- strtoi(names(tmp_index[which(tmp_index == TRUE)]))

## combining voids ---------------------------------------------------------
void_index <- which(group_frame %in% void_cells)
data_index <- which(group_frame %in% data_cells)




## plot block --------------------------------------------------------

p <-source("new_plot/plot3d_heatmap.R")
p


# old plots
if (const_bool_plot == TRUE){
## slices ------------------------------------------------------------
#take slice from the Y axis 
p <- source("old_plot/plot_3d_slice.R")
p

## 3d plot data frame with combined void -----------------------------
p <- source("old_plot/plot_3d_void.R")
p

## 3d plot data frame with voids cells-------------------------------

p <- source("old_plot/plot_3d_void_cell.R")
p

## 3d subvoid-group plot---------------------------------------------
p <- source("old_plot/plot_3d_with_groups.R")
p

## 3d density plot---------------------------------------------------
p <- source("old_plot/plot_3d_with_denisity.R")
p
}






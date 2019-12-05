group_frame <- c(seq(1:length(dataframe)))
number_of_groups <- length(unique(group_frame))

repeat{
  
  for (current_i in 1:length(dataframe)){
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
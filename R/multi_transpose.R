# multi_t function [sinew] ---- 
multi_t <- function(obj, f = multirow){
  
  if(nrow(obj)==0){
    return(obj)  
  }
  
  r_temp <- obj$row
  c_temp <- obj$col
  
  obj$row <- c_temp
  obj$col <- r_temp
  
  for(i in 1:nrow(obj)){
    obj$old_val[i] <- f(obj$new_val[i],as.numeric(obj$n[i]) + 1)%>%as.character()  
  }
  
  obj
}

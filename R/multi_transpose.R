# multi_t function [sinew] ---- 
multi_t <- function(obj, .f = multirow){
  
  if(nrow(obj)==0){
    return(obj)  
  }
  
  r_temp <- obj$row
  c_temp <- obj$col
  
  obj$row <- c_temp
  obj$col <- r_temp

  if(grepl('multirow',deparse(substitute(.f)))){
    obj <- obj%>%
      dplyr::group_by(col)%>%
      dplyr::mutate(
        row = row,
        shift_row = lag(n),
        shift_row = ifelse(is.na(shift_row),0,shift_row - 1),
        row = row + shift_row
      )%>%
      dplyr::ungroup()%>%
      dplyr::select(-shift_row)
  }
    
  for(i in 1:nrow(obj)){
    obj$call[i] <- .f(obj$value[i], obj$n[i])%>%as.character()  
  }
  

  
  obj
}

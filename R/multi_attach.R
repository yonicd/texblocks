multirow_attach <- function(obj,aes){
  
  if(is.null(aes))
    return(obj)
  
  if(nrow(aes)==0)
    return(obj)

  for(i in 1:nrow(aes)){
    
    nr <- as.numeric(aes$row[i])
    
    obj$val[nr] <- gsub(
      pattern = aes$new_val[i],
      replacement = aes$old_val[i],
      x = obj$val[nr],
      fixed = TRUE
      )
  }
    
  obj
}

multicol_attach <- function(obj,aes){
  
  if(is.null(aes))
    return(obj)
  
  if(nrow(aes)==0)
    return(obj)
  
    for(i in 1:nrow(aes)){
      
      nr <- as.numeric(aes$row[i])
      
      obj$val[nr] <- gsub(
        pattern = sprintf('%s%s',aes$new_val[i],strrep('&',aes$n[i])),
        replacement = aes$old_val[i],
        x = obj$val[nr],
        fixed = TRUE)
      
    }
  
  obj
}
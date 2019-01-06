modify_multi <- function(tb,i,j,new,type,f){
  
  new <- as.character(new)
  
  attr_env <- new.env()
  
  x <- strip(tb,attr_env)
  
  x <- as.data.frame(x)
  
  obj <- attr_env[[type]]
  
  err_msg <- sprintf('no %s found in row %s, column %s',tolower(type),i,j)
  
  if(nrow(obj)==0){
    stop(err_msg)
  }
  
  idx <- which(as.numeric(obj$row)==i&as.numeric(obj$col)==j)
  
  if(length(idx)==0){
    stop(err_msg)
  }
  
  new_obj <- f(new)
  
  obj$n[idx] <- new_obj$n
  obj$old_val[idx] <- new_obj$old_val
  
  attr_env[[type]] <- obj
  
  ret <- restore(x,attr_env)
  
  as.tb(ret)
}

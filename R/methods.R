# print.tb roxy [sinew] ---- 
#' @export
# print.tb function [sinew] ----
print.tb <- function(x,...){
  cat(x,sep='\n')
}

# is.tb roxy [sinew] ---- 
#' @title Is the object of class tb
#' @export
#' @description Is the object of class tb Very basic for many functions
#'  in the package.
#' @param x an object
#' @return logical - is the object of class tb
# is.tb function [sinew] ----
is.tb <- function(x) inherits(x, 'tb')

# rep.tb roxy [sinew] ---- 
#' @export
# rep.tb function [sinew] ----
rep.tb <- function(x,...){
  y <- NextMethod()
  lapply(y,as.tb)
}

# t.tb roxy [sinew] ---- 
#' @export
# t.tb function [sinew] ----
t.tb <- function(x) {
  x <- as.data.frame(x)
  xt <- as.data.frame(t(x))
  as.tb(xt)
}

# dim.tb roxy [sinew] ---- 
#' @export
# dim.tb function [sinew] ----
dim.tb <- function(x){
  dim(as.data.frame(x))
}

# crop roxy [sinew] ---- 
#' @title Crop texblocks
#' @description Extract a subset of a texblock
#' @param x tb
#' @param i numeric, row indicies to extract
#' @param j numeric, column indicies to extract
#' @return tb
#' @details idicies do not have to be consecutive, and can be -(...) 
#' to extract all but the subset.
#' @rdname crop
#' @export 
# crop function [sinew] ----
crop <- function(x,i,j){
  UseMethod('crop')
}

# crop.tb roxy [sinew] ---- 
#' @export
# crop.tb function [sinew] ----
crop.tb <- function(x,i,j){
  
  attr_env <- new.env()
  
  x <- strip(x,attr_env)
  
  obj <- x%>%
    as.data.frame()
  
  ret <- obj[i,j]
  
  ret <- ret%>%
    restore(attr_env)
  
  mr <- attr(ret,'MULTIROW')
  mc <- attr(ret,'MULTICOL')
  
  if(nrow(mr)>0){
    mr <- mr[mr$row%in%i,]
    mr <- mr[mr$col%in%j,]
    attr(ret,'MULTIROW') <- mr
  }
  
  if(nrow(mr)>0){
    mc <- mr[mc$row%in%i,]
    mc <- mr[mc$col%in%j,]
    attr(ret,'MULTICOL') <- mc
  }
  
  ret%>%as.tb()
}


# harvest roxy [sinew] ---- 
#' @title Extract subsets of texblocks
#' @description Wrapper to crop that applies lists of indicies
#' @param x tb
#' @param I list, row indicies to extract
#' @param J list, column indicies to extract
#' @return list of tb elements
#' @seealso 
#'  \code{\link[purrr]{map2}}
#' @rdname harvest
#' @export 
#' @importFrom purrr map2
# harvest function [sinew] ----
harvest <- function(x,I,J){
  purrr::map2(I,J,crop,x=x)
}

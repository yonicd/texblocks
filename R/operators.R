#' @title texblock operators
#' @description combine texblock object into bigger texblock objects
#' @param e1 texblock object, right hand side object
#' @param e2 texblock object, left hand side object
#' @examples 
#' 
#' x <- '$\\alpha$'
#' y <- 'cindy'
#' class(x) <- 'tb'
#' class(y) <- 'tb'
#' x1 <- x+y+x
#' x1
#' x1 + x1
#' x1 / x1
#' x2 <- x1 / x1
#' x2 + x2
#' x3 <- x2/x2
#' x2 + x3
#' 
#' @details
#'  
#'  + : joins e1 to e2 horizontally (cbind)
#'  
#'  / : joins e1 to e2 vertically with no hline betweet them (rbind)
#'  
#' 
#' @return texblock object
#' @name operators
#' @rdname texblocks_opts
#' @export
'+.tb' <- function(e1,e2){
  
  ret <- join(e1,e2)
  as.tb(ret)
}

#' @rdname texblocks_opts
#' @export
'/.tb' <- function(e1,e2){

  d1 <- ncol(e1)
  d2 <- ncol(e2)
  
  if(d1<d2){
    e1 <- pad_col(e1,d2-d1)
  }
  
  if(d2<d1){
    e2 <- pad_col(e2,d1-d2)
  }
  
  e1 <- gsub('\\\\\\\\$','',e1)
    
  ret <- sprintf('%s\\\\\n%s',e1,e2)
  as.tb(ret)
}

#' Pipe operator
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom purrr %>%
#' @usage lhs \%>\% rhs
NULL

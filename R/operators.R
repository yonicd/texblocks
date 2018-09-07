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
#' \tabular{lc}{
#'   + \tab joins e1 to e2 horizontally \cr
#'   / \tab joins e1 to e2 vertically with no hline betweet them  \cr
#'   - \tab joins e1 to e2 vertically with an hline between them
#'  }
#' 
#' @return texblock object
#' @rdname texblocks_opts
#' @export
'+.tb' <- function(e1,e2){
  ret <- join(e1,e2)
  class(ret) <- 'tb'
  ret
}

#' @rdname texblocks_opts
#' @export
'/.tb' <- function(e1,e2){
  ret <- sprintf('%s\\\\\n%s',e1,e2)
  class(ret) <- 'tb'
  ret
}

#' @rdname texblocks_opts
#' @export
'-.tb' <- function(e1,e2){
  ret <- sprintf('%s\\\\ \\hline\n%s',e1,e2)
  class(ret) <- 'tb'
  ret
}
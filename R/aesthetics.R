#' @title add hlines
#' @description add hlines to texblock object
#' @param x texblock
#' @param lines lines to add hline, Default: NULL
#' @return texblock
#' @details if NULL then all lines have hline added to them
#' @rdname hline
#' @export 

hline <- function(x,lines=NULL){

  x1 <- as.data.frame(x)
  if(is.null(lines))
    lines <- 0:nrow(x1)
  
  attr(x1,'HLINES') <- lines
  
  as.tb(x1)
}

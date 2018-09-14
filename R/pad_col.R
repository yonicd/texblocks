#' @title pad columns of texblock
#' @description add columns to texblock to the left
#' @param x tb
#' @param cols number of columns to pad, Default: 1
#' @return tb
#' @rdname pad_col
#' @export 

pad_col <- function(x,cols=1){
  ret <- sprintf('%s%s',
          strrep('&',cols),
          strsplit(x,'\n')[[1]])
  as.tb(paste0(ret,collapse = '\n'))
  
}

#' @title reduce dimension of list of texblocks
#' @description reduce a list of texblock by rows or columns
#' @param x tb
#' @param margin how to reduce 1 by rows, 2 by columns, Default: 1
#' @return tb
#' @rdname tb_reduce
#' @export
tb_reduce <- function(...,margin=c(1,2)){

  x <- as.list(...)
  
  switch(margin,
         '1' = Reduce(`/`,as.tb(x)),
         '2' = Reduce(`+`,as.tb(x))
  )
  
}
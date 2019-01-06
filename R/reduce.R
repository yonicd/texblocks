#' @title reduce dimension of list of texblocks
#' @description reduce a list of texblock by rows or columns
#' @param \dots values to reduce
#' @param margin numeric, how to reduce 1 by rows, 2 by columns, Default: 1
#' @param merge boolean, merge duplicated values into a multirow/multicolumn, Default: FALSE
#' @return tb
#' @rdname tb_reduce
#' @export
tb_reduce <- function(...,margin=1,merge = FALSE){
  
  x <- as.list(...)
  
  if(merge){
    ret <- tb_reduce_merge(unlist(x),margin = margin)
    return(ret)
  }
  
  ret <- switch(margin,
                '1' = Reduce(`/`,as.tb(x)),
                '2' = Reduce(`+`,as.tb(x))
  )
  
  return(ret)
  
}

tb_reduce_merge <- function(x,margin = 1){
  xrle <- x%>%rle()
  
  purrr::map2(xrle$values,xrle$lengths,function(x,y,margin){
    if(y>1){
      if(margin==1){
        ret <- multirow(x,y)%>%pad(y-1,'b')
      }
      
      if(margin==2){
        ret <- multicol(x,y)
      }
      
    }else{
      ret <- as.tb(x)
    }
    
    ret
  },margin=margin)%>%
    tb_reduce(margin=margin)
  
}

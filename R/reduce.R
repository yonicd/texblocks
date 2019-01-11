#' @title reduce dimension of list of texblocks
#' @description reduce a list of texblock by rows or columns
#' @param \dots values to reduce
#' @param margin numeric, how to reduce 1 by rows, 2 by columns, Default: 1
#' @param merge boolean, merge duplicated values into a multirow/multicolumn, Default: FALSE
#' @return tb
#' @rdname tb_reduce
#' @export
#' @importFrom purrr reduce
tb_reduce <- function(..., margin = 1, merge = FALSE){
  
  if(merge){
    ret <- tb_reduce_merge(..., margin = margin)
    return(ret)
  }
  
  x <- list(...)
  
  if(x%>%purrr::map_lgl(inherits,what='list')%>%all()){
    x <- x%>%purrr::flatten()
  }
  
  ret <- switch(margin,
                '1' = x%>%as.tb()%>%purrr::reduce(`/`),
                '2' = x%>%as.tb()%>%purrr::reduce(`+`)
  )
  
  return(ret)
  
}

tb_reduce_merge <- function(..., margin = 1){
  
  x <- list(...)%>%unlist()
  
  xrle <- x%>%rle()
  
  ret <- purrr::map2(xrle$values,xrle$lengths,function(x, y, margin){
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
  },margin=margin)
  
  
  ret <- ret %>% tb_reduce( margin = margin )
  
}

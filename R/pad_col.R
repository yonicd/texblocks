#' @title pad texblock
#' @description add columns/rows to texblock
#' @param x tb
#' @param times numeric, number of columns to pad, Default: 1
#' @param sides character, which side to pad t,b,l or r
#' @return tb
#' @rdname pad
#' @export 

pad <- function(x,times,sides){
  sides <- strsplit(sides,'')[[1]]
  
  if(length(setdiff(sides,c('t','b','l','r')))>0)
    stop('sides must be only from t,b,l,r')
  
  if(length(times)==1)
    times <- rep(times,length(sides))
  
  if(length(times)!=length(sides))
    stop('length of times not equal to the number of sides')
  
  for(i in seq_along(sides)){
    
    if(sides[i]%in%c('t','b'))
      x <- x%>%pad_row(times[i],sides[i])
    
    if(sides[i]%in%c('l','r'))
      x <- x%>%pad_col(times[i],sides[i])
  }
  
  x
}

pad_col <- function(x, cols = 1, side = 'l'){
  
  if(!side%in%c('l','r'))
    stop('side must be either "l" (left) or "r" (right)')
  
  old_text <- strsplit(x,'\n')[[1]]
  idx <- grepl('\\\\$',old_text)
  new_text <- gsub('\\\\','',old_text)
  
  if(side=='l'){
    new_text <- sprintf('%s%s',
                        strrep('&',cols),
                        new_text
                        )
  }
  
  if(side=='r'){
    new_text <- sprintf('%s%s',
                        new_text,
                        strrep('&',cols)
                        )
  }
  
  new_text[idx] <- sprintf('%s\\\\',new_text[idx])

  
  out_text <- paste0(new_text,collapse = '\n')
  
  as.tb(out_text)
  
}

pad_row <- function(x, rows = 1, side = 'b'){
  
  if(!side%in%c('b','t'))
    stop('side must be either "b" (bottom) or "t" (top)')
  
  nc <- ncol(x)-1
  
  if(side=='b') ret <- sprintf('%s\\\\\n%s',as.character(x),strrep(sprintf('%s\\\\\n',strrep('&',nc)),rows))
  if(side=='t') ret <- sprintf('%s%s\\\\',strrep(sprintf('%s\\\\\n',strrep('&',nc)),rows),as.character(x))
  
  ret <- gsub('\\n$','',ret)
  
  as.tb(ret)
}

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

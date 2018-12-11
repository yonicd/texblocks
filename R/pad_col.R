#' @title pad columns of texblock
#' @description add columns to texblock to the left
#' @param x tb
#' @param cols numeric, number of columns to pad, Default: 1
#' @param side numeric, which side to pad, 1='left' 2='right', Default: 1
#' @return tb
#' @rdname pad_col
#' @export 

pad_col <- function(x, cols = 1, side = 1){
  
  if(!side%in%c(1,2))
    stop('side must be either 1 (left) or 2 (right)')
  
  old_text <- strsplit(x,'\n')[[1]]
  idx <- grepl('\\\\$',old_text)
  new_text <- gsub('\\\\$','',old_text)
  
  if(side==1){
    new_text <- sprintf('%s%s',
                        strrep('&',cols),
                        new_text
                        )
  }
  
  if(side==2){
    new_text <- sprintf('%s%s',
                        new_text,
                        strrep('&',cols)
                        )
  }
  
  new_text[idx] <- sprintf('%s\\\\',new_text[idx])

  
  out_text <- paste0(new_text,collapse = '\n')
  
  as.tb(out_text)
  
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
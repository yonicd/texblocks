#' @title Merge texblocks
#' @description Create multirow/multicol to texblock object
#' @param content character, contents to display in the merged cell
#' @param nrow numeric, number of rows to span in the multirow
#' @param ncol numeric, number of columns to span in the multicol
#' @param width character, width of the new element, Default: '*'
#' @param align character, alignment of the merged column, Default: 'c'
#' @return tb 
#' @details
#' align is either l, c, r, or to have text wrapping specify a width p{5.0cm}.
#' * for the width means the content's natural width.
#' @examples 
#' multirow('aaa',2)
#' multicol('aaa',2)
#' @rdname mergecells
#' @export 

multirow <- function(content,nrow,width = '*'){
  ret <- sprintf('\\multirow{%s}{%s}{%s}',nrow,width,content)
  as.tb(ret)
}

#' @rdname mergecells
#' @export 
multicol <- function(content,ncol,align = 'c'){
  ret <- sprintf('\\multicolumn{%s}{%s}{%s}',ncol,align,content)
  as.tb(ret)
}

revmulticol <- function(x,skip = FALSE){
  if(skip)
    return(x)
  
  mc <- regmatches(x, gregexpr('\\\\multicolumn\\{(.*?)\\}\\{(.*?)\\}', x))
  
  if(length(mc[[1]])==0)
    return(x)
  
  ns <- lapply(mc,function(x) strsplit(gsub('[\\}|]','',x),'\\{')[[1]])
  for(i in seq_along(ns)){
    x <- gsub(mc[[i]],
              sprintf('%s%s',
                      ns[[i]][4],
                      strrep('& ',as.numeric(ns[[i]][2])-1)
                      ),
              x,
              fixed = TRUE) 
  }
  x
  
}

revmultirow <- function(x,skip = FALSE){
  
  if(skip)
    return(x)
  
  mr <- regmatches(x, gregexpr('\\\\multirow\\{(.*?)\\}\\{(.*?)\\}', x))
  
  if(length(mr[[1]])==0)
    return(x)
  
  ns <- lapply(mr,function(x) strsplit(gsub('[\\}|]','',x),'\\{')[[1]])
  for(i in seq_along(ns)){
    x <- gsub(mr[[i]],
              ns[[i]][4],
              x,
              fixed = TRUE)  
  }
  x
}
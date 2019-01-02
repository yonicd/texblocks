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

strip_multicol <- function(x){
  
  mc <- regmatches(x, gregexpr('\\\\multicolumn\\{(.*?)\\}\\{(.*?)\\}', x))
  
  if(length(mc[[1]])==0)
    return(x)
  
  ns <- lapply(mc,function(x) strsplit(gsub('[\\}|]','',x),'\\{')[[1]])
  for(i in seq_along(ns)){
    for(ii in seq_along(mc[[i]])){
      x <- gsub(mc[[i]][ii],
                sprintf('%s%s',
                        ns[[i]][4],
                        strrep('& ',as.numeric(ns[[i]][2])-1)
                ),
                x,
                fixed = TRUE)   
    }
  }
  x
  
}

strip_multirow <- function(x){

  mr <- regmatches(x, gregexpr('\\\\multirow\\{(.*?)\\}\\{(.*?)\\}', x))
  
  if(length(mr[[1]])==0)
    return(x)
  
  ns <- lapply(mr,function(x) strsplit(gsub('[\\}|]','',x),'\\{')[[1]])
  for(i in seq_along(ns)){
    for(ii in seq_along(mr[[i]])){
    x <- gsub(mr[[i]][ii],
              ns[[i]][4],
              #gsub('\\\\\\\\$','',as.tb(ns[[i]][4])%>%pad(ns[[i]][2],'b')%>%as.character()),
              x,
              fixed = TRUE)
    }
  }
  x
}

#' @importFrom purrr set_names
find_multicol <- function(x){
  x <- as.character(x)
  
  if(!nzchar(x))
    return(NULL)
  
  sx <- strsplit(x,'\\n')[[1]]
  
  idx <- gregexpr('\\\\multicolumn\\{(.*?)\\}\\{(.*?)\\}', sx)
  
  if(identical(idx, integer(0)))
    return(NULL)

  
  midx <- mapply(regmatches,sx,idx,USE.NAMES = FALSE)
  sidx <- purrr::set_names(midx,seq_along(sx))
  found <- sapply(sidx,function(x)!identical(x,character(0)))
  sidy <- sidx[found]
  ns <- lapply(sidy,function(x) strsplit(gsub('[\\}|]','',x),'\\{')[[1]]) 
  
  ret <- lapply(names(ns),function(nm){
    this <- strsplit(sx[as.numeric(nm)],'&')[[1]]
    start_col <- grep(sidy[[nm]],this,fixed = TRUE)
    c(row = as.numeric(nm),
      col = start_col,
      ncol = as.numeric(ns[[nm]][2])-1,
      new_val = ns[[nm]][4],
      old_val = sidy[[nm]]
      ) 
  })
  
  data.frame(do.call('rbind',ret),stringsAsFactors = FALSE)
}

#' @importFrom purrr set_names
find_multirow <- function(x){
  x <- as.character(x)
  
  if(!nzchar(x))
    return(NULL)
  
  sx <- strsplit(x,'\\n')[[1]]
  idx <- gregexpr('\\\\multirow\\{(.*?)\\}\\{(.*?)\\}', sx)
  
  if(identical(idx, integer(0)))
    return(NULL)

  midx <- mapply(regmatches,sx,idx,USE.NAMES = FALSE)
  sidx <- purrr::set_names(midx,seq_along(sx))
  found <- sapply(sidx,function(x)!identical(x,character(0)))
  sidy <- sidx[found]
  ns <- lapply(sidy,function(x) strsplit(gsub('[\\}|]','',x),'\\{')[[1]]) 
  
  ret <- lapply(names(ns),function(nm){
    this <- strsplit(sx[as.numeric(nm)],'&')[[1]]
    start_col <- grep(sidy[[nm]],this,fixed = TRUE)
    c(row = as.numeric(nm),
      col = start_col,
      new_val = ns[[nm]][4],
      old_val = sidy[[nm]],
      nr = ns[[nm]][2]
    )
  })
  
  data.frame(do.call('rbind',ret),stringsAsFactors = FALSE)
}
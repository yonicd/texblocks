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
  
  ns <- lapply(mc,function(x) strsplit(gsub('[\\}|]','',x),'\\{'))
  mc <- lapply(mc,as.list)
  
  for(i in seq_along(ns)){
    for(j in seq_along(ns[[i]])){
      x <- gsub(mc[[i]][[j]],
                sprintf('%s%s',
                        ns[[i]][[j]][4],
                        strrep('&',as.numeric(ns[[i]][[j]][2])-1)
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
  
  ns <- lapply(mr,function(x) strsplit(gsub('[\\}|]','',x),'\\{'))
  mr <- lapply(mr,as.list)
  
  for(i in seq_along(ns)){
      for(j in seq_along(ns[[i]])){
        x <- gsub(mr[[i]][[j]],
                  ns[[i]][[j]][4],
                  x,
                  fixed = TRUE)
      }  
  }
  x
}

#' @importFrom purrr set_names map_df
#' @export
find_multicol <- function(x){
  x_char <- as.character(x)
  
  if(!nzchar(x_char))
    return(NULL)
  
  x_list <- strsplit(x_char,split = '\\\\\\\\')[[1]]%>%
    purrr::set_names(1:length(.))
  
  x_list <- purrr::map(x_list,gsub,pattern = '^\\n|^\\s+',replacement = '')
  
  x_list%>%
    purrr::map_df(function(y){
      sx <- strsplit(y,split = '\\&')[[1]]
      idx <- gregexpr('\\\\multicolumn\\{(.*?)\\}\\{(.*?)\\}', sx)
      if(identical(idx, integer(0)))
        return(NULL)
      
      if(length(idx)==0)
        return(NULL)
      
      if(idx[[1]][1]==-1)
        return(NULL)
      
      midx <- mapply(regmatches,sx,idx,USE.NAMES = FALSE)
      sidx <- purrr::set_names(midx,seq_along(sx))
      found <- sapply(sidx,function(x)!identical(x,character(0)))
      sidy <- sidx[found]
      
      ns <- lapply(sidy,function(x) strsplit(gsub('[\\}|]','',x),'\\{')[[1]]) 
      
      purrr::map_df(names(ns),function(nm){
        this <- strsplit(sx[as.numeric(nm)],'&')[[1]]
        start_col <- grep(sidy[[nm]],this,fixed = TRUE)
        data.frame(
          col = nm,
          n = as.numeric(ns[[nm]][2]) - 1,
          new_val = ns[[nm]][4],
          old_val = sidy[[nm]],
          stringsAsFactors = FALSE
        )
      })
    },.id='row')
  
}

#' @importFrom purrr set_names map_df
#' @export
find_multirow <- function(x){
  
  x_char <- as.character(x)
  
  if(!nzchar(x_char))
    return(NULL)
  
  x_list <- strsplit(x_char,split = '\\\\\\\\')[[1]]%>%
    purrr::set_names(1:length(.))
  
  x_list <- purrr::map(x_list,gsub,pattern = '^\\n|^\\s+',replacement = '')
  
  x_list%>%
    purrr::map_df(function(y){
      sx <- strsplit(y,split = '\\&')[[1]]
      idx <- gregexpr('\\\\multirow\\{(.*?)\\}\\{(.*?)\\}', sx)
      if(identical(idx, integer(0)))
        return(NULL)
      
      if(length(idx)==0)
        return(NULL)
      
      if(idx[[1]][1]==-1)
        return(NULL)
      
      midx <- mapply(regmatches,sx,idx,USE.NAMES = FALSE)
      sidx <- purrr::set_names(midx,seq_along(sx))
      found <- sapply(sidx,function(x)!identical(x,character(0)))
      sidy <- sidx[found]
      
      ns <- lapply(sidy,function(x) strsplit(gsub('[\\}|]','',x),'\\{')[[1]]) 
      
      purrr::map_df(names(ns),function(nm){
        this <- strsplit(sx[as.numeric(nm)],'&')[[1]]
        start_col <- grep(sidy[[nm]],this,fixed = TRUE)
        data.frame(
          col = nm,
          n = as.numeric(ns[[nm]][2]) - 1,
          new_val = ns[[nm]][4],
          old_val = sidy[[nm]],
          stringsAsFactors = FALSE
        )
      })
    },.id='row')
  
}

multi_t <- function(obj, f = multirow){
  
  if(nrow(obj)==0){
    return(obj)  
  }
  
  r_temp <- obj$row
  c_temp <- obj$col
  
  obj$row <- c_temp
  obj$col <- r_temp
  
  for(i in 1:nrow(obj)){
    obj$old_val[i] <- f(obj$new_val[i],as.numeric(obj$n[i]) + 1)%>%as.character()  
  }
  
  obj
}

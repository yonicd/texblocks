# multicol roxy [sinew] ---- 
#' @rdname mergecells
#' @export 
# multicol function [sinew] ----
multicol <- function(content,ncol,align = 'c'){
  ret <- sprintf('\\multicolumn{%s}{%s}{%s}',ncol,align,content)
  as.tb(ret)
}

# strip_multicol function [sinew] ---- 
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

# find_multicol roxy [sinew] ---- 
#' @title Find multirow or multicolumn
#' @description Returns indicies of multirow or multicolumn in a texblocks
#' @param x texblock
#' @return data.frame
#' @examples 
#' x <- multicol('a',2)
#' y <- multirow('a',2)
#' x%>%find_multicol()
#' y%>%find_multirow()
#' 
#' @rdname find_merge
#' @importFrom purrr set_names map_df map_lgl
#' @export
# find_multicol function [sinew] ----
find_multicol <- function(x){
  x_char <- as.character(x)
  
  if(!nzchar(x_char))
    return(NULL)
  
  x_list <- strsplit(x_char,split = '\\\\\\\\')[[1]]
  
  x_list <- purrr::set_names(x_list,1:length(x_list))
  
  x_list <- purrr::map(x_list,gsub,pattern = '^\\n|^\\s+',replacement = '')
  
  x_list%>%
    purrr::map_df(function(y){
      sx <- strsplit(y,split = '\\&')[[1]]
      idx <- gregexpr('\\\\multicolumn\\{(.*?)\\}\\{(.*?)\\}', sx)
      if(identical(idx, integer(0)))
        return(NULL)
      
      if(length(idx)==0)
        return(NULL)
      
      if(purrr::map_lgl(idx,function(x) as.numeric(x)==-1)%>%all())
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

# multicol_attach function [sinew] ---- 
multicol_attach <- function(obj,aes){
  
  if(is.null(aes))
    return(obj)
  
  if(nrow(aes)==0)
    return(obj)
  
  for(i in 1:nrow(aes)){
    
    nr <- as.numeric(aes$row[i])
    
    obj$val[nr] <- gsub(
      pattern = sprintf('%s%s',aes$new_val[i],strrep('&',aes$n[i])),
      replacement = aes$old_val[i],
      x = obj$val[nr],
      fixed = TRUE)
    
  }
  
  obj
}
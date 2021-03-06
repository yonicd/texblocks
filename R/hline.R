# hline roxy [sinew] ---- 
#' @title add hlines
#' @description add hlines to texblock object
#' @param x texblock
#' @param lines lines to add hline, Default: NULL
#' @return texblock
#' @details if NULL then all lines have hline added to them
#' @rdname hline
#' @export 
# hline function [sinew] ----

hline <- function(x,lines=NULL){

  x1 <- as.data.frame(x)
  
  if(is.null(lines))
    lines <- 0:nrow(x1)
  
  attr(x1,'HLINES') <- lines
  
  as.tb(x1)
}

# find_hline roxy [sinew] ---- 
#' @importFrom purrr set_names
# find_hline function [sinew] ----
find_hline <- function(x){
  sx <- strsplit(as.character(x),'\n')[[1]]
  
  
  hlines <- grep(paste0(tex_slash,hline_),sx)
  
  if(identical(hlines, integer(0)))
    return(NULL)
  
  if(1%in%hlines){
    sx1 <- sx[[which(hlines==1)]]
    if(grepl(sprintf('^%s%s',tex_slash,hline_),sx1)){
        hlines[which(hlines==1)] <- 0  
        hlines[-1] <- hlines[-1] - 1
    }
  }else{
    hlines <- hlines - 1
  }

  hlines
}

# strip_hline function [sinew] ---- 
strip_hline <- function(x){
  y     <- paste0(tex_slash,hline_)
  query <- sprintf('%s\\n| %s$', y, y)
  gsub(query,'',x)
}

# hline_attach function [sinew] ---- 
hline_attach <- function(obj,aes,line_end){
  
  if(is.null(aes))
    return(obj)
  
  if(!nzchar(line_end)){
    line_end<- ' '
  }
  
  if( ! ( 'line_end' %in% names(obj) ) )
    obj$line_end <- line_end
  
  for(i in seq_along(aes)){
    
    obj$line_end[aes[i]] <- gsub(
      pattern = line_end,
      replacement = sprintf('%s %s',tex_line,hline_),
      x = obj$line_end[aes[i]],
      fixed = TRUE)   
  }
  
  obj
  
}

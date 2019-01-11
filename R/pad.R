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
  new_text <- gsub(tex_line,'',old_text)
  
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

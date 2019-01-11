# cline roxy [sinew] ---- 
#' @title add clines to texblock
#' @description add clines to texblock object using a list object containing specifications.
#' @param x texblock
#' @param specs data.frame/list, object containing named elements c(line, i, j)
#' @return texblock
#' @details
#' 
#' line is the index to add the cline
#' 
#' i is the index to star the cline
#' 
#' j is the index to end the cline
#' 
#' if specs is a dataframe then it will be converted internally into a list using split
#' on the specs$line element.
#' 
#' @examples 
#' x <- as.tb('$\\alpha$')
#' y <- as.tb('aaa')
#' z <- as.tb('bbb')
#' 
#' p <- x+y+z
#' 
#' l <- list(c(line=1,i=2,j=3),c(line=2,i=1,j=2),c(line=3,i=2,j=3))
#' d <- data.frame(line=1:3,i=c(2,1,2),j=c(3,2,3))
#' 
#' (p/p/p)%>%
#' cline(l)
#' 
#' (p/p/p)%>%
#' cline(d)
#' 
#' @rdname cline
#' @importFrom purrr set_names
#' @export 
# cline function [sinew] ----

cline <- function(x,specs){
  
  if(inherits(specs,'data.frame')){
    specs <- split(specs,specs$line)
    specs <- lapply(specs,function(y) purrr::set_names(as.numeric(y),names(y)))
  }
  
  x1 <- as.data.frame(x)
  
  attr(x1,'CLINES') <- specs
  
  as.tb(x1)
}

# find_cline function [sinew] ---- 
find_cline <- function(x){
  sx <- strsplit(as.character(x),'\n')[[1]]
  
  clines <- grep('\\\\cline',sx)
  
  if(identical(clines, integer(0)))
    return(NULL)
  
  l <- strsplit(gsub('^(.*?)cline|[\\{\\}]','',sx[clines]),'-')
  
  clines <- mapply(function(x,y){
    purrr::set_names(c(y,as.numeric(x)),c('line','i','j'))
  },x=l,y=clines,SIMPLIFY = FALSE)
  
  clines <- data.frame(do.call('rbind',clines))
  
  if(1%in%clines$line){
    sx1 <- sx[[which(clines$line==1)]]
    if(grepl('^\\\\cline',sx1)){
      clines$line[which(clines$line==1)] <- 0  
      clines$line[-1] <- clines$line[-1] - 1
    }
  }else{
    clines$line <- clines$line - 1
  }
  
  specs <- split(clines,clines$line)
  specs <- lapply(specs,function(y) purrr::set_names(as.numeric(y),names(y)))
  
  specs
}

# strip_cline function [sinew] ---- 
strip_cline <- function(x){
  paste0(gsub(' \\\\cline(.*?)$','',strsplit(x,'\\n')[[1]]),collapse='\n')
}

# cline_attach function [sinew] ---- 
cline_attach <- function(obj,aes,line_end){
  
  if(is.null(aes))
    return(obj)
  
  if(!nzchar(line_end))
    line_end<- ' '
  
  obj$line_end <- line_end
  
  for(i in seq_along(aes)){
    obj$line_end[aes[[i]]['line']] <- gsub(
      pattern = line_end,
      replacement = sprintf(
        fmt = '\\\\ \\cline{%s-%s}',
        aes[[i]]['i'],aes[[i]]['j']
      ),
      x = obj$line_end[aes[[i]]['line']],
      fixed = TRUE)
  }
  
  if(line_end == ' '){
    obj$line_end <- ''
  }
  
  
  obj
}

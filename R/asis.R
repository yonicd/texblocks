#' @title Try to coerce an object into a texblock object
#' @description coerce objects into a tb class object
#' @param x object
#' @return an object of class tb
#' @export
as.tb <- function(x){
  UseMethod('as.tb')
}

#' @export
as.tb.default <- function(x){
  class(x) <- 'tb'
  return(x)
}

#' @import dplyr
#' @importFrom tidyr gather
#' @importFrom rlang !! sym
#' @export
as.tb.data.frame <- function(x){

  ret <- x%>%
    dplyr::mutate(r=1:n())%>%
    dplyr::mutate_if(is.character, dplyr::coalesce, ... = '')%>%
    tidyr::gather(key='c',value='val',-!!rlang::sym('r'))%>%
    dplyr::mutate_at(dplyr::vars(!!rlang::sym('r'),c),dplyr::funs(as.numeric))%>%
    dplyr::arrange(!!rlang::sym('r'),c)%>%
    dplyr::group_by(!!rlang::sym('r'))%>%
    dplyr::summarise(val=paste0(!!rlang::sym('val'),collapse = '&'))%>%
    dplyr::ungroup()
  
  if(nrow(ret)==1){
    line_end <- ''
  }else{
    line_end <- '\\\\'
  }

  ret <- ret%>%
    mutate(line_end=line_end)
    
  if(!is.null(attr(x,'HLINE'))){
    ret$line_end[attr(x,'HLINE')] <- gsub(line_end,
                                          '\\\\ \\hline',
                                          ret$line_end[attr(x,'HLINE')],
                                          fixed = TRUE)
    }
  
   ret <- ret%>%
     dplyr::mutate(val = sprintf('%s%s',val,line_end))%>%
      dplyr::summarise(val=paste0(!!rlang::sym('val'),
                                collapse = '\n'))%>%
      dplyr::pull(!!rlang::sym('val'))
  
   if(!is.null(attr(x,'HLINE'))){
     if(0%in%attr(x,'HLINE')){
       ret <- sprintf('\\hline %s',ret)
     }
   }
   
  as.tb(ret)
}

#' @title convert texblock to data.frame
#' @description convert a texblock class into a data.frame
#' @param x texblock object
#' @param \dots not used
#' @return data.frame
#' @examples 
#' x <- 'a'
#' class(x) <- 'tb'
#' x1 <- x+x
#' as.data.frame(x1)
#' 
#' @rdname as.data.frame.tb
#' @export 
#' @importFrom purrr map transpose set_names flatten_chr
#' @import dplyr
as.data.frame.tb <- function(x,...){

  l <- list(...)
  if(length(l)==0)
    l$skip <- FALSE
  
  
  l <- x%>%
    parse_tb(skip=l$skip)%>%
    purrr::map(function(x) strsplit(x,split = '_NEWCOL_')[[1]])%>%
    purrr::transpose()
  
  ret <- l%>%
    purrr::set_names(seq_along(l))%>%
    dplyr::as_tibble()%>%
    dplyr::mutate_all(purrr::flatten_chr)
  
  return(ret)
}

parse_tb <- function(x,skip){
  
  x <- x%>%
    revmultirow(skip)%>%
    revmulticol(skip)
  
  y <- gsub('&',
            '_NEWCOL_',
            gsub('\\n',
                 '',
                 gsub('\\\\',
                      '_NEWROW_',
                      x,
                      fixed=TRUE)
            )
  )
  
  # y <- gsub('_NEWROW_ \\\\hline',
  #           '_NEWROW_LINE_',
  #           y
  #           )
  
  strsplit(y,'_NEWROW_')[[1]]
}

#' @export
print.tb <- function(x,...){
  cat(x,sep='\n')
}

#' @title Is the object of class tb
#' @export
#' @description Is the object of class tb Very basic for many functions
#'  in the package.
#' @param x an object
#' @return logical - is the object of class tb
is.tb <- function(x) inherits(x, 'tb')

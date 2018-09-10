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
    
  if(!is.null(attr(x,'HLINES'))){
    ret$line_end[attr(x,'HLINES')] <- gsub(line_end,
                                          '\\\\ \\hline',
                                          ret$line_end[attr(x,'HLINES')],
                                          fixed = TRUE)
    }
  
  if(!is.null(attr(x,'CLINES'))){
    
    cl <- attr(x,'CLINES')
    
    for(i in seq_along(cl)){
      ret$line_end[cl[[i]]['line']] <- gsub(line_end,sprintf('\\\\ \\cline{%s-%s}',
                                                        cl[[i]]['i'],cl[[i]]['j']),
                                       ret$line_end[cl[[i]]['line']],
                                       fixed = TRUE)
    }

  }
  
   ret <- ret%>%
     dplyr::mutate(val = sprintf('%s%s',!!rlang::sym('val'),line_end))%>%
      dplyr::summarise(val=paste0(!!rlang::sym('val'),
                                collapse = '\n'))%>%
      dplyr::pull(!!rlang::sym('val'))
  
   if(!is.null(attr(x,'HLINES'))){
     if(0%in%attr(x,'HLINES')){
       ret <- sprintf('\\hline\n%s',ret)
     }
   }
   
   if(!is.null(attr(x,'CLINES'))){
     
     cl <- attr(x,'CLINES')
     
     cl_idx <- sapply(cl,'[[',1)
     cl_idx0 <- which(cl_idx==0)
     
     if(length(cl_idx0)>0){
       ret <- sprintf('\\cline{%s-%s}\n%s',cl[[cl_idx0]]['i'],cl[[cl_idx0]]['j'],ret)
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
  
  hlines <- find_hline(x)
  clines <- find_cline(x)
  
  if(!is.null(hlines)){
    x <- strip_hline(x)
  }
  
  if(!is.null(clines)){
    x <- strip_cline(x)
  }
  
  l <- x%>%
    parse_tb(skip=l$skip)%>%
    purrr::map(function(x) strsplit(x,split = '_NEWCOL_')[[1]])%>%
    purrr::transpose()
  
  ret <- l%>%
    purrr::set_names(seq_along(l))%>%
    dplyr::as_tibble()%>%
    dplyr::mutate_all(purrr::flatten_chr)
  
  if(!is.null(hlines)){
    attr(ret,'HLINES') <- hlines
  }
  
  if(!is.null(clines)){
    attr(ret,'CLINES') <- clines
  }
  
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

#' @export
rep.tb <- function(x,...){
  y <- NextMethod()
  lapply(y,as.tb)
}
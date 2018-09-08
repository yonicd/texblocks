#' @title texblock operators
#' @description combine texblock object into bigger texblock objects
#' @param e1 texblock object, right hand side object
#' @param e2 texblock object, left hand side object
#' @examples 
#' 
#' x <- '$\\alpha$'
#' y <- 'cindy'
#' class(x) <- 'tb'
#' class(y) <- 'tb'
#' x1 <- x+y+x
#' x1
#' x1 + x1
#' x1 / x1
#' x2 <- x1 / x1
#' x2 + x2
#' x3 <- x2/x2
#' x2 + x3
#' 
#' @details
#'  
#'  + : joins e1 to e2 horizontally
#'  
#'  / : joins e1 to e2 vertically with no hline betweet them
#'  
#'  - : joins e1 to e2 vertically with an hline between them

#' 
#' @return texblock object
#' @name operators
#' @rdname texblocks_opts
#' @export
'+.tb' <- function(e1,e2){
  ret <- join(e1,e2)
  as.tb(ret)
}

#' @rdname texblocks_opts
#' @export
'/.tb' <- function(e1,e2){
  ret <- sprintf('%s\\\\\n%s',e1,e2)
  as.tb(ret)
}

# @rdname texblocks_opts
# @export
# '-.tb' <- function(e1,e2){
#   ret <- sprintf('%s\\\\ \\hline\n%s',e1,e2)
#   as.tb(ret)
# }

#' @title Try to coerce an object into a texblock object
#' @description coerce objects into a tb class object
#' @param x object
#' @return an object of class tb
#' @export
as.tb <- function(x){
  UseMethod('as.tb')
}

#' @export
print.tb <- function(x,...){
  cat(x,sep='\n')
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
    dplyr::ungroup()%>%
    dplyr::summarise(val=paste0(!!rlang::sym('val'),collapse = '\\\\\n'))%>%
    dplyr::pull(!!rlang::sym('val'))
  
  as.tb(ret)
}

#' @title Is the object of class tb
#' @export
#' @description Is the object of class tb Very basic for many functions
#'  in the package.
#' @param x an object
#' @return logical - is the object of class tb
is.tb <- function(x) inherits(x, 'tb')

#' @inherit purrr::'%>%'
#' @importFrom purrr %>%
#' @name %>%
#' @rdname pipe
#' @export
NULL

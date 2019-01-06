# as.tb roxy [sinew] ---- 
#' @title Try to coerce an object into a texblock object
#' @description coerce objects into a tb class object
#' @param x object
#' @return an object of class tb
#' @export
# as.tb function [sinew] ----
as.tb <- function(x){
  UseMethod('as.tb')
}

# as.tb.default roxy [sinew] ---- 
#' @export
# as.tb.default function [sinew] ----
as.tb.default <- function(x){
  class(x) <- 'tb'
  return(x)
}

# as.tb.tb roxy [sinew] ---- 
#' @export
# as.tb.tb function [sinew] ----
as.tb.tb <- function(x){
  return(x)
}

# as.tb.matrix roxy [sinew] ---- 
#' @export
# as.tb.matrix function [sinew] ----
as.tb.matrix <- function(x,...){
  as.tb(as.data.frame(x))
}

# as.tb.dgCMatrix roxy [sinew] ---- 
#' @export
# as.tb.dgCMatrix function [sinew] ----
as.tb.dgCMatrix <- function(x,...){
  x <- as.matrix(x)
  x[which(x==0,arr.ind = TRUE)] <- ' '
  as.tb(x)
}

# as.tb.list roxy [sinew] ---- 
#' @export
# as.tb.list function [sinew] ----
as.tb.list <- function(x,...){
  lapply(x,as.tb)
}

# as.tb.data.frame roxy [sinew] ---- 
#' @import dplyr
#' @importFrom tidyr gather
#' @importFrom rlang !! sym
#' @export
# as.tb.data.frame function [sinew] ----
as.tb.data.frame <- function(x){

  ah <- attr(x,'HLINE')
  ac <- attr(x,'CLINE')
  
  suppressWarnings(
  ret <- x%>%
    dplyr::mutate(r=1:n())%>%
    dplyr::mutate_if(is.character, dplyr::coalesce, ... = '')%>%
    tidyr::gather(key='c',value='val',-!!rlang::sym('r'))%>%
    dplyr::mutate_at(dplyr::vars(!!rlang::sym('r'),c),dplyr::funs(as.numeric))%>%
    dplyr::arrange(!!rlang::sym('r'),c)%>%
    dplyr::group_by(!!rlang::sym('r'))%>%
    dplyr::summarise(val=paste0(!!rlang::sym('val'),collapse = '&'))%>%
    dplyr::ungroup()
  )
  
  # attach aes
  
    # multirows
    
      ret <- ret%>%multirow_attach(attr(x,'MULTIROW'))
    
    # multicols
  
      ret <- ret%>%multicol_attach(attr(x,'MULTICOL'))
    
    # hline
    
      if(nrow(ret)==1){
        line_end <- ''
      }else{
        line_end <- '\\\\'
      }
      
      ret <- ret%>%hline_attach(attr(x,'HLINE'),line_end)
    
    # cline
      
      ret <- ret%>%cline_attach(attr(x,'CLINE'),line_end)
  
  # convert dataframe to a string    
      
   ret <- ret%>%
     dplyr::mutate(val = sprintf('%s%s',!!rlang::sym('val'),line_end))%>%
      dplyr::summarise(val=paste0(!!rlang::sym('val'),
                                collapse = '\n'))%>%
      dplyr::pull(!!rlang::sym('val'))
  
   # attach a hline to the top if needed
   
   if(!is.null(ah)){
     
     if(0%in%ah){
       ret <- sprintf(
         fmt = '\\hline\n%s',
         ret
         )
     }
   }
   
   # attach a cline to the top if needed
   
   if(!is.null(ac)){

     ac_idx <- sapply(ac,'[[',1)
     ac_idx0 <- which(ac_idx==0)
     
     if(length(ac_idx0)>0){
       ret <- sprintf(
         fmt = '\\cline{%s-%s}\n%s',
         ac[[ac_idx0]]['i'],ac[[ac_idx0]]['j'],ret
         )
     }
     
   }
   
  as.tb(ret)
}

# as.data.frame.tb roxy [sinew] ---- 
#' @title convert texblock to data.frame
#' @description convert a texblock class into a data.frame
#' @param x texblock object
#' @param \dots pass convert as a boolean argument to apply type.convert to the output columns
#' @return data.frame
#' @examples 
#' x <- '1'
#' class(x) <- 'tb'
#' x1 <- x+x
#' as.data.frame(x1)
#' as.data.frame(x1,convert = TRUE)
#' 
#' @rdname as.data.frame.tb
#' @export 
#' @importFrom purrr map transpose set_names flatten_chr
#' @import dplyr
#' @importFrom utils type.convert
# as.data.frame.tb function [sinew] ----
as.data.frame.tb <- function(x,...){

  convert <- FALSE
  
  list2env(list(...),envir = environment())
  
  attr_env <- new.env()
  
  x <- strip(x,attr_env)
  
  l <- x%>%
    parse_tb()%>%
    purrr::map(function(x) {
      ret <- gsub('^_|_$','',strsplit(x,split = 'NEWCOL')[[1]]) 
      if(length(ret)==0)
        ret <- ''
      
      ret
    })%>%
    purrr::transpose()
  
  ret <- l%>%
    purrr::set_names(seq_along(l))%>%
    dplyr::as_tibble()%>%
    dplyr::mutate_all(purrr::flatten_chr)
  
  if(convert){
    ret <- ret %>%
     dplyr::mutate_all(utils::type.convert)%>%
     dplyr::mutate_if(is.factor,as.character)    
  }

  ret <- ret%>%
    restore(attr_env)
  
  return(ret)
}

# as.matrix.tb roxy [sinew] ---- 
#' @export
# as.matrix.tb function [sinew] ----
as.matrix.tb <- function(x,...){
  ret <- x%>%as.data.frame(convert=TRUE)%>%as.matrix()
  ret[which(is.na(ret),arr.ind = TRUE)] <- 0
  ret
}

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

#' @export
as.tb.tb <- function(x){
  return(x)
}

#' @export
as.tb.matrix <- function(x,...){
  as.tb(as.data.frame(x))
}

#' @export
as.tb.dgCMatrix <- function(x,...){
  x <- as.matrix(x)
  x[which(x==0,arr.ind = TRUE)] <- ' '
  as.tb(x)
}

#' @export
as.tb.list <- function(x,...){
  lapply(x,as.tb)
}

#' @import dplyr
#' @importFrom tidyr gather
#' @importFrom rlang !! sym
#' @export
as.tb.data.frame <- function(x){

  mr <- attr(x,'MULTIROW')
  mc <- attr(x,'MULTICOL')
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
  
  # multirows
  
  if(!is.null(mr)){
    if(nrow(mr)>0){
      for(i in 1:nrow(mr)){
        nr <- as.numeric(mr$row[i])
        ret$val[nr] <- gsub(mr$new_val[i],
                                 mr$old_val[i],
                                 ret$val[nr],
                                 fixed = TRUE)    
      }
    }
  }
  
  
  # multicols

  if(!is.null(mc)){
    if(nrow(mc)>0){
      for(i in 1:nrow(mc)){
        nr <- as.numeric(mc$row[i])
        ret$val[nr] <- gsub(sprintf('%s%s',mc$new_val[i],strrep('& ',mc$ncol[i])),
                                   mc$old_val[1],
                                   ret$val[nr],
                                   fixed = TRUE)
      }
    }
  }
  
  if(nrow(ret)==1){
    line_end <- ''
  }else{
    line_end <- '\\\\'
  }

  ret <- ret%>%
    mutate(line_end=line_end)
  
  if(!is.null(ah)){
    ret$line_end[ah] <- gsub(line_end,
                             '\\\\ \\hline',
                             ret$line_end[ah],
                             fixed = TRUE)
    }
  
  if(!is.null(ac)){
    
    for(i in seq_along(ac)){
      ret$line_end[ac[[i]]['line']] <- gsub(line_end,sprintf('\\\\ \\cline{%s-%s}',
                                                        ac[[i]]['i'],ac[[i]]['j']),
                                       ret$line_end[ac[[i]]['line']],
                                       fixed = TRUE)
    }

  }
  
   #ret$line_end[nrow(ret)] <- gsub('^\\\\\\\\','',ret$line_end[nrow(ret)])
  
   ret <- ret%>%
     dplyr::mutate(val = sprintf('%s%s',!!rlang::sym('val'),line_end))%>%
      dplyr::summarise(val=paste0(!!rlang::sym('val'),
                                collapse = '\n'))%>%
      dplyr::pull(!!rlang::sym('val'))
  
   if(!is.null(ah)){
     if(0%in%ah){
       ret <- sprintf('\\hline\n%s',ret)
     }
   }
   
   if(!is.null(ac)){

     ac_idx <- sapply(ac,'[[',1)
     ac_idx0 <- which(ac_idx==0)
     
     if(length(ac_idx0)>0){
       ret <- sprintf('\\cline{%s-%s}\n%s',ac[[ac_idx0]]['i'],ac[[ac_idx0]]['j'],ret)
     }
   }
   
  as.tb(ret)
}

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
as.data.frame.tb <- function(x,...){

  convert <- FALSE
  
  list2env(list(...),envir = environment())
  
  attr_env <- new.env()
  
  x <- strip(x,attr_env)
  
  l <- x%>%
    parse_tb()%>%
    purrr::map(function(x) gsub('^_|_$','',strsplit(x,split = 'NEWCOL')[[1]]))%>%
    purrr::transpose()
  
  ret <- l%>%
    purrr::set_names(seq_along(l))%>%
    dplyr::as_tibble()%>%
    dplyr::mutate_all(purrr::flatten_chr)#%>%
    #dplyr::mutate_all(.funs = function(x) gsub('^\\s+|\\s+$','',x))
  
  if(convert){
    ret <- ret %>%
     dplyr::mutate_all(utils::type.convert)%>%
     dplyr::mutate_if(is.factor,as.character)    
  }

  
  ret <- ret%>%
    restore(attr_env)
  
  return(ret)
}

parse_tb <- function(x,skip){

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
  
  ret <- strsplit(y,'_NEWROW_')[[1]]
  
  ret
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

#' @export
t.tb <- function (x) {
  x <- as.data.frame(x)
  xt <- as.data.frame(t(x))
  as.tb(xt)
}

#' @export
dim.tb <- function(x){
  dim(as.data.frame(x))
}
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

  l <- x%>%
    parse_tb%>%
    purrr::map(function(x) strsplit(x,split = '_NEWCOL_')[[1]])%>%
    purrr::transpose()
  
  ret <- l%>%
    purrr::set_names(seq_along(l))%>%
    dplyr::as_tibble()%>%
    dplyr::mutate_all(purrr::flatten_chr)%>%
    dplyr::mutate(r=1:n())
  
  return(ret)
}

parse_tb <- function(x){
  
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
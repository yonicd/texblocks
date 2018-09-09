#' @import dplyr
#' @importFrom rlang !! sym
join <- function(e1,e2){

  r <- NULL
  val <- NULL
  
  e1 <- as.data.frame(e1,skip = TRUE)%>%dplyr::mutate(r=1:n())
  e2 <- as.data.frame(e2,skip = TRUE)%>%dplyr::mutate(r=1:n())
  
  e3 <- e1%>%
    dplyr::full_join(e2,by='r')%>%
    dplyr::select(-!!rlang::sym('r'))
  
  names(e3) <- 1:ncol(e3)
  
  as.tb(e3)
    
}


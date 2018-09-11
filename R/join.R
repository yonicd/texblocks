#' @import dplyr
#' @importFrom rlang !! sym
join <- function(e1,e2){

  r <- NULL
  val <- NULL
  
  e1 <- as.data.frame(e1)
  e2 <- as.data.frame(e2)
  
  e1$r <- 1:nrow(e1)
  e2$r <- 1:nrow(e2)
  
  e3 <- e1%>%
    dplyr::full_join(e2,by='r')%>%
    dplyr::select(-!!rlang::sym('r'))
  
  names(e3) <- 1:ncol(e3)
  
  attr(e3,'MULTIROW') <- list(e1,e2)%>%purrr::map_df(attr,"MULTIROW")
  attr(e3,'MULTICOL') <- list(e1,e2)%>%purrr::map_df(attr,"MULTICOL")
  
  as.tb(e3)
    
}


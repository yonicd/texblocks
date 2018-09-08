#' @import dplyr
#' @importFrom tidyr gather
#' @importFrom rlang !! sym
join <- function(e1,e2){

  r <- NULL
  val <- NULL
  
  e1 <- as.data.frame(e1)
  e2 <- as.data.frame(e2)
  
  LINES <- lapply(list(e1,e2),attr,which = 'line')
  
  e3 <- e1%>%
    dplyr::full_join(e2,by='r')%>%
    dplyr::select(-!!rlang::sym('r'))
  
  names(e3) <- 1:ncol(e3)
  
  e3%>%
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
}
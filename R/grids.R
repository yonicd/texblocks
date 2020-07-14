#'@export
hbox <- function(x){
  x%>%hline(c(0,nrow(.)))
}

#'@export
hbox2 <- function(x){
  x%>%hline(c(0,1,nrow(.)))
}

#'@export
hgrid <- function(x){
  x%>%hline()
}

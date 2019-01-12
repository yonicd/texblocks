hbox <- function(x){
  x%>%hline(c(0,nrow(.)))
}

hbox2 <- function(x){
  x%>%hline(c(0,1,nrow(.)))
}

hgrid <- function(x){
  x%>%hline()
}

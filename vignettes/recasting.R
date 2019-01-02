## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(texblocks)
library(texPreview)

## ----include=FALSE-------------------------------------------------------
tex_opts$set(returnType = 'html')
tex_opts$append(list(cleanup='tex'))

## ----remedy001-----------------------------------------------------------

x <- '\\begin{tabular}{l|cccccccccc}
number of flips& 11 & 12 & 13 & 14 & 15 & 16 & 17 & 18 & 19 & 20 \\\\
number of heads& 8  &  8 &  9 & 10 & 10 & 10 & 10 & 10 & 10 & 11 \\\\\\hline
proportion& .73 & .67 & .69 & .71 & .67 &  .63 & .59 & .56 & .53 & .55
\\end{tabular}'


## ----remedy002-----------------------------------------------------------

x <- 'number of flips& 11 & 12 & 13 & 14 & 15 & 16 & 17 & 18 & 19 & 20 \\\\
number of heads& 8  &  8 &  9 & 10 & 10 & 10 & 10 & 10 & 10 & 11 \\\\\\hline
proportion& .73 & .67 & .69 & .71 & .67 &  .63 & .59 & .56 & .53 & .55'


## ------------------------------------------------------------------------
x <- x%>%as.tb()

## ----remedy003-----------------------------------------------------------

x%>%
  as.data.frame()


## ----remedy004-----------------------------------------------------------

x%>%
  as.data.frame(convert = TRUE)


## ----remedy005-----------------------------------------------------------

x%>%
  as.data.frame(convert = TRUE)%>%
  tidyr::gather(col,val,-1)


## ----remedy006-----------------------------------------------------------

x%>%
  t()%>%
  as.data.frame()


## ----remedy007-----------------------------------------------------------

x%>%
  t()%>%
  hline()%>%
  tabular(align = '|c|c|c|')%>%
  texPreview::tex_preview()


## ----remedy008-----------------------------------------------------------

mat <- Matrix::bdiag(
  Matrix::Diagonal(2), 
  matrix(1:3, 3,4), 
  diag(3:2)
)

mat

## ----remedy009-----------------------------------------------------------

x <- mat %>% as.tb()

x


## ----remedy010-----------------------------------------------------------

x%>%crop(1:2,1:2) # extract smaller tb from rows 1:2 columns 1:2
x%>%crop(3:5,3:6) # extract smaller tb from rows 3:5 columns 3:6
x%>%crop(6:7,7:8) # extract smaller tb from rows 6:7 columns 7:8


## ----remedy011-----------------------------------------------------------

x1 <- x%>%
  harvest(
    list(1:2,3:5,6:7),
    list(1:2,3:6,7:8)
  )

x1



## ----remedy012-----------------------------------------------------------

x1%>%
  purrr::map(as.matrix)%>% #convert back to list of matrices
  Matrix::bdiag() # convert back to original block matrix



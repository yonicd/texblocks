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

## ------------------------------------------------------------------------
as.tb('$\\alpha$')
as.tb('aaa')

## ------------------------------------------------------------------------
rep(as.tb('$\\alpha$'),3)


## ------------------------------------------------------------------------
lapply(1:3,as.tb)


## ------------------------------------------------------------------------
iris%>%
  head(5)%>%
  as.tb()


## ----dataframe,echo=FALSE------------------------------------------------
iris%>%
  head(5)%>%
  as.tb()%>%
  tabular()%>%
  texPreview::tex_preview()

## ------------------------------------------------------------------------
matrix(0,3,3)%>%
  as.tb()


## ----matrix, echo=FALSE--------------------------------------------------
matrix(0,3,3)%>%
  as.tb()%>%
  tabular()%>%
  texPreview::tex_preview()


## ------------------------------------------------------------------------
Matrix::bdiag(Matrix::Diagonal(2), matrix(1:3, 3,4), diag(3:2))%>%
  as.tb()


## ----smatrix, echo=FALSE-------------------------------------------------
Matrix::bdiag(Matrix::Diagonal(2), matrix(1:3, 3,4), diag(3:2))%>%
  as.tb()%>%
  tabular()%>%
  texPreview::tex_preview()


## ------------------------------------------------------------------------
matrix(1:9,3,3)%>%
  as.tb()%>%
  as.data.frame()

## ------------------------------------------------------------------------
x <- as.tb('$\\alpha$')
y <- as.tb('aaa')
z <- as.tb('$\\beta$')

x1 <- x+y+z

## ----horizontal, echo=FALSE----------------------------------------------
x1%>%
  tabular()%>%
  texPreview::tex_preview()

## ------------------------------------------------------------------------
x/y/z

## ----vertical, echo=FALSE------------------------------------------------
(x/y/z)%>%
  tabular()%>%
  texPreview::tex_preview()

## ------------------------------------------------------------------------
x2 <- x1 / x1 # 2x3 object
x2 + x2

## ----vertical2, echo=FALSE-----------------------------------------------
(x2 + x2)%>%
  tabular()%>%
  texPreview::tex_preview()

## ------------------------------------------------------------------------
x3 <- x2/x2 # 4x3 object

# 4x6 object with empty block in the lower right hand side of the table
x2 + x3

## ----unequal, echo=FALSE-------------------------------------------------
(x2 + x3)%>%
  tabular()%>%
  texPreview::tex_preview()

## ----tabular-------------------------------------------------------------
# default alignment
x1%>%
  texblocks::tabular()%>%
  texPreview::tex_preview()


## ----unequaltabular------------------------------------------------------
# manual alignment
x1%>%
  texblocks::tabular(align = '|cc|c')%>%
  texPreview::tex_preview()


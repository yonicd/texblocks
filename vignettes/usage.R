## ----setup, include = FALSE----------------------------------------------

knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE,
  message = FALSE,
  fig.path = '.'
)

## ------------------------------------------------------------------------
library(texblocks)
library(texPreview)


## ----include=FALSE-------------------------------------------------------
tex_opts$set(returnType= 'html',
             resizebox = FALSE,
             fileDir = '.',
             opts.html = list(width='50%',height='50%'))

tex_opts$append(list(cleanup='tex'))

## ------------------------------------------------------------------------
x <- '$\\alpha$'
y <- 'cindy'
class(x) <- 'tb'
class(y) <- 'tb'

## ------------------------------------------------------------------------
x1 <- x+y+x
x1

## ------------------------------------------------------------------------
x1 + x1
x1 / x1
x1 - x1

## ------------------------------------------------------------------------
x2 <- x1 / x1
x2 + x2

## ------------------------------------------------------------------------
x3 <- x2/x2
x2 + x3

## ------------------------------------------------------------------------
as.data.frame( x2 + x3 )

## ------------------------------------------------------------------------
texblocks::tabular( x2 + x3,align = 'c|c|c|c|c|c')

## ---- echo=TRUE,results='asis'-------------------------------------------
texPreview::texPreview(tabular(x1 ,'c|c|c'),stem = "tb1")


## ---- echo=TRUE,results='asis'-------------------------------------------
texPreview::texPreview(tabular(x2 ,'c|c|c'),stem = "tb2")


## ---- echo=TRUE,results='asis'-------------------------------------------
texPreview::texPreview(tabular(x3 ,'c|c|c'),stem = "tb3")


## ---- echo=TRUE,results='asis'-------------------------------------------
texPreview::texPreview(tabular(x2-x2 ,'c|c|c'),stem = "tb4")


## ---- echo=TRUE,results='asis'-------------------------------------------
texPreview::texPreview(tabular(x2 + x3 ,'c|c|c|c|c|c'),stem = "tb5")


## ---- echo=TRUE,results='asis'-------------------------------------------
texPreview::texPreview(tabular(x3 + x3,'c|c|c|c|c|c'),stem = "tb6")


## ---- echo=TRUE,results='asis'-------------------------------------------
texPreview::texPreview(tabular((x1+x1)-(x3 + x3)/(x3 + x3) ,'|c|ccccc'),stem = "tb7")


## ----include=FALSE-------------------------------------------------------
pngs <- list.files(pattern = 'png$')
invisible(
  sapply(list.files(pattern = 'png$',full.names = TRUE),function(x){
    fp <- file.path('../inst/doc',basename(x))
    fd <- file.path('../docs/articles/',basename(x))
    file.copy(x,to = fp,overwrite = file.exists(fp))
    file.copy(x,to = fd,overwrite = file.exists(fd))
  })
)


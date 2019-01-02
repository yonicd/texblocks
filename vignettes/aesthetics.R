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
x <- as.tb('$\\alpha$')
y <- as.tb('aaa')
z <- as.tb('bbb')

## ------------------------------------------------------------------------
x1 <- x + y + z
x2 <- x1 / x1 # 2x3 object
x3 <- x2 / x2 # 4x3 object

k1 <- lapply(1:3,as.tb)
k2 <- lapply(4:6,as.tb)

k <- purrr::reduce(k1,`+`) / purrr::reduce(k2,`+`)

title <- c('param',sprintf('col%s',1:5))%>%
  purrr::map(as.tb)%>%
  purrr::reduce(`+`)


## ----hline---------------------------------------------------------------
(title / (x2 + x3))%>%
  hline()%>%
  tabular()%>%
  texPreview::tex_preview()


## ----hline2--------------------------------------------------------------
(title / (x2 + x3))%>%
  hline(lines = c(2,3))%>%
  tabular()%>%
  texPreview::tex_preview()


## ------------------------------------------------------------------------
l <- list(c(line=1,i=2,j=3),c(line=2,i=1,j=2),c(line=3,i=2,j=3))
d <- data.frame(line=1:3,i=c(1,2,3),j=c(1,2,3))

## ----cline---------------------------------------------------------------
purrr::reduce(rep(x1,4),`/`)%>%
  cline(l)%>%
  tabular()%>%
  texPreview::tex_preview()

purrr::reduce(rep(x1,4),`/`)%>%
  cline(d)%>%
  tabular()%>%
  texPreview::tex_preview()


## ----lines_pipe----------------------------------------------------------
purrr::reduce(rep(x1,4),`/`)%>%
  hline(c(0,4))%>%
  cline(d)%>%
  tabular()%>%
  texPreview::tex_preview()

## ----multirow,echo=TRUE,results='asis'-----------------------------------
title <- as.tb('param') + multicol('vals',3,'c')

(title / (multirow('$\\beta$',2) + k))%>%
  tabular()%>%
  texPreview::tex_preview()



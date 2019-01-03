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

  tbl_col_header <- c('Run','Estimation',sprintf('$\\eta_%s$',1:4))%>%
      tb_reduce(margin = 2)


## ----remedy002-----------------------------------------------------------

  tbl_rows_inner <- c(1:4,1)%>%
    tb_reduce(margin = 1)
  
  tbl_row_outer <- c(rep(510,4),511)%>%
    tb_reduce(margin = 1,merge = TRUE)

  tbl_row_header <- tbl_row_outer + tbl_rows_inner


## ----remedy003-----------------------------------------------------------

set.seed(123)

vals <- rnorm(12)%>%
  split(c(1,1,2,2,3,3,4,4,5,5,5,5))

tbl_body <- vals%>%purrr::map(.f=function(x){
    round(x,3)%>%t()
  })%>%
    tb_reduce(margin = 1)

## ----remedy004-----------------------------------------------------------
tbl <- (tbl_col_header / (tbl_row_header + tbl_body))

## ----remedy005-----------------------------------------------------------

tbl%>%
  hline(c(0,1,1,nrow(.)))%>%
  texblocks::tabular(align = '|cc|cccc|')%>%
  texPreview::tex_preview()


## ----remedy006-----------------------------------------------------------

tbl%>%
  t()%>% # <------
  hline(c(0,2,2,nrow(.)))%>%
  texblocks::tabular(align = '|c|ccccc|')%>%
  texPreview::tex_preview()


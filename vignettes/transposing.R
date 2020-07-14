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

tbl_col_header <- c('Run','Estimation',sprintf('$\\eta_%s$',1:4))%>%t()%>%as.tb()


## ----remedy002-----------------------------------------------------------

  tbl_rows_inner <- c(1:4,1)%>%as.tb()
  
  tbl_row_outer <- list(rep(510,4),511)%>%
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
  tabular()%>%
  texPreview::tex_preview()


## ----remedy006-----------------------------------------------------------

tbl%>%
  t()%>%
  tabular()%>%
  texPreview::tex_preview()

## ------------------------------------------------------------------------
dat <- dplyr::tibble(
  Study    = c(1,1,1,1),
  Variable = c('Age','Age','Sex','Sex'),
  Category = c('$>=$ med','$<$ med','Male','Female'),
  Value    = c(300,300,345,255) 
)

header <- names(dat)%>%t()%>%as.tb()

a1 <- dat$Study%>%tb_reduce(merge = TRUE)
a2 <- dat$Variable%>%tb_reduce(merge = TRUE)

a <- a1 + a2

b <- dat[,-c(1,2)]%>%as.tb()

tab <- header/((a1 + a2) + b)

## ------------------------------------------------------------------------
tab%>%
  tabular()%>%
  texPreview::tex_preview()

## ------------------------------------------------------------------------
tab%>%
  t()%>%
  tabular()%>%
  texPreview::tex_preview()


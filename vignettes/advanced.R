## ----setup, include = FALSE----------------------------------------------

dir.create('figures')

knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = 'figures'
)

## ------------------------------------------------------------------------
library(texblocks)
library(texPreview)


## ----include=FALSE-------------------------------------------------------
tex_opts$set(fileDir = 'figures',returnType = 'html',
             opts.html=list(width='25%',height='25%'))
tex_opts$append(list(cleanup='tex'))

## ------------------------------------------------------------------------
k1 <- lapply(1:3,as.tb)
k2 <- lapply(4:6,as.tb)

k <- purrr::reduce(k1,`+`) / purrr::reduce(k2,`+`)

title <- c('param',sprintf('col%s',1:5))%>%
  purrr::map(as.tb)%>%
  purrr::reduce(`+`)


## ----echo=TRUE,results='asis'--------------------------------------------
title <- as.tb('param') + multicol('vals',3,'c|')

tab <- title / (multirow('$\\beta$',2) + k )

tab%>%
  hline(c(0,3))%>%
  cline(data.frame(line=1,i=2,j=4))%>%
  tabular(align = '|c|ccc|')%>%
  texPreview::texPreview(stem = 'adv-01')

title <- as.tb('param') + multicol('vals',3,'c')
tab <- purrr::map(1:4,function(x) multirow(sprintf('$\\beta_%s$',x),2) + k )

(title / purrr::reduce(tab,`/`))%>%
  tabular()%>%
  texPreview::texPreview(stem = 'adv-02')


## ----include=FALSE-------------------------------------------------------
if(knitr::opts_knit$get('rmarkdown.pandoc.to')=='html'){
file.copy('figures','../docs/articles',recursive=TRUE)
}


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
k1 <- 1:3%>%as.tb()%>%t()
k2 <- 4:6%>%as.tb()%>%t()

k <- k1 / k2

## ----adv1----------------------------------------------------------------
title <- as.tb('param') + multicol('vals',3,'c|')

tab <- title / (multirow('$\\beta$',2) + k )

tab%>%
  hline(c(0,3))%>%
  cline(data.frame(line=1,i=2,j=4))%>%
  tabular(align = '|c|ccc|')%>%
  texPreview::tex_preview()


## ----adv2----------------------------------------------------------------
title <- as.tb('param') + multicol('vals',3,'c|')

tab <- list(rep(k1,3)%>%tb_reduce(),k2)

tab <- purrr::map2(1:2,tab,function(x,y){
 multirow(sprintf('$\\beta_%s$',x),nrow(y)) + y 
})%>%tb_reduce()

(title / tab)%>%
  hline(c(0,1,nrow(.)))%>%
  tabular(align='|c|ccc|')%>%
  texPreview::tex_preview()



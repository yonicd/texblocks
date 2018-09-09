#' @title TeX tabular object 
#' @description Wrap tabular syntax around a texblock object
#' @param x texblock object
#' @param align character, tabular alignment, Default: NULL
#' @return texblock object
#' @rdname tabular
#' @export 
tabular <- function(x,align = NULL){
  
  ncol <- sapply(gsub('[^&]','',strsplit(x,'\n')[[1]]),nchar)
  
  uncol <- max(ncol) + 1
  
  if(length(uncol)>1)
    stop('unequal number of columns in table')
  
  if(is.null(align)){
    align <- strrep('c',uncol)
  }else{
    nchar_align <- nchar(gsub('[|]','',align))
    if(nchar_align!=uncol)
      stop(sprintf('align has wroing number of columns: actual (%s) supplied (%s)',
                   uncol,nchar_align)
           )
  }
  
  ret <- sprintf('\\begin{tabular}{%s}\n%s\n\\end{tabular}',align,x)
  class(ret) <- 'tb'
  ret
}
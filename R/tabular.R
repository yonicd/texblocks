#' @title TeX tabular object 
#' @description Wrap tabular syntax around a texblock object
#' @param x texblock object
#' @param align character, tabular alignment, Default: NULL
#' @return texblock object
#' @rdname tabular
#' @export 
tabular <- function(x,align = NULL){
  
  nc <- ncol(x)
  
  if(is.null(align)){
    align <- strrep('c',nc)
  }else{
    nchar_align <- nchar(gsub('[|]','',align))
    if(nchar_align!=nc)
      stop(sprintf('align has wrong number of columns: actual (%s) supplied (%s)',
                   nc,nchar_align)
           )
  }

  as.tb(sprintf('\\begin{tabular}{%s}\n%s\n\\end{tabular}',align,x))

}

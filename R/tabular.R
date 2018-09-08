#' @title TeX tabular object 
#' @description Wrap tabular syntax around a texblock object
#' @param x texblock object
#' @param align character, tabular alignment
#' @return texblock object
#' @rdname tabular
#' @export 
tabular <- function(x,align){
  ret <- sprintf('\\begin{tabular}{%s}\n%s\n\\end{tabular}',align,x)
  class(ret) <- 'tb'
  ret
}
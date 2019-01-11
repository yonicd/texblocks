# parse_tb function [sinew] ---- 
parse_tb <- function(x,skip){
  
  y <- gsub('&',
            '_NEWCOL_',
            gsub('\\n',
                 '',
                 gsub(tex_line,
                      '_NEWROW_',
                      x,
                      fixed=TRUE)
            )
  )
  
  ret <- strsplit(y,'_NEWROW_')[[1]]
  
  ret
}
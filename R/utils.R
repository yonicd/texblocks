strip_attr <- function(x,.f,env){
  
  if(is.null(get(toupper(.f),envir = env)))
    return(x)
  
  .fn <- get(sprintf('strip_%s',.f),envir = asNamespace('texblocks')) 
  .fn(x)
}

find_attr  <- function(x,.f,env = NULL){
  .fn <- get(sprintf('find_%s',.f),envir = asNamespace('texblocks'))
  if(!is.null(env))
    assign(toupper(.f),.fn(x),envir = env)
}

strip <- function(x,env){
  
  find_attr(x,'hline',env)
  find_attr(x,'cline',env)
  
  x <- strip_attr(x,'hline',env)
  x <- strip_attr(x,'cline',env)
  
  find_attr(x,'multicol',env)
  find_attr(x,'multirow',env)
  
  x <- strip_attr(x,'multicol',env)
  x <- strip_attr(x,'multirow',env)
  
  x
}

restore <- function(x,env){
  
  l <-   as.list(env)%>%
    purrr::discard(is.null)
  
  if(length(l)>0){
    
    for(nm in names(l)){
      attr(x,nm) <- l[[nm]]
    }
    
  }
  x
}
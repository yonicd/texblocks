expect_class <- function(obj,cl){
  testthat::expect_true(inherits(obj,cl)) 
}
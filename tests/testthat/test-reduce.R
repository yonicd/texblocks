testthat::context('reduce')

x <- as.list(rep(1,3))
y <- as.list(rep(2,3))

testthat::describe('rowwise',{

  xt <- x%>%tb_reduce()
  
  it('class',expect_class(xt,'tb'))
  it('dim',testthat::expect_equal(dim(xt),c(3,1)))
    
})

testthat::describe('rowwise merge',{
  
  xt <- x%>%tb_reduce(merge = TRUE)
  
  it('class',expect_class(xt,'tb'))
  it('dim',testthat::expect_equal(dim(xt),c(3,1)))
  it('merged',testthat::expect_equal(xt%>%find_multirow()%>%dplyr::pull(row),1))
  
})

testthat::describe('colwise',{
  
  xt <- x%>%tb_reduce(margin = 2)
  
  it('class',expect_class(xt,'tb'))
  it('dim',testthat::expect_equal(dim(xt),c(1,3)))
  
})

testthat::describe('colwise merge',{
  
  xt <- x%>%tb_reduce(merge = TRUE,margin = 2)
  
  it('class',expect_class(xt,'tb'))
  it('dim',testthat::expect_equal(dim(xt),c(1,3)))
  it('merged',testthat::expect_equal(xt%>%find_multicol()%>%dplyr::pull(col),1))
  
})

x <- as.list(c(0,rep(1,3)))

testthat::describe('mix',{
  
  xt <- x%>%tb_reduce(merge = TRUE)
  
  it('class',expect_class(xt,'tb'))
  it('dim',testthat::expect_equal(dim(xt),c(4,1)))
  it('merged',testthat::expect_equal(xt%>%find_multirow()%>%dplyr::pull(row),2))
  
})
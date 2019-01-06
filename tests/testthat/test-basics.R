testthat::context('basics')

testthat::describe('as.tb',{
  
  it('as.tb',{
    expect_class(as.tb('a'),'tb')
  })
  
  it('as.tb.tb',{
    expect_class(as.tb(as.tb('a')),'tb')
  })
  
  it('as.matrix.tb',{
    expect_class(as.tb(matrix(c(1,1,1,1))),'tb')
  })
  
  it('as.data.frame.tb',{
    expect_class(as.tb(iris),'tb')
  })

})

testthat::describe('from tb',{
  
  it('as.matrix',{
    
    x <- as.matrix(c(1,1,1,1))
    
    testthat::expect_equal(c(1,1,1,1)%>%as.tb()%>%as.matrix(),x)
    
  })
  
  it('as.data.frame',{
    
    x <- data.frame(x = c(1L,1L,1L,1L))
    x2 <- c(1,1,1,1)%>%as.tb()%>%as.data.frame(convert = TRUE)
    names(x2) <- 'x'
    testthat::expect_equal(x2,x)
    
  })
  
})
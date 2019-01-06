testthat::context('basics')

testthat::describe('as.tb',{
  
  it('as.tb',{
    expect_class(as.tb('a'),'tb')
  })
  
  it('as.tb.tb',{
    expect_class(as.tb(as.tb('a')),'tb')
  })
  
  it('as.integer.tb',{
    expect_class(as.tb(1L),'tb')
  })
  
  it('as.matrix.tb',{
    expect_class(as.tb(matrix(c(1,1,1,1))),'tb')
  })
  
  it('as.data.frame.tb',{
    expect_class(as.tb(iris),'tb')
  })

  it('bdiag',{
    mat <- Matrix::bdiag(
      Matrix::Diagonal(2), 
      matrix(1:3, 3,4), 
      diag(3:2)
    )
    
    expect_class(mat%>%as.tb,'tb')
  })
  
  it('list',{
    x <- rep(1,4)%>%as.list()%>%as.tb()
    expect_class(x,'list')
    testthat::expect_true(sapply(x,inherits,what = 'tb')%>%all)
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
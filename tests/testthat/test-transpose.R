testthat::context('transpose')

testthat::describe('vector',{
  
  it('row to col',{
    testthat::expect_equal(
      rep(1,4)%>%as.tb()%>%t(),
      rep(1,4)%>%t()%>%as.tb()
    )
  })
  
  it('multicol to multirow',{

      x <- multicol('vals',3,'c')
      xx <- x/x
      xxt <- xx%>%t()
      fx <- find_multirow(xxt)
      testthat::expect_equal(fx$col,c('1','2'))
      
  })
     
  it('multirow to multicol',{
    
    x <- matrix(1:9,ncol=3)%>%as.tb()
    xx <- multirow('val',3) + x
    xxt <- xx%>%t()
    fx <- find_multicol(xxt)
    testthat::expect_equal(fx$row,'1')
    
  })
})
testthat::context('transpose')

testthat::describe('vector',{
  
  it('row to col',{
    testthat::expect_equal(
      rep(1,4)%>%as.tb()%>%t(),
      rep(1,4)%>%t()%>%as.tb()
    )
  })
     
})
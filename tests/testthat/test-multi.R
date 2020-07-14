testthat::context('multi')

testthat::describe('multirow',{
  it('default',{
    testthat::expect_true(grepl('\\\\multirow\\{1\\}\\{\\*\\}\\{1\\}',multirow(1,1)))
  })
  
  it('strip',{
    testthat::expect_equal(multirow(1,1)%>%strip_multirow()%>%as.character(),'1')
  })
  
  it('find',{
    expect_class(multirow(1,1)%>%find_multirow(),'data.frame')
  })
  
  it('transpose',{
    testthat::expect_true(grepl('\\\\multicolumn\\{1\\}\\{c\\}\\{1\\}',multirow(1,1)%>%t()))
  })
})

testthat::describe('multicol',{
  it('default',{
    testthat::expect_true(grepl('\\\\multicolumn\\{1\\}\\{c\\}\\{1\\}',multicol(1,1)))
  })
  
  it('strip',{
    testthat::expect_equal(multicol(1,1)%>%strip_multicol()%>%as.character(),'1')
  })
  
  it('find',{
    expect_class(multicol(1,1)%>%find_multicol(),'data.frame')
  })
  
  it('transpose',{
    testthat::expect_true(grepl('\\\\multirow\\{1\\}\\{\\*\\}\\{1\\}',multicol(1,1)%>%t()))
  })
})

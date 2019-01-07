testthat::context('lines')

a <- as.tb(1)
a2 <- as.tb(c(1,2))

testthat::describe('hline',{
  it('default',{
    hx <- a2%>%hline()
    testthat::expect_true(grepl('^\\\\hline|\\\\hline$',hx))
  })
  
  it('top row',{
    hx <- a2%>%hline(0)
    testthat::expect_true(grepl('^\\\\hline',hx))
    testthat::expect_true(find_hline(hx)==0)
  })
  
  it('first row',{
    hx <- a%>%hline(1)
    
    testthat::expect_true(grepl('\\hline$',hx))
    testthat::expect_true(find_hline(hx)==1)
  })

  it('not 0 not 1',{
    hx <- a2%>%hline(2)
    testthat::expect_true(all(find_hline(hx)==1))
  })
    
  it('multirow',{
    hx <- a2%>%hline()
    testthat::expect_true(all(find_hline(hx)==c(0,1,2)))
  })
  
  it('strip',{
    hx <- a%>%hline(1)%>%strip_hline()
    
    testthat::expect_true(grepl('^1 \\\\',hx))
  })
})

l0 <- list(c(line=0,i=2,j=3))
d0 <- data.frame(line=0,i=c(2),j=c(3))
d1 <- data.frame(line=1:2,i=c(2,1),j=c(3,2))
d2 <- data.frame(line=2,i=c(1),j=c(2))


testthat::describe('cline',{
  it('top row list',{
    cx <- a%>%cline(specs = l0)
    testthat::expect_true(grepl('^\\\\cline',cx))
    
    fcx <- find_cline(cx)
    
    expect_class(fcx,'list')
    expect_class(fcx[[1]],'numeric')
    testthat::expect_named(fcx)
    
  })
  
  it('top row data.frame',{
    cx <- a2%>%cline(specs = d0)
    testthat::expect_true(grepl('^\\\\cline',cx))
  })
  
  it('not top row data.frame',{
    cx <- a2%>%cline(specs = d2)
    testthat::expect_true(grepl('\\cline\\{1-2\\}$',cx))
    testthat::expect_true(find_cline(cx)[[1]][[1]]==1)
  })
  
  it('strip',{
    cx <- a2%>%cline(d1)%>%strip_cline()
    
    testthat::expect_true(grepl('^1\\\\',cx))
  })
})
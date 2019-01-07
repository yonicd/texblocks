testthat::context('pad')

a <- as.tb('a')

testthat::describe('columns',{
  
  
  it('class',{
    expect_class(a%>%pad_col(),'tb')
  })

  it('bad side',{
    testthat::expect_error(a%>%pad_col(side = 'a'),regexp = '^side must be')
  })
  
  it('left 0',{
    testthat::expect_true(grepl('^a$',a%>%pad_col(cols = 0)))
  })
    
  it('left 1',{
    testthat::expect_true(grepl('^&a$',a%>%pad_col()))
  })
  
  it('left 2',{
    testthat::expect_true(grepl('^&&a$',a%>%pad_col(cols = 2)))
  })
  
  it('right 0',{
    testthat::expect_true(grepl('^a$',a%>%pad_col(cols = 0, side = 'r')))
  })
  
  it('right 1',{
    testthat::expect_true(grepl('^a&$',a%>%pad_col(side = 'r')))
  })
  
  it('right 2',{
    testthat::expect_true(grepl('^a&&$',a%>%pad_col(cols = 2, side = 'r')))
  })
  
})

testthat::describe('rows',{
  
  
  it('class',{
    expect_class(a%>%pad_row(),'tb')
  })
  
  it('bad side',{
    testthat::expect_error(a%>%pad_row(side = 'a'),regexp = '^side must be')
  })
  
  it('bottom 0',{
    testthat::expect_equal(gregexpr(pattern = '\\\\\n',text = a%>%pad_row(rows = 0)%>%as.character(),fixed=TRUE)[[1]]%>%as.numeric(),-1)
  })
  
  it('bottom 1',{
    testthat::expect_equal(gregexpr(pattern = '\\\\\n',text = a%>%pad_row(rows = 1)%>%as.character(),fixed=TRUE)[[1]]%>%as.numeric(),2)
  })
  
  it('bottom 2',{
    testthat::expect_equal(gregexpr(pattern = '\\\\\n',text = a%>%pad_row(rows = 2)%>%as.character(),fixed=TRUE)[[1]]%>%as.numeric(),c(2,5))
  })
  
  it('top 0',{
    testthat::expect_equal(gregexpr(pattern = '\\\\\n',text = a%>%pad_row(rows = 0,side = 't')%>%as.character(),fixed=TRUE)[[1]]%>%as.numeric(),-1)
  })
  
  it('top 1',{
    testthat::expect_equal(gregexpr(pattern = '\\\\\n',text = a%>%pad_row(rows = 1,side = 't')%>%as.character(),fixed=TRUE)[[1]]%>%as.numeric(),1)
  })
  
  it('top 2',{
    testthat::expect_equal(gregexpr(pattern = '\\\\\n',text = a%>%pad_row(rows = 2,side = 't')%>%as.character(),fixed=TRUE)[[1]]%>%as.numeric(),c(1,4))
  })
  
})

testthat::describe('wrapper',{
  x <- a%>%pad(times = 2,sides = 'tr')
  
  it('bad side',{
    testthat::expect_error(a%>%pad(times = 2,sides = 'a'),regexp = '^sides must be')
  })
  
  it('bad length',{
    testthat::expect_error(a%>%pad(times = c(2,3,3),sides = 'tb'),regexp = '^length of')
  })
  
  it('rows',{
    testthat::expect_equal(gregexpr(pattern = '\\\\\n',text = x%>%as.character(),fixed=TRUE)[[1]]%>%as.numeric(),c(3,8))
    })
  
  it('cols',{
  testthat::expect_equal(gregexpr(pattern = '&',text = x%>%as.character(),fixed=TRUE)[[1]]%>%as.numeric(),c(1,2,6,7,12,13))
  })
  
})
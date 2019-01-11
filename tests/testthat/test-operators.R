testthat::context('operators')

testthat::describe('no pad',{
  it('+',{
    x <- as.tb('a') + as.tb('b')
    expect_class(x,'tb')
  })
  
  it('/',{
    x <- as.tb('a') / as.tb('b')
    expect_class(x,'tb')
  })
})
  
testthat::describe('pad',{
    it('+',{
      x <- (as.tb('a') + as.tb('b')) / as.tb('c')
      expect_class(x,'tb')
    })
    
    it('/',{
      x <- as.tb('a') / (as.tb('b') + as.tb('c'))
      expect_class(x,'tb')
    })
})
testthat::context('methods')

x <- as.tb(c(1,2))
xx <- x+x

testthat::describe('print',{
  expect_output(print(x),"1\\\\\\\\\\n2\\\\\\\\")
})

testthat::describe('is.tb',{
  expect_true(is.tb(x))
  expect_false(is.tb(c(1,2)))
})

testthat::describe('rep',{
  expect_class(rep(x,2),'list')
  expect_true(sapply(rep(x,2),inherits,what = 'tb')%>%all())
})

testthat::describe('crop',{
  expect_class(x%>%crop(1,1),'tb')
  expect_equal(xx%>%crop(1:2,1),as.tb(c(1,2)))
  expect_equal(xx%>%crop(1,1:2),as.tb(c(1,1))%>%t())
})

testthat::describe('harvest',{
  expect_class(xx%>%harvest(list(1,2),list(1,2)),'list')
  expect_equal(xx%>%harvest(list(1,2),list(1,2)),lapply(c(1,2),as.tb))
})

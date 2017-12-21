context("Test get_senseBox_stats()")

test_that("Check output length and class", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  temp <-  get_senseBox_stats()

  expect_equal(class(temp), "data.frame")
  expect_equal(dim(temp), c(3,2))

})

context("Test get_senseBox_Ids()")

test_that("Check output length and class", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  temp <-  get_senseBox_Ids()

  expect_equal(class(temp), "data.frame")
  expect_equal(names(temp), c("senseBoxId", "name"))

  ## check httr::progress option
  get_senseBox_Ids(progress = TRUE)

})

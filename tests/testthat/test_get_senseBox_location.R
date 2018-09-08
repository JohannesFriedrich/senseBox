context("Test get_senseBox_location()")

test_that("Check output length and class", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  Id <- "593acaa66ccf3b00116deb0f"

  temp <- get_senseBox_location(Id)

  expect_equal(class(temp), "data.frame")
  expect_equal(dim(temp), c(1,3))

})

test_that("Check error handling", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  Id <- "593acaa66ccf3b00116deb0f"

  expect_error(get_senseBox_location())
  expect_error(get_senseBox_location(1))
  expect_error(get_senseBox_location(Id, 1))

})

context("Test get_senseBox_info()")

test_that("Check output length and class", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  Id <- "5957b67494f0520011304cc1"

  temp <- get_senseBox_info(Id, tidy = TRUE)
  temp <- get_senseBox_info(Id)

  expect_equal(class(temp), "data.frame")
  expect_equal(nrow(temp), 1)

})

test_that("Check error handling", {
  #testthat::skip_on_cran()
  # testthat::skip_on_travis()

  expect_error(get_senseBox_info())
  expect_error(get_senseBox_info(1))
  expect_error(get_senseBox_info("593acaa66ccf3b00116deb0f", tidy = "1"))
  expect_error(get_senseBox_info("593acaa66ccf3b00116deb0f", parallel = "1"))

})

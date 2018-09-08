context("Test get_senseBox_sensor_archive()")

test_that("Check output length and class", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  Id <- "5957b67494f0520011304cc1"

  temp <- get_senseBox_archive(Id)
  temp <- get_senseBox_archive(Id, date = "2018-08-31")

  expect_equal(class(temp), "response")

})

test_that("Check error handling", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  expect_error(get_senseBox_archive())
  expect_error(get_senseBox_archive(1))
  expect_error(get_senseBox_archive("593acaa66ccf3b00116deb0f", "2018-09-07"))

})

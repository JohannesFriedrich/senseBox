context("Test get_senseBox_sensor_archive()")

test_that("Check output length and class", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  df <- get_senseBox_archive("5957b67494f0520011304cc1", "2020-01-01")
  expect_s3_class(df, "data.frame")


})

test_that("Check error handling", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  expect_warning(get_senseBox_archive("5957b67494f0520011304cc1"))
  expect_warning(get_senseBox_archive("5957b67494f0520011304cc"))

  expect_error(get_senseBox_archive())
  expect_error(get_senseBox_archive("593acaa66ccf3b00116deb0f", "2018-09-07"))

})

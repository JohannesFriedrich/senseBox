context("Test get_senseBox_sensor_info()")

test_that("Check output length and class", {
  testthat::skip_on_cran()
  testthat::skip_on_travis()

  Id <- "593acaa66ccf3b00116deb0f"

  temp <- get_senseBox_sensor_info(Id)

  expect_equal(class(temp), "list")
  expect_equal(names(temp), Id)

})

test_that("Check error handling", {
  testthat::skip_on_cran()
  testthat::skip_on_travis()

  expect_error(get_senseBox_sensor_info("fail"), NULL)

})

test_that("Check parallel = FALSE", {
  testthat::skip_on_cran()
  testthat::skip_on_travis()

  Id <- "593acaa66ccf3b00116deb0f"

  temp <- get_senseBox_sensor_info(Id,parallel = FALSE)

  expect_equal(class(temp), "list")
  expect_equal(names(temp), Id)


})

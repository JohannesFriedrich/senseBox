context("Test get_senseBox_sensor_info()")

test_that("Check output length and class", {
  testthat::skip_on_cran()
  testthat::skip_on_travis()

  Id <- "593acaa66ccf3b00116deb0f"

  temp <- get_senseBox_sensor_info(Id)

  expect_equal(class(temp), "data.frame")
  expect_equal(names(temp), c("name", "phenomena", "unit", "sensorIds","sensorType"))

})

test_that("Check error handling", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  expect_error(get_senseBox_sensor_info("fail"), NULL)

})

test_that("Check parallel = TRUE", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  Id <- "593acaa66ccf3b00116deb0f"

  temp <- get_senseBox_sensor_info(Id, parallel = TRUE)

  expect_equal(class(temp), "data.frame")
  expect_equal(names(temp), c("name", "phenomena", "unit", "sensorIds","sensorType"))


})

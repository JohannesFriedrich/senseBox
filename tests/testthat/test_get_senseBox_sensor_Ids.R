context("Test get_senseBox_sensor_Ids()")

test_that("Check output length and class", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  Id <- "593acaa66ccf3b00116deb0f"

  temp <- get_senseBox_sensor_Ids(Id)

  expect_equal(class(temp), "data.frame")
  expect_equal(names(temp), c("name", "phenomena", "sensorIds", "sensorType"))
  expect_equal(class(unlist(temp)), "character")

  ## check arguemnt tidy = TRUE
  temp <- get_senseBox_sensor_Ids(Id, tidy = TRUE)
})

test_that("Check parallel = TRUE", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  Id <- "593acaa66ccf3b00116deb0f"

  ## check parallel option
  get_senseBox_sensor_Ids(Id, parallel = TRUE)

  ## check parallel = TRUE option with multiple Ids
  temp <- get_senseBox_sensor_Ids(rep(Id,2),
                          parallel = TRUE)

  expect_equal(nrow(temp), 2)
  expect_equal(ncol(temp), 4)
  expect_equal(class(temp), "data.frame")
  expect_type(unlist(temp), "character")

})

test_that("Check error handling", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  expect_error(get_senseBox_sensor_Ids("fail"), NULL)

})

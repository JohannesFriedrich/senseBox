context("Test get_senseBox_sensor_Ids()")

test_that("Check output length and class", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  Id <- "593acaa66ccf3b00116deb0f"

  temp <- get_senseBox_sensor_Ids(Id)

  expect_equal(class(temp), "list")
  expect_equal(names(temp), Id)
  expect_equal(class(unlist(temp)), "character")
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

  expect_length(temp, 2)
  expect_type(temp, "list")
  expect_type(unlist(temp), "character")
  expect_length(temp[[1]], 4)

})

test_that("Check error handling", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  expect_error(get_senseBox_sensor_Ids("fail"), NULL)

})

test_that("Check multple input Ids", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  ## check parallel = TRUE (default) option with multiple Ids
  Id <- "593acaa66ccf3b00116deb0f"

  temp <- get_senseBox_sensor_Ids(rep(Id,3))

  expect_equal(class(temp), "list")
  expect_equal(names(temp), rep(Id,3))
  expect_equal(class(unlist(temp)), "character")

  expect_equal(class(temp), "list")
  expect_equal(names(temp), rep(Id,3))
  expect_equal(class(unlist(temp)), "character")

})

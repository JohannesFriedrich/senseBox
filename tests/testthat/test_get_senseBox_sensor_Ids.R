context("Test get_senseBox_sensor_Ids()")

test_that("Check output length and class", {
  testthat::skip_on_cran()
  testthat::skip_on_travis()

  Id <- "593acaa66ccf3b00116deb0f"

  temp <- get_senseBox_sensor_Ids(Id)

  expect_equal(class(temp), "list")
  expect_equal(names(temp), Id)
  expect_equal(class(unlist(temp)), "character")


  ## check parallel option
  get_senseBox_sensor_Ids(Id, parallel = FALSE)

})

test_that("Check error handling", {
  testthat::skip_on_cran()
  testthat::skip_on_travis()

  expect_error(get_senseBox_sensor_Ids("fail"), NULL)

})

test_that("Check multple input Ids", {
  testthat::skip_on_cran()
  testthat::skip_on_travis()

  ## check parallel = TRUE (default) option with multiple Ids
  Id <- "593acaa66ccf3b00116deb0f"

  temp <- get_senseBox_sensor_Ids(rep(Id,3))

  expect_equal(class(temp), "list")
  expect_equal(names(temp), rep(Id,3))
  expect_equal(class(unlist(temp)), "character")

  ## check parallel = FALSE option with multiple Ids
  temp <- get_senseBox_sensor_Ids(rep(Id,3),
                                  parallel = FALSE)

  expect_equal(class(temp), "list")
  expect_equal(names(temp), rep(Id,3))
  expect_equal(class(unlist(temp)), "character")

})

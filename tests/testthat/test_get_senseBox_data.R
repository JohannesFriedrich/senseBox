context("Test get_senseBox_data()")

test_that("Check output length and class", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  temp <-  get_senseBox_data(
    senseBoxId = "5957b67494f0520011304cc1",
    sensorId = list(c("5957b67494f0520011304cc4", "5957b67494f0520011304cc5")))

  expect_length(temp, 1)
  expect_type(temp, "list")
  expect_type(temp[[1]], "list")
  expect_length(temp[[1]], 2)
  expect_equal(class(temp[[1]][[1]]), "data.frame")

  temp <-  get_senseBox_data(
    senseBoxId = "5957b67494f0520011304cc1",
    sensorId = "all")

  expect_length(temp, 1)
  expect_type(temp, "list")
  expect_type(temp[[1]], "list")
  expect_length(temp[[1]], 5)
  expect_equal(class(temp[[1]][[1]]), "data.frame")

  temp <-  get_senseBox_data(
    senseBoxId = c("5957b67494f0520011304cc1", "5957b67494f0520011304cc1"),
    sensorId = "all")

  expect_length(temp, 2)
  expect_type(temp, "list")
  expect_type(temp[[1]], "list")
  expect_length(temp[[1]], 5)
  expect_equal(class(temp[[1]][[1]]), "data.frame")

  temp <-  get_senseBox_data(
    senseBoxId = c("5957b67494f0520011304cc1", "5957b67494f0520011304cc1"),
    sensorId = list(c("5957b67494f0520011304cc4", "5957b67494f0520011304cc5"),
                    "5957b67494f0520011304cc5"))

  expect_length(temp, 2)
  expect_type(temp, "list")
  expect_type(temp[[1]], "list")
  expect_length(temp[[1]], 2)
  expect_equal(class(temp[[1]][[1]]), "data.frame")


})


test_that("Check error handling", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  Id <- "5957b67494f0520011304cc1"

  ## check missing ID
  expect_error(get_senseBox_data())

  ## check wrong senseBoxID class
  expect_error(get_senseBox_data(1))

  ## check wrong sensorId class
  expect_error(get_senseBox_data(
    senseBoxId = Id,1))

  ## check wrong parallel class
  expect_error(get_senseBox_data(
    senseBoxId = Id, parallel = "1"))

  ## check wrong CSV class
  expect_error(get_senseBox_data(
    senseBoxId = Id, CSV = "1"))

  ## check wrong POSIXct class
  expect_error(get_senseBox_data(
    senseBoxId = Id, POSIXct = "1"))



  expect_error(get_senseBox_data(
    senseBoxId = "5957b67494f0520011304cc1",
    sensorId = list(c("5957b67494f0520011304cc0"))))

})

test_that("Check parallel = TRUE", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  temp <-  get_senseBox_data(
    senseBoxId = c("5957b67494f0520011304cc1", "5957b67494f0520011304cc1"),
    sensorId = "all",
    parallel = TRUE)

  expect_length(temp, 2)
  expect_type(temp, "list")
  expect_type(temp[[1]], "list")
  expect_length(temp[[1]], 5)
  expect_equal(class(temp[[1]][[1]]), "data.frame")

})

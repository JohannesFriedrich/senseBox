context("Test get_senseBox_data()")

test_that("Check output length and class", {
  testthat::skip_on_cran()

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

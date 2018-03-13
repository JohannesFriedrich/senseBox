context("Test search_senseBox()")

test_that("Check output length and class", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  temp <-  search_senseBox(phenomenon = "Helligkeit",
                           date = "2018-01-01 00:00:00")

  expect_equal(nrow(temp), 2)
  expect_equal(class(temp), "data.frame")

  indor_date <- search_senseBox(exposure = "indoor",
                  fromDate = "2018-01-01 00:00:00",
                  toDate = "2018-01-01 01:00:00")
})

test_that("Check error handling", {
  # testthat::skip_on_cran()
  # testthat::skip_on_travis()

  expect_error(search_senseBox(date = "2018-01-01 00:00:00",
                               fromDate = "2018-01-01 00:00:00"))

  expect_error(search_senseBox(fromDate = "2018-01-01 00:00:00"))

})

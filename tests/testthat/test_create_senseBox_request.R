context("Test .create_senseBox_request()")

test_that("Check for wrong Id", {

  Id_wrong <- "593acaa66ccf3b00116deb0g"

  expect_warning(senseBox:::.create_senseBox_request(path = c("boxes", Id_wrong)))

})

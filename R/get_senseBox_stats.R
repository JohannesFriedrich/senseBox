#' Get statistics about senseBox project
#'
#' @return A [data.frame] with "Number of senseBoxes",
#' "Number of Measurements" and "Number of measurements in last minute" from the senseBox API
#'
#' @section Function version: 0.0.1
#' @author Johannes Friedrich
#'
#' @examples
#'
#' get_senseBox_stats()
#'
#' @md
#' @export
get_senseBox_stats <- function() {

  data <- .create_senseBox_request(path = c("stats"))

  stats <- data.frame(
      variable = c("Number of senseBoxes", "Number of Measurements", "Number of measurements in last minute"),
      value = unlist(data)
    )

  return(stats)
}

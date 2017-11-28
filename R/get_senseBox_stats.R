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

  url <- "https://api.opensensemap.org/stats"

  resp <- httr::GET(url)
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  if (httr::http_error(resp)){
    stop("[get_senseBox_sensor_info()] API returned error!", call. = FALSE)
  }

  parsed <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyVector = FALSE)

  stats <- data.frame(
      variable = c("Number of senseBoxes", "Number of Measurements", "Number of measurements in last minute"),
      value = unlist(parsed)
    )

  return(stats)
}

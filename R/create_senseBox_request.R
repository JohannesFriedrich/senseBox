#' Get name, longitude and latitude of the submitted senseBoxId
#'
#' @section Function version: 0.0.1
#' @author Johannes Friedrich
#'
#'
#' @md
#' @noRd
.create_senseBox_request <- function(
  host = "https://api.opensensemap.org/",
  path,
  type = 'parsed',
  ...){

  res <- httr::GET(host, path = path, query = list(...))

  if (httr::http_error(res)) {
    content <-  httr::content(res, 'parsed', encoding = 'UTF-8')
    stop(if ('message' %in% names(content)) content$message else httr::status_code(res))
  }

  content <- httr::content(res, type, encoding = 'UTF-8')

  return(content)
}

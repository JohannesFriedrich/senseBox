#' Create a reqeust to the senseBox API. This is the main function of the package.
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
    warning(if ('message' %in% names(content)) "senseBoxId not available or server down" else httr::status_code(res))
    return(NULL)
  } else {

    content <- httr::content(res, type, encoding = 'UTF-8')
    return(content)
  }
}

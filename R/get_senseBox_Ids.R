#' List all senseBoxIds
#'
#' @param txtProgressBar [logical]: Display a progress bar?
#' @return [data.frame]
#'
#' @section Function version: 0.0.1
#' @author Johannes Friedrich
#'
#' @examples
#'
#' ##================================================
#' ## Example: Get all available Ids from sensBox API
#' ##================================================
#' \dontrun{
#' get_senseBox_Ids()
#' }
#' @md
#' @export
get_senseBox_Ids <- function(
  txtProgressBar = TRUE){


  url <- "https://api.opensensemap.org/boxes/"

  if(txtProgressBar)
    resp <- httr::GET(url, httr::progress())
  else
    resp <- httr::GET(url)

  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  parsed <- jsonlite::fromJSON(httr::content(resp, "text"))

  return <- data.frame(
    senseBoxId = parsed$`_id`,
    name =   parsed$name,
    stringsAsFactors=FALSE
  )

  return(return)
}

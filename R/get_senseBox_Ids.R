#' List all senseBoxIds
#'
#' @param progress [logical]: Display the progress of the download?
#' @return A [data.frame] with senseBoxIds and names of every senseBox
#'
#' @section Function version: 0.0.1
#' @author Johannes Friedrich
#'
#' @examples
#'
#' \dontrun{
#' get_senseBox_Ids()
#' }
#'
#' @md
#' @export
get_senseBox_Ids <- function(
  progress = FALSE){

  url <- "https://api.opensensemap.org/boxes/"

  ## check if progress should be printed
  if(progress)
    resp <- httr::GET(url, httr::progress())
  else
    resp <- httr::GET(url)

  ## check errors from url download
  if (httr::http_type(resp) != "application/json") {
    stop("[get_senseBox_Ids()] API did not return json", call. = FALSE)
  }
  if (httr::http_error(resp)){
    stop("[get_senseBox_Ids()] API returned error!", call. = FALSE)
  }

  parsed <- jsonlite::fromJSON(httr::content(resp, "text"))

  return <- data.frame(
    senseBoxId = parsed$`_id`,
    name = parsed$name,
    stringsAsFactors = FALSE
  )

  return(return)
}

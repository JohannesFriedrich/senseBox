#' List all senseBoxIds
#'
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
get_senseBox_Ids <- function(){

  temp <- .create_senseBox_request(path = c("boxes"), type = "text")
  parsed <- jsonlite::fromJSON(temp)

  return <- data.frame(
    senseBoxId = parsed$`_id`,
    name = parsed$name,
    stringsAsFactors = FALSE
  )

  return(return)
}

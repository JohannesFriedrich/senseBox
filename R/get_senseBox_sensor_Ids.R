#' Get sensor Ids from senseBox
#'
#' @param senseBoxId [character] (**required**): senseBoxId
#' @return [list]
#'
#' @section Function version: 0.0.1
#' @author Johannes Friedrich
#'
#' @examples
#'
#' ##=====================================
#' ## Example: get senosorIds from one sensBox
#' ##=====================================
#'
#' get_senseBox_sensor_Ids("593acaa66ccf3b00116deb0f")
#'
#' @md
#' @export
get_senseBox_sensor_Ids <- function(
  senseBoxId){

  ##=======================================##
  ## ERROR HANDLING
  ##=======================================##

  if(missing(senseBoxId))
    stop("[get_one_senseBox()] Argument 'senseBoxId' is missing", call. = FALSE)

  if(class(unlist(senseBoxId)) != "character")
    stop("[get_one_senseBox()] Argument 'senseBoxId' has to be a character", call. = FALSE)

  parsed <- parallel::mclapply(1:length(senseBoxId), function(x){

    url <- paste0("https://api.opensensemap.org/boxes/", senseBoxId[x])

    resp <- httr::GET(url)

    if (httr::http_type(resp) != "application/json") {
      stop("API did not return json", call. = FALSE)
    }

    parsed_single <- jsonlite::fromJSON(httr::content(resp, "text"))

    return(parsed_single$sensors$`_id`)
  })

  names(parsed) <- senseBoxId

  return(parsed)

}

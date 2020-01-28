#' Get name, longitude and latitude of the submitted senseBoxId
#'
#' @param senseBoxId [character] (**required**): senseBoxId
#' @param parallel [logical] (**optional**): Should the calculations be executed on multiple cores? At least 4 cores
#' are necessary to use this feature.
#'
#' @return A [data.frame] with name, longtidue and latitude of the submitted senseBoxIds.
#' This [data.frame] can directly be used in [leaflet::leaflet] to visualise the location of the senseBoxIds.
#'
#' @section Function version: 0.0.1
#' @author Johannes Friedrich
#'
#' @examples
#'
#' get_senseBox_location("593acaa66ccf3b00116deb0f")
#'
#' @md
#' @export
get_senseBox_location <- function(
  senseBoxId,
  parallel = FALSE){

  ##=======================================##
  ## ERROR HANDLING
  ##=======================================##

  if (missing(senseBoxId))
    stop("[get_senseBox_location()] Argument 'senseBoxId' is missing", call. = FALSE)

  if (class(unlist(senseBoxId)) != "character")
    stop("[get_senseBox_location()] Argument 'senseBoxId' has to be a character", call. = FALSE)

  if (class(parallel) != "logical")
    stop("[get_senseBox_location()] Argument 'parallel' has to be logical", call. = FALSE)

  ## use get_senseBox_info() to get all neccessary information
  info <- get_senseBox_info(senseBoxId, parallel = parallel)

  df <- dplyr::select(info, "name", "long", "lat")

  return(df)

}

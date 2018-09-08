#' Get sensor Ids from senseBoxId
#'
#' @param senseBoxId [character] (**required**): senseBoxId
#' @param parallel [logical] (**optional**): Should the calculations be executed on multiple cores? At least 4 cores
#' are necessary to activate this feature.
#' @param tidy [logical] (**optional**): Should the output be a tidy data frame?
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
  senseBoxId,
  parallel = FALSE,
  tidy = FALSE){

  ##=======================================##
  ## ERROR HANDLING
  ##=======================================##

  if (missing(senseBoxId))
    stop("[get_senseBox_sensor_Ids()] Argument 'senseBoxId' is missing", call. = FALSE)

  if (class(unlist(senseBoxId)) != "character")
    stop("[get_senseBox_sensor_Ids()]  Argument 'senseBoxId' has to be a character", call. = FALSE)

  if (class(parallel) != "logical")
    stop("[get_senseBox_sensor_Ids()] Argument 'parallel' has to be logical", call. = FALSE)

  if (class(tidy) != "logical")
    stop("[get_senseBox_sensor_Ids()] Argument 'tidy' has to be logical", call. = FALSE)

  ## use get_senseBox_info() to get all neccessary information
  info <- get_senseBox_info(senseBoxId, parallel = parallel)
  df <- dplyr::select_(info, "name", "phenomena", "sensorIds", "sensorType")

  if (tidy)
    df <- tidyr::unnest_(df)

  return(df)

}

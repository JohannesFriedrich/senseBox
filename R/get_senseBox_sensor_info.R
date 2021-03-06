#' Get info (Ids) from sensors of a senseBox
#'
#' @param senseBoxId [character] (**required**): senseBoxId
#' @param parallel [logical] (**optional**): Should the calculations be executed on multiple cores? At least 4 cores
#' are necessary to use this feature.
#' @param tidy [logical] (**optional**): Should the output be a tidy data frame?
#' @return A [data.frame] with coloumns "name", "phenomena", "unit", "sensorIds", "sensorType".
#'
#' @section Function version: 0.0.1
#' @author Johannes Friedrich
#'
#' @examples
#'
#' ##=========================================
#' ## Example: get senosorIds from one sensBox
#' ##=========================================
#'
#' get_senseBox_sensor_info("593acaa66ccf3b00116deb0f")
#'
#' @md
#' @export
get_senseBox_sensor_info <- function(
  senseBoxId,
  parallel = FALSE,
  tidy = FALSE){

  ##=======================================##
  ## ERROR HANDLING
  ##=======================================##

  if (missing(senseBoxId))
    stop("[get_senseBox_sensor_info()] Argument 'senseBoxId' is missing", call. = FALSE)

  if (class(unlist(senseBoxId)) != "character")
    stop("[get_senseBox_sensor_info()] Argument 'senseBoxId' has to be a character", call. = FALSE)

  if (class(parallel) != "logical")
    stop("[get_senseBox_sensor_info()] Argument 'parallel' has to be logical", call. = FALSE)

  if (class(tidy) != "logical")
    stop("[get_senseBox_sensor_info()] Argument 'tidy' has to be logical", call. = FALSE)

  ##==== END ERROR HANDLING

  ## use get_senseBox_info() to get all neccessary information
  ## get_senseBox_info() will remove all not available IDs -> just parse them
  info <- get_senseBox_info(senseBoxId, parallel = parallel)

  ##check if info is empty
  if (is.null(info)){
    return(NULL)
  }

  info_list <- lapply(1:nrow(info), function(x){
    df <- dplyr::select(info[x,1:ncol(info)], "name", "phenomena", "unit", "sensorIds", "sensorType")

    return(df)

  })

  df <- dplyr::bind_rows(info_list)

  if (tidy)
    df <- tidyr::unnest(df,
                        cols = c("phenomena", "unit", "sensorIds", "sensorType"))

  return(df)

}

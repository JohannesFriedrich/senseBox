#' Get info (Ids) from sensors of a senseBox
#'
#' @param senseBoxId [character] (**required**): senseBoxId
#' @return [list]
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
get_senseBox_location <- function(
  senseBoxId){

  ##=======================================##
  ## ERROR HANDLING
  ##=======================================##

  if(missing(senseBoxId))
    stop("[get_one_senseBox()] Argument 'senseBoxId' is missing", call. = FALSE)

  if(class(unlist(senseBoxId)) != "character")
    stop("[get_one_senseBox()] Argument 'senseBoxId' has to be a character", call. = FALSE)

  info <- get_senseBox_info(senseBoxId)

  long <- lapply(1:length(info), function(x){

    info[[x]]$content$currentLocation$coordinates[1]
  })

  lat <- lapply(1:length(info), function(x){

    info[[x]]$content$currentLocation$coordinates[2]
  })

  name <- lapply(1:length(info), function(x){

    info[[x]]$content$name
  })

  return(
    data.frame(
      name = unlist(name),
      long = unlist(long),
      lat = unlist(lat)
    )
  )

}

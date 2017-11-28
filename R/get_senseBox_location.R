#' Get name, longitude and latitude of the submitted senseBoxId
#'
#' @param senseBoxId [character] (**required**): senseBoxId
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
  senseBoxId){

  ##=======================================##
  ## ERROR HANDLING
  ##=======================================##

  if(missing(senseBoxId))
    stop("[get_senseBox_location()] Argument 'senseBoxId' is missing", call. = FALSE)

  if(class(unlist(senseBoxId)) != "character")
    stop("[get_senseBox_location()] Argument 'senseBoxId' has to be a character", call. = FALSE)

  ## use get_senseBox_info() to get all neccessary information
  info <- get_senseBox_info(senseBoxId)

  ## extract longitude
  long <- lapply(1:length(info), function(x){

    info[[x]]$content$currentLocation$coordinates[1]
  })

  ## extract latitude
  lat <- lapply(1:length(info), function(x){

    info[[x]]$content$currentLocation$coordinates[2]
  })

  ## extract name of senseBox
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

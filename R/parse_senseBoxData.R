#' Construct a senseBox data.frame
#'
#' Parses the fields of a \code{/boxes} response from the openSenseMap API
#' The code was originally developed by Norwin Roosen (https://github.com/noerw/opensensmapR)
#'
#' @author Norwin Roosen, University of Muenster (Germany),
#' Johannes Friedrich, University of Bayreuth (Germany)
#'
#' @param boxdata A named \code{list} containing the data from a senseBox
#' @return A \code{data.frame}
#'
#' @export
parse_senseBoxData <- function(boxdata) {

  # extract nested lists for later use & clean them from the list
  # to allow a simple data.frame structure
  sensors <- boxdata$sensors
  location <- boxdata$currentLocation

  boxdata[c('loc', 'locations', 'currentLocation', 'sensors', 'image', 'boxType')] <- NULL
  thebox <- as.data.frame(boxdata, stringsAsFactors = F)

  # parse timestamps (updatedAt might be not defined)
  thebox$createdAt <- as.POSIXct(strptime(thebox$createdAt, format = '%FT%T', tz = 'GMT'))

  if (!is.null(thebox$updatedAt))
    thebox$updatedAt <- as.POSIXct(strptime(thebox$updatedAt, format = '%FT%T', tz = 'GMT'))

  thebox$phenomena <- list(unlist(lapply(sensors, function(s) { s$title })))
  thebox$unit <- list(unlist(lapply(sensors, function(s) { s$unit })))
  thebox$sensorIds <- list(unlist(lapply(sensors, function(s) { s$`_id` })))
  thebox$sensorType <- list(unlist(lapply(sensors, function(s) { s$sensorType })))

  # FIXME: if one sensor has NA, max() returns bullshit
  thebox$lastMeasurement <- max(lapply(sensors, function(s) {
    if (!is.null(s$lastMeasurement))
      as.POSIXct(strptime(s$lastMeasurement$createdAt, format = '%FT%T', tz = 'GMT'))
    else
      NA
  })[[1]])

  # extract coordinates & transform to simple feature object
  thebox$long <- location$coordinates[[1]]
  thebox$lat <- location$coordinates[[2]]
  if (length(location$coordinates) == 3)
    thebox$height <- location$coordinates[[3]]

  return(thebox)
}

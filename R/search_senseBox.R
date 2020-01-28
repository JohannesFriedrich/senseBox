#' Search senseBoxes with special phenomenas, dates, exposures, ...
#'
#' If the arguments `fromDate` and `toDate` are NOT given, the measurements from the last 48 h from
#' now are downloaded. The maximum numbers of downloaded measurements are 10,000.
#' The maximum time frame is one month.
#' @param phenomenon [character] (**optional**): Which phenomenon do you want to search for?
#' @param exposure [character] (**optional**): Which exposure do you want to search for?
#' "indoor", "outdoor", "mobile", "unknown"
#' @param model [character] (**optional**): Which model do you want to search for?
#' "homeEthernet", "homeWifi", "homeEthernetFeinstaub", "homeWifiFeinstaub", "luftdaten_sds011", "
#' luftdaten_sds011_dht11", "luftdaten_sds011_dht22", "luftdaten_sds011_bmp180", "luftdaten_sds011_bme280"
#' @param grouptag [character] (**optional**): Which grouptag do you want to search for?
#' @param date [character] (**optional**): Which date do you want to search for? Not useable in combination with
#' fromDate and toDate
#' @param fromDate [character] (**optional**): Just show data with from date in format YYYY-mm-dd HH:MM:SS
#' @param toDate [character] (**optional**): Just show data with up to date in format YYYY-mm-dd HH:MM:SS
#' @param tidy [logical] (**optional**): Should the output be a tidy data frame?
#'
#' @return A [data.frame] with every entry is a senseBoxId.
#'
#' @section Function version: 0.0.1
#' @author Johannes Friedrich
#'
#' @examples
#'
#' indoor <- search_senseBox(exposure = "indoor")
#'
#' Helligkeit<- search_senseBox(phenomenon = "Helligkeit",
#'                              date = "2018-01-01 00:00:00")
#'
#' ifgi_outdoor <- search_senseBox(grouptag = 'ifgi', exposure = 'outdoor')
#'
#' @md
#' @export
search_senseBox <- function(
  phenomenon = NA,
  exposure = NA,
  model = NA,
  grouptag = NA,
  date = NA,
  fromDate = NA,
  toDate = NA,
  tidy = FALSE
){

  ##=======================================##
  ## ERROR HANDLING
  ##=======================================##

  if (!is.na(phenomenon) && is.na(date) && is.na(toDate) && is.na(fromDate))
    stop('Parameter "phenomenon" can only be used together with "date" or "from"/"to"')

  # error, if date and from/to given
  if (!is.na(date) && (!is.na(toDate) || !is.na(fromDate))) {
    stop('Parameter "date" cannot be used together with "from"/"to"')
  }

  if ( (!is.na(toDate) && is.na(fromDate)) || (is.na(toDate) && !is.na(fromDate))) {
    stop('Parameter "from"/"to" must be used together')
  }

  ########

  query <- list()

  if (!is.na(exposure)) query$exposure <- exposure
  if (!is.na(model)) query$model <- model
  if (!is.na(grouptag)) query$grouptag <- grouptag
  if (!is.na(phenomenon)) query$phenomenon <- phenomenon

  if (!is.na(toDate) && !is.na(fromDate)) {
    fromDate <- format.POSIXct(as.POSIXct(fromDate), "%Y-%m-%dT%H:%M:%SZ")
    toDate <- format.POSIXct(as.POSIXct(toDate), "%Y-%m-%dT%H:%M:%SZ")
    query$date <- paste(c(fromDate, toDate), collapse = ",")
  } else if (!is.na(date)) {
    query$date <-  format.POSIXct(as.POSIXct(date), "%Y-%m-%dT%H:%M:%SZ")
  }

  temp <- do.call(.create_senseBox_request, c(path = "boxes", query))

  if (length(temp) > 0) {

    parsed_list <- lapply(temp, parse_senseBoxData)

    df_parsed <- dplyr::bind_rows(parsed_list)

    df_parsed <- dplyr::rename(df_parsed, "senseBoxId" = "X_id")

    if (tidy)
      df_parsed <- tidyr::unnest(df_parsed,
                                 cols = c(phenomena, unit, sensorIds, sensorType))

    return(df_parsed)

  } else {

    return(NULL)

  }

}

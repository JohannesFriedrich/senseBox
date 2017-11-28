#' Get data from a senseBox
#'
#' If the arguments `fromDate` and `toDate` are NOT given, the measurements from the last 48 h from
#' now are downloaded. The maximum numbers of downloaded measurements are 10,000.
#' The maximum time frame is one month.
#' It is possible to download the data directly as a csv file, when argument `CSV` is `TRUE`.
#'
#' @param senseBoxId [character]or [vector] of [character] (**required**): senseBoxId or a [vector] of [character] of senseBoxIds
#' @param sensorId [character] or [list] of [character] (**required**): sensorId or a [list] of senseBoxIds
#' @param fromDate [character] (**optional**): Just show data with from date in format YYYY-mm-dd HH:MM:SS
#' @param toDate [character] (**optional**): Just show data with up to date in format YYYY-mm-dd HH:MM:SS
#' @param parallel [logical] (**optional**): Should the calculations be executed on multiple cores? At least 4 cores
#' are necessary to use this feature.
#' @param CSV [logical] (**optional**): Download data as csv file? NOT SUPPORTED UNTIL NOW!
#' @param POSIXct [logical] (**optional**): Should the timestamp be translated into POSIXct?
#' @return: A [list] with every entry is a sensBoxId. Every list entry inherits a [data.frame] with values and dates.
#'
#' @section Function version: 0.0.1
#' @author Johannes Friedrich
#'
#' @examples
#'
#' ##=====================================
#' ## Example: get data from sensorId
#' ##=====================================
#'
#' get_senseBox_data(
#'   senseBoxId = "5957b67494f0520011304cc1",
#'   sensorId = "5957b67494f0520011304cc4")
#'
#'\dontrun{
#' get_senseBox_data(
#'   senseBoxId = c("5957b67494f0520011304cc1","5957b67494f0520011304cc1") ,
#'   sensorId = "all",
#'   fromDate = "2017-11-25-12:00:00",
#'   toDate = "2017-11-26-12:00:00")
#'
#' get_senseBox_data(
#'   senseBoxId = "5957b67494f0520011304cc1",
#'   sensorId = "5957b67494f0520011304cc4",
#'   fromDate = "2017-11-25-12:00:00",
#'   toDate = "2017-11-26-12:00:00")
#'}
#'
#' @md
#' @export
get_senseBox_data <- function(
  senseBoxId,
  sensorId = rep("all", times = length(unlist(senseBoxId))),
  fromDate = NULL,
  toDate = NULL,
  parallel = TRUE,
  CSV = FALSE,
  POSIXct = TRUE){

  ##=======================================##
  ## ERROR HANDLING
  ##=======================================##

  if(missing(senseBoxId))
    stop("[get_senseBox_data()] Argument 'senseBoxId' is missing", call. = FALSE)

  if(class(unlist(senseBoxId)) != "character")
    stop("[get_senseBox_data()] Argument 'senseBoxId' has to be a character", call. = FALSE)

  if(class(unlist(sensorId)) != "character")
    stop("[get_senseBox_data()] Argument 'sensorId' has to be a character", call. = FALSE)

  ##==== END ERROR HANDLING

  if(length(sensorId) < length(senseBoxId) && sensorId == "all"){
    sensorId <- rep(sensorId[1], times = length(senseBoxId))
  }

  Ids_loop <- lapply(1:length(senseBoxId), function(x){

    sensor_info <- get_senseBox_sensor_info(senseBoxId[x])

    sensor_info <-  data.frame(
      title = sensor_info[[1]]$title,
      unit = sensor_info[[1]]$unit,
      id = sensor_info[[1]]$`_id`,
      stringsAsFactors = F
      )

    for(i in 1:length(sensorId[[x]])){
      if(all(sensorId[[x]]!= "all")){
        ##check if sensorId is really part of the senseBox
        if(! all(sensorId[[x]] %in% sensor_info$id)){
          stop("[get_senseBox_data()] SensorId is not part of the senseBox. Check argument 'sensorId' with function 'get_senseBox_sensor_info()'.", call. = TRUE)
        } else {
          sensor_index <- which(sensor_info$id %in% sensorId[[x]])
          sensorId_new <- sensor_info$id[sensor_index]
        }

      } else { ## sensorId = "all"
        sensor_index <- 1:length(sensor_info$id)
        sensorId_new <- sensor_info$id
      }
    }

    ## check number of cores to use
    if(parallel){
      if(parallel::detectCores() <= 2){
        warning("[get_senseBox_data()] For the multicore auto mode at least 4 cores are needed.
                Use 1 core to calculate results.", call. = FALSE)
        cores <- 1
      } else {
        cores <- parallel::detectCores() - 2
      }
    } else {
      cores <- 1
    }

    cl <- parallel::makeCluster(cores)
    on.exit(parallel::stopCluster(cl))

    parsed <- parallel::parLapply(cl, 1:length(sensorId_new), function(y){

      ## check arguments `fromDate`, `toDate`

      path_from_date <- ifelse(is.null(fromDate), "", paste0("&from-date=", format.POSIXct(as.POSIXct(fromDate), "%Y-%m-%dT%H:%M:%SZ")))
      path_to_date <- ifelse(is.null(toDate), "", paste0("&to-date=", format.POSIXct(as.POSIXct(toDate), "%Y-%m-%dT%H:%M:%SZ")))
      path_CSV <- ifelse(CSV, "&download=false", "&download=false")

      url <- paste0("https://api.opensensemap.org/boxes/", senseBoxId[x], "/data/", sensorId_new[y], "?",
                    path_from_date, path_to_date, path_CSV)

      resp <- httr::GET(url)

      if (httr::http_type(resp) != "application/json") {
        stop("[get_senseBox_data()] API did not return json\n", call. = FALSE)
      }

      if(!http_error(resp$status_code)){

        parsed_single <- jsonlite::fromJSON(httr::content(resp, "text"))

        if(length(parsed_single) != 0){

          parsed_single$value <- as.numeric(parsed_single$value)

          if(POSIXct)
            parsed_single$createdAt <- as.POSIXct(parsed_single$createdAt, tz = "UTC", format = "%Y-%m-%dT%H:%M:%OSZ")
        } else {
          warning(paste0("[get_senseBox_data()] Sensor data for senseBoxId ",senseBoxId[x], "sensorId ", sensorId_new[y])," not available!", call. = FALSE)
          parsed_single <- "Sensor data not available"
        }

        ##remove coloumn 'location'

        parsed_single$location <- NULL

        return(parsed_single)

      } else {

        return(NULL)

      } ## end else

    }) ## end parsed <- parallel::parLapply ...

    names(parsed) <- paste0(sensor_info$title[sensor_index], " [",sensor_info$unit[sensor_index], "]")

    return(parsed)

    }) ## end Ids_loop <- lapply

  names(Ids_loop) <- senseBoxId

  return(Ids_loop)
}

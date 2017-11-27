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
get_senseBox_sensor_info <- function(
  senseBoxId){

  ##=======================================##
  ## ERROR HANDLING
  ##=======================================##

  if(missing(senseBoxId))
    stop("[get_senseBox_sensor_info()] Argument 'senseBoxId' is missing", call. = FALSE)

  if(class(unlist(senseBoxId)) != "character")
    stop("[get_senseBox_sensor_info()] Argument 'senseBoxId' has to be a character", call. = FALSE)

  if(parallel::detectCores() <= 2){
    warning("[get_senseBox_data()] For the multicore auto mode at least 4 cores are needed. Use 1 core to calculate results.", call. = FALSE)
    cores <- 1
  }else{
    cores <- parallel::detectCores() - 2
  }

  cl <- parallel::makeCluster(cores)

  parsed <- parallel::parLapply(cl, 1:length(senseBoxId), function(x){

    url <- paste0("https://api.opensensemap.org/boxes/", senseBoxId[x])

    resp <- httr::GET(url)

    if (httr::http_type(resp) != "application/json") {
      stop("API did not return json", call. = FALSE)
    }

    parsed_single <- jsonlite::fromJSON(httr::content(resp, "text"))

    return(parsed_single$sensors)

    })

  parallel::stopCluster(cl)

  names(parsed) <- senseBoxId

  return(parsed)


}

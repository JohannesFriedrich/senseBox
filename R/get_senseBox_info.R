#' Get info about one senseBox
#'
#' @param senseBoxId [character] (**required**): senseBoxId
#' @param parallel [logical] (**optional**): Should the calculations be executed on multiple cores? At least 4 cores
#' are necessary to activate this feature.
#' @return [list]
#'
#' @section Function version: 0.0.1
#' @author Johannes Friedrich
#'
#' @examples
#'
#' ##=====================================
#' ## Example: get data from one sensBox
#' ##=====================================
#'
#' get_senseBox_info("593acaa66ccf3b00116deb0f")
#'
#' @md
#' @export
get_senseBox_info <- function(
  senseBoxId,
  parallel = FALSE){

  ##=======================================##
  ## ERROR HANDLING
  ##=======================================##

  if(missing(senseBoxId))
    stop("[get_senseBox_info()] Argument 'senseBoxId' is missing", call. = FALSE)

  if(class(unlist(senseBoxId)) != "character")
    stop("[get_one_senseBox_info()] Argument 'senseBoxId' has to be a character", call. = FALSE)

  if(parallel){
    if(parallel::detectCores() <= 2){
      warning("[get_senseBox_info()] For the multicore auto mode at least 4 cores are needed.
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

  parsed <- parallel::parLapply(cl, 1:length(senseBoxId), function(x){

    url <- paste0("https://api.opensensemap.org/boxes/", senseBoxId[x])

    resp <- httr::GET(url)

    if (httr::http_type(resp) != "application/json") {
      stop("[get_senseBox_info()] API did not return json", call. = FALSE)
    }
    if (httr::http_error(resp)){
      stop("[get_senseBox_info()] API returned error!", call. = FALSE)
    }

    parsed_single <- jsonlite::fromJSON(httr::content(resp, "text"))

    result <- list(
      content = parsed_single,
      senseBoxId = senseBoxId[x],
      response = resp)

    return(result)

  })

  names(parsed) <- senseBoxId

  return(parsed)
}

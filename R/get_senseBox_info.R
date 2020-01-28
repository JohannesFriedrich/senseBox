#' Get info about one senseBox.
#' You will receive information about a senseBox, e.g., the different sensors.
#'
#' @param senseBoxId [character] or [vector] of [character] (**required**): senseBoxId
#' @param parallel [logical] (**optional**): Should the calculations be executed on multiple cores?
#' At least 4 cores are necessary to activate this feature.
#' @param tidy [logical] (**optional**): Should the output be a tidy data frame?
#' @return A [data.frame]
#'
#' @section Function version: 0.0.1
#' @author Johannes Friedrich
#'
#' @examples
#'
#' ##=====================================
#' ## Example: get data from one senseBox
#' ##=====================================
#'
#' get_senseBox_info("593acaa66ccf3b00116deb0f")
#'
#' @md
#' @export
get_senseBox_info <- function(
  senseBoxId,
  parallel = FALSE,
  tidy = FALSE){

  ##=======================================##
  ## ERROR HANDLING
  ##=======================================##

  if (missing(senseBoxId))
    stop("[get_senseBox_info()] Argument 'senseBoxId' is missing", call. = FALSE)

  if (class(unlist(senseBoxId)) != "character")
    stop("[get_senseBox_info()] Argument 'senseBoxId' has to be a character", call. = FALSE)

  if (class(parallel) != "logical")
    stop("[get_senseBox_info()] Argument 'parallel' has to be logical", call. = FALSE)

  if (class(tidy) != "logical")
    stop("[get_senseBox_info()] Argument 'parallel' has to be logical", call. = FALSE)

  ########

  if (parallel) {
    if (parallel::detectCores() <= 2) {
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

  ## call main function
  parsed <- parallel::parLapply(cl, 1:length(senseBoxId), function(x){

    temp <- .create_senseBox_request(path = c("boxes", senseBoxId[x]))
    return(list(data = temp,
             senseBoxId = senseBoxId[x]))

  })

  ## check if senseBoxId was not available
  parsed <- lapply(parsed, function(x){

    if (is.null(x$data)){
      warning(paste0("[get_senseBox_info()] senseBoxId ", x$senseBoxId, " not found!"), call. = FALSE)
      return(NULL)
    } else {
      return(x$data)
    }
  })

  ## check if return value is NULL
  if (is.null(unlist(parsed))) {
    return(NULL)
  }

  ## parse list and make data.frame
  parsed_list <- lapply(parsed, parse_senseBoxData)

  df_parsed <- dplyr::bind_rows(parsed_list)

  ## output in "tidy" format, if needed
  if (tidy){
    df_parsed <- tidyr::unnest(df_parsed,
                               cols = c(phenomena, unit, sensorIds, sensorType))
  }

  return(df_parsed)
}

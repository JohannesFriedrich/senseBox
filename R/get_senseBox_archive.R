#' Get archived data from a senseBox
#'
#' @param senseBoxId [character] (**required**): senseBoxId
#' @param date [character] (**optional**): Download data from date in format YYYY-mm-dd. If no date was given,
#' the functions tries to download the archive from yesterday.
#' @section Function version: 0.0.1
#' @author Johannes Friedrich
#'
#' @return The function returns an [httr::response] object.
#'
#' @examples
#'
#' ##=====================================
#' ## Example: download senseBox archive
#' ##=====================================
#'
#' get_senseBox_archive(
#'   senseBoxId = "5957b67494f0520011304cc1",
#'   date = "2018-01-01")
#'
#' get_senseBox_archive(
#'   senseBoxId = "5957b67494f0520011304cc1")
#'
#' @md
#' @export
get_senseBox_archive <- function(
  senseBoxId,
  date = NULL){

  ##=======================================##
  ## ERROR HANDLING
  ##=======================================##

  if (missing(senseBoxId))
    stop("[get_senseBox_data()] Argument 'senseBoxId' is missing", call. = FALSE)

  if (class(unlist(senseBoxId)) != "character")
    stop("[get_senseBox_data()] Argument 'senseBoxId' has to be a character", call. = FALSE)

  if(is.null(date))
    date <- Sys.Date() - 1

  ##==== END ERROR HANDLING

  zip_url <- "https://uni-muenster.sciebo.de/index.php/s/HyTbguBP4EkqBcp/download?path=/data/"

  zip_url <- paste0(zip_url, date,"/")

  senseBox_name <- get_senseBox_info(senseBoxId)$name

  senseBox_name <- paste(strsplit(senseBox_name, " ")[[1]], collapse = "_")

  complete_name <- paste(senseBoxId, senseBox_name, sep = "-")

  complete_path <- paste(zip_url, complete_name, sep = "")

  resp <- httr::GET(
      complete_path,
      write_disk(paste0(complete_name,".zip"), overwrite = TRUE),
      progress())

  if (httr::http_type(resp) != "application/zip") {
    stop("[get_senseBox_archive()] API did not return zip file\n", call. = FALSE)
  }

  return(resp)

}

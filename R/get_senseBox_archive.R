#' Get archived data from a senseBox
#'
#' @param senseBoxId [character] (**required**): senseBoxId
#' @param date [character] (**optional**): Download data from date in format YYYY-mm-dd. If no date was given,
#' the functions tries to download the archive from the day before yesterday.
#' @section Function version: 0.0.1
#' @author Johannes Friedrich
#'
#' @return The function returns a [data.frame] object.
#'
#' @examples
#'
#' \dontrun{
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
#' }
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
    stop("[get_senseBox_archive()] Argument 'senseBoxId' is missing.", call. = FALSE)

  if (class(unlist(senseBoxId)) != "character")
    stop("[get_senseBox_archive()]  Argument 'senseBoxId' has to be a character.", call. = FALSE)

  if(is.null(date)){
    warning("[get_senseBox_archive()]  Argument 'date' not set. By default the day before yesterday was chosen.", call. = FALSE)
    date <- Sys.Date() - 2}

  ##==== END ERROR HANDLING

  # get right URL
  zip_url <- "https://archive.opensensemap.org/" #"https://uni-muenster.sciebo.de/index.php/s/HyTbguBP4EkqBcp/download?path=/data/"

  zip_url <- paste0(zip_url, date,"/")

  senseBox_info <- get_senseBox_info(senseBoxId)

  if (is.null(senseBox_info$name)) {
    return(NULL)
  }

  senseBox_name <- strsplit(senseBox_info$name, " ")

  senseBox_name <- unlist(lapply(senseBox_name, function(x){

    paste(x, collapse = "_")

  }), recursive = F)

  ## remove unwanted characters
  senseBox_name <- gsub("[^0-9A-Za-z._-]","__" , senseBox_name, ignore.case = TRUE)

  ## compose address
  complete_name <- paste(senseBoxId, senseBox_name, sep = "-")

  complete_path <- paste(zip_url, complete_name, sep = "")
  print(complete_path)

  ## try if URL works
  ## https://stackoverflow.com/questions/12193779/how-to-write-trycatch-in-r
  parsed_list <- lapply(complete_path, function(x){

    try_url <- tryCatch(
      expr = {
        xml2::read_html(x)
      },

      error=function(cond) {
        message(paste("URL does not seem to exist:", url))
        message("Here's the original error message:")
        message(cond)
        # Choose a return value in case of error
        return(FALSE)
      }
    ) # end try-catch

    if (class(try_url)[1] == "xml_document"){

      csv_pos <- rvest::html_nodes(try_url, "a")
      csv_pos <- rvest::html_attr(csv_pos, "href")

      csv_links <- csv_pos[grepl(".csv", csv_pos)]

      ## download CSV files
      return(csv_links)

    } else {

      warning("[get_senseBox_archive()] URL was not correct! Check date and senseBoxId", call. = FALSE)
      return(NULL)

    }

  })

  ## give names
  names(parsed_list) <- senseBoxId

  ## list to dataframe
  df_parsed <- dplyr::bind_rows(parsed_list)

  return(df_parsed)

}

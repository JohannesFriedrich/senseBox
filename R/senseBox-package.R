#' senseBox
#'
#' A R API wrapper for the senseBox project. Download and analyse environmental data provided by https://sensebox.de/en/.
#'
#' \tabular{ll}{Package: \tab senseBox\cr Type: \tab Package\cr Version:
#' \tab 0.0.1 \cr Date: \tab 2018-XX-XX \cr License: \tab MIT\cr }
#'
#' @name senseBox-package
#'
#' @docType package
#'
#' @keywords package
#' @import httr jsonlite
#' @importFrom utils str
NULL

## Solution for warning in R CM check from https://github.com/STAT545-UBC/Discussion/issues/451
## quiets concerns of R CMD check re: the .'s that appear in pipelines
if (getRversion() >= "2.15.1") utils::globalVariables(c("."))

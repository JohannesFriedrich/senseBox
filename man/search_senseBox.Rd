% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/search_senseBox.R
\name{search_senseBox}
\alias{search_senseBox}
\title{Search senseBoxes with special phenomenas, dates, exposures, ...}
\usage{
search_senseBox(
  phenomenon = NA,
  exposure = NA,
  model = NA,
  grouptag = NA,
  date = NA,
  fromDate = NA,
  toDate = NA,
  tidy = FALSE
)
}
\arguments{
\item{phenomenon}{\link{character} (\strong{optional}): Which phenomenon do you want to search for?}

\item{exposure}{\link{character} (\strong{optional}): Which exposure do you want to search for?
"indoor", "outdoor", "mobile", "unknown"}

\item{model}{\link{character} (\strong{optional}): Which model do you want to search for?
"homeEthernet", "homeWifi", "homeEthernetFeinstaub", "homeWifiFeinstaub", "luftdaten_sds011", "
luftdaten_sds011_dht11", "luftdaten_sds011_dht22", "luftdaten_sds011_bmp180", "luftdaten_sds011_bme280"}

\item{grouptag}{\link{character} (\strong{optional}): Which grouptag do you want to search for?}

\item{date}{\link{character} (\strong{optional}): Which date do you want to search for? Not useable in combination with
fromDate and toDate}

\item{fromDate}{\link{character} (\strong{optional}): Just show data with from date in format YYYY-mm-dd HH:MM:SS}

\item{toDate}{\link{character} (\strong{optional}): Just show data with up to date in format YYYY-mm-dd HH:MM:SS}

\item{tidy}{\link{logical} (\strong{optional}): Should the output be a tidy data frame?}
}
\value{
A \link{data.frame} with every entry is a senseBoxId.
}
\description{
If the arguments \code{fromDate} and \code{toDate} are NOT given, the measurements from the last 48 h from
now are downloaded. The maximum numbers of downloaded measurements are 10,000.
The maximum time frame is one month.
}
\section{Function version}{
 0.0.1
}

\examples{

indoor <- search_senseBox(exposure = "indoor")

Helligkeit<- search_senseBox(phenomenon = "Helligkeit",
                             date = "2018-01-01 00:00:00")

ifgi_outdoor <- search_senseBox(grouptag = 'ifgi', exposure = 'outdoor')

}
\author{
Johannes Friedrich
}

## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, 
                      fig.align = "center")

## ------------------------------------------------------------------------
library(senseBox)

stats <- get_senseBox_stats()

list <- get_senseBox_Ids(txtProgressBar = FALSE)
senseBoxId <- c("592ca4b851d3460011ea2635")

## ---- echo = FALSE-------------------------------------------------------
knitr::kable(
  stats, format = "html"
)

## ------------------------------------------------------------------------
location <- get_senseBox_location(senseBoxId)

library(leaflet)
library(htmltools)

leaflet(location) %>%
  addTiles() %>%  
  addMarkers(~long, ~lat, popup = ~htmltools::htmlEscape(name))

## ------------------------------------------------------------------------
sensor_info <- get_senseBox_sensor_info(senseBoxId)

knitr::kable(
  sensor_info[[1]][,1:5],
  format = "html"
)

## ------------------------------------------------------------------------
data_all <- get_senseBox_data(senseBoxId)

## ------------------------------------------------------------------------
sensor_ids <- get_senseBox_sensor_Ids(senseBoxId)

data_sel <- get_senseBox_data(senseBoxId, 
                              sensorId = list(sensor_ids[[1]][1:2]))

## ----eval = FALSE--------------------------------------------------------
#  data_timeframe <- get_senseBox_data(senseBoxId,
#                                      sensorIds,
#                                      fromDate = "2017-11-11 11:11:11",
#                                      toDate = "2017-11-14 11:11:11")

## ------------------------------------------------------------------------
library(ggplot2)
library(reshape2)
library(scales)

data_melt <- melt(data_all[[1]], id.vars = c("createdAt", "value"))

ggplot(data_melt, aes(x=createdAt, y = value, colour = L1)) +
  geom_line() +
  scale_x_datetime(labels = date_format("%H:%M:%S", tz = Sys.timezone())) +
  facet_wrap(~L1, scales = "free") +
  theme(legend.position = "bottom",
        legend.title = element_blank())



## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, 
                      fig.align = "center")

## ------------------------------------------------------------------------
library(senseBox)

list <- get_senseBox_Ids(txtProgressBar = FALSE)
senseBoxIds <- c("592ca4b851d3460011ea2635",
                 "58d178b3c877fb001196d9cc")

## ------------------------------------------------------------------------
location <- get_senseBox_location(senseBoxIds)

library(leaflet)
library(htmltools)

leaflet(location) %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(~long, ~lat, popup = ~htmltools::htmlEscape(name))

## ------------------------------------------------------------------------
sensorIds <- get_senseBox_sensor_Ids(senseBoxIds)

sensor_info <- get_senseBox_sensor_info(senseBoxIds)

data <- get_senseBox_data(senseBoxIds, sensorIds)

## ------------------------------------------------------------------------
data_timeframe <- get_senseBox_data(senseBoxIds, sensorIds, 
                                    fromDate = "2017-11-11 11:11:11", 
                                    toDate = "2017-11-14 11:11:11")

## ------------------------------------------------------------------------
library(ggplot2)
library(reshape2)

data_melt <- melt(data, id.vars = c("createdAt", "value"))

ggplot(data_melt, aes(x=createdAt, y = value, colour = L1)) +
  geom_line() +
  facet_wrap(~L2, scales = "free")


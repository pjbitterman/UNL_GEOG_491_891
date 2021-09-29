# Point pattern
library(tidyverse)
library(GISTools)
library(sf)
library(tmap)

#cumulative rainfall for 2008
precip <- sf::read_sf("./data/Precip2008Readings.shp")
neb <- sf::read_sf("./data/Nebraska_State_Boundary.shp")

tmap_mode("plot")
tm_shape(neb) + tm_polygons() + tm_shape(precip) + tm_dots(col='navyblue')

tmap_mode("view")
tm_shape(neb) + tm_polygons() + tm_shape(precip) + tm_dots(col='navyblue')


# scratch for 5_01

library(tidyverse)
library(sf)
library(GISTools)
library(tmap)

# let's start with some data

streams <- sf::read_sf("./data/Streams_303_d_.shp")
tm_shape(streams) + tm_lines()


counties <- sf::read_sf("./data/County_Boundaries-_Census.shp")

counties_areas <- sf::st_area(counties)
# could also use in a "mutate" function to add the values

lc <- counties %>% dplyr::filter(., NAME10 == "Lancaster")


lc_303ds <- sf::st_intersection(streams, lc)


tm_shape(lc_303ds) + tm_lines()
tm_shape(lc_303ds) + tm_lines(col = "blue")

tm_shape(lc_303ds) + tm_lines(col = "Waterbody_")


buffs <- sf::st_buffer(lc_303ds, dist = 800)
tm_shape(buffs) + tm_polygons(col = "Waterbody_")



parks <- sf::read_sf("./data/State_Park_Locations.shp")
lc_parks <- sf::st_intersection(parks, lc)
tm_shape(lc_parks) + tm_dots(col = "AreaName", size = 1)


tm_shape(lc_303ds) + tm_lines(col = "Waterbody_") + 
  tm_shape(lc_parks) + tm_dots(col = "AreaName", size = 1)



theanswer <- parks %>% st_intersection(., buffs)

tm_shape(lc_303ds) + tm_lines(col = "Waterbody_") + 
  tm_shape(lc_parks) + tm_dots(col = "AreaName", size = 1)
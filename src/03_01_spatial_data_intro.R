# 03.01: intro to spatial data manipulation

library(tidyverse)
library(sf)


p.counties <- "./data/CBW/County_Boundaries.shp"
p.stations <- "./data/CBW/Non-Tidal_Water_Quality_Monitoring_Stations_in_the_Chesapeake_Bay.shp"


d.counties <- sf::read_sf(p.counties)
d.stations <- sf::read_sf(p.stations)

glimpse(d.counties)
glimpse(d.stations)


d.counties %>% sf::st_crs()
d.stations %>% sf::st_crs()

d.counties %>% sf::st_crs() == d.stations %>% sf::st_crs()


del.counties <- d.counties %>% dplyr::filter(STATEFP10 == 10)


de.stations <- sf::st_intersection(d.stations, del.counties)

y <- sf::st_intersection(del.counties, d.stations)


d.counties %>% group_by(STATEFP10)%>% dplyr::summarise(stateLandArea = sum(ALAND10))

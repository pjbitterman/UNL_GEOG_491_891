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





### spatial operations

# spatial
counties <- sf::read_sf("./data/CBW/County_Boundaries.shp") %>% sf::st_make_valid()
dams <- sf::read_sf("./data/CBW/Dam_or_Other_Blockage_Removed_2012_2017.shp") %>% sf::st_make_valid()
streams <- sf::read_sf("./data/CBW/Streams_Opened_by_Dam_Removal_2012_2017.shp") %>% sf::st_make_valid()



tm_shape(counties) + tm_polygons(col = "STATEFP10") + tm_shape(dams) + tm_dots()


pa.counties <- counties %>% filter(STATEFP10 == 42)

glimpse(pa.counties)


# how can we find the dams that are in PA?

# we've used an intersection

st_intersection(dams, pa.counties)

dams[pa.counties,]

st_intersects(dams, pa.counties)

# order matters
dams %>% st_intersects(x = ., y = pa.counties)
dams %>% st_intersects(x = pa.counties, y = .)

# get a dense logical matrix
dams %>% st_intersects(x = ., y = pa.counties, sparse = F)

# other versions
dams %>% st_disjoint(., pa.counties, sparse = F)
dams %>% st_within(., pa.counties, sparse = F)

streams %>% st_intersection(., pa.counties)

streams %>% st_intersects(pa.counties, ., sparse = T)
streams %>% st_intersects(., pa.counties, sparse = T)
streams %>% st_within(., pa.counties)

c.tioga <- counties %>% filter(NAME10 == "Tioga")
streams.tioga <- streams[c.tioga,]


streams.tioga %>% st_touches(., c.tioga)
streams.tioga %>% st_is_within_distance(., c.tioga, 1)

tm_shape(counties) + tm_polygons(col = "STATEFP10") + tm_shape(streams) + tm_lines()

### Predicates (above)

# spatial join

st_join(pa.counties, dams)

# 7.02

library(tidyverse)
library(sf)
library(tmap)

# NHDs
nhds <- sf::read_sf("./data/nhdplus_loads.shp") %>% sf::st_make_valid()
glimpse(nhds)
tm_shape(nhds) + tm_polygons("Baseline_L", n = 10)


# RPCs
rpcs <- sf::read_sf("./data/gn_vt_rpcs.shp") %>% sf::st_make_valid()
glimpse(rpcs) 
tm_shape(rpcs) + tm_polygons(col = "INITIALS")



# first, make a plot of NHD loads with 7 categories,
# Overlaid with RPC boundaries

tm_shape(rpcs) + tm_borders(col = "red") +
  tm_shape(nhds) + tm_polygons(col = "Baseline_L", n = 7) +
  tm_shape(rpcs) + tm_borders(col = "red")


nhd_rpcs <- st_join(nhds, rpcs, join = st_intersects)
glimpse(nhd_rpcs)
tm_shape(nhd_rpcs) + tm_polygons(col = "RPC")

# the "tidy way"
nhd_rpcs %>% 
  group_by(RPC) %>% 
  summarize(totalLoad = sum(Baseline_L))

# duplicate it to plot it
nhd_rpcs %>% 
  group_by(RPC) %>% 
  summarize(totalLoad = sum(Baseline_L)) %>%
  tm_shape(.) + tm_polygons(col = "totalLoad")


# using aggregate instead
aggregate(x = nhds, by = rpcs, FUN = sum) # throws an error... what's the problem?

# fix the problem
nhds %>% dplyr::select(-SOURCEFC, -NHDPlus_Ca, -Tactical_B) %>%
  aggregate(x = ., by = rpcs, FUN = sum)

# same function, but assign it to a variable
agg.rpcs <- nhds %>% dplyr::select(-SOURCEFC, -NHDPlus_Ca, -Tactical_B) %>%
  aggregate(x = ., by = rpcs, FUN = sum)

# plot it... why and how is it different?
tm_shape(agg.rpcs) + tm_polygons(col = "Baseline_L")

# issues with overlap
nhd_rpcs %>% group_by(NHDPlus_ID) %>% summarise(count = n()) %>%
  arrange(desc(count))



# area-weighted interpolation
interp.loads <- nhds %>% dplyr::select(Baseline_L, geometry) %>% 
  st_interpolate_aw(., rpcs, extensive = T)

tm_shape(interp.loads) + tm_polygons(col = "Baseline_L")

# do a join 
comparison <- st_join(agg.rpcs, interp.loads, st_equals)

# calculate the error, then map it
tmap_mode("view")

comparison %>% mutate(diff = Baseline_L.x - Baseline_L.y) %>%
  tm_shape(.) + tm_polygons(col = "diff") +
  tm_shape(nhds) + tm_borders(col = "blue")


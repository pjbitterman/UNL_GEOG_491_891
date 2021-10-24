library(tidyverse)
library(raster)
library(tmap)

myras <- raster::raster("./data/ts_2016.1007_1013.L4.LCHMP3.CIcyano.MAXIMUM_7day.tif")

plot(myras)

# properties
myras

raster::extent(myras)
raster::nbands(myras)

#[index]
myras[1]
myras[31225]

#[row, column]  
myras[600, 175]
# starts from top-left

# frequency table
raster::freq(myras)

# quick histogram
myras %>% raster::freq() %>% data.frame() %>%
  ggplot(., aes(x = value, y = count)) +
  geom_bar(stat = "identity")

# not useful, why?

# filter out the 252 (no data) values
myras %>% raster::freq() %>% data.frame() %>%
  dplyr::filter(value < 252) %>% 
  ggplot(., aes(x = value, y = count)) +
  geom_bar(stat = "identity")


# get all the values
myras %>% raster::values()


# aggregation
raster::aggregate(myras, 2, fun = max)
raster::aggregate(myras, 2, fun = max) %>% plot()

# compare to:
raster::aggregate(myras, 5, fun = max) %>% plot()
raster::aggregate(myras, 5, fun = mean) %>% plot()

# data conversions

# you can also turn them into points
myras %>% raster::rasterToPoints()

# vectorize
poly1 <- rasterToPolygons(myras, dissolve = T)

tmap_mode("view")
tm_shape(poly1) + tm_polygons()




# for raster math

# ts_2016.0902_0908.L4.LCHMP3.CIcyano.MAXIMUM_7day.tif
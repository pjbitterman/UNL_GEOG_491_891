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

### raster math

myras %>% values() %>% range(na.rm = T)


myras * 2 
(myras * 2) %>% values() %>% range(na.rm = T)

myras - 4
myras ** 2
log(myras)

# reclassify
rcl = matrix(c(0, 1, 0, 2, 249, 1, 250, 256, 0), ncol = 3, byrow = TRUE)
rcl

validdata = reclassify(myras, rcl = rcl)
validdata
plot(validdata)



# then multiply out

validRaster <- myras * validdata
plot(validRaster)


# NOAA transform for CHAMPLAIN data
# valid as of 2019-02-01 metadata
transform_champlain_olci <- function(x){
  
  10**(((3.0 / 250.0) * x) - 4.2)
}


myras.ci <- validRaster %>% transform_champlain_olci
plot(myras.ci)

myras_focal = focal(myras.ci, w = matrix(1, nrow = 3, ncol = 3), fun = max)
plot(myras_focal)

(myras_focal - r_focal) %>% plot

# good practice
compareRaster(myras_focal, r_focal)

# Global

raster::maxValue(myras.ci)
raster::minValue(myras.ci)

myras.ci %>% raster::values() %>% mean(na.rm = T)

  
# for raster math

# ts_2016.0902_0908.L4.LCHMP3.CIcyano.MAXIMUM_7day.tif
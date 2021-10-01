# for in-class code reading example

library(raster)
library(tidyverse)


### calculates bloom size for WHO threshold bands within bounding box
calc_area_by_thresholds <- function(in.raster, boundingPolygon.path, 
                                    start_date, end_date,
                                    lake_transform) {


  # 
  bb <- sf::read_sf(boundingPolygon.path)
  
  # 
  ras.p4 <- sp::proj4string(in.raster) 
  
  # 
  bb.projected <- sf::st_transform(bb, ras.p4)
  
  
  # 
  raster.res <- res(in.raster)
  pixel.area.m2 <- raster.res[1] * raster.res[2]
  
  # 
  points.intersection <- as(in.raster,"SpatialPoints") 
  # 
  points.values <- data.frame(dn.val = raster::extract(in.raster, 
                                                       points.intersection))
  # 
  points.intersection$dn.val <- points.values
  
  # 
  points.int.sf <- points.intersection %>% st_as_sf() %>%
    sf::st_intersection(., bb.projected) 
  
  if(lake_transform == "champlain_olci"){
    
    # valid points: 1-249 is valid data
    # as of 2019-02-01 metadata
    points_base <- points.int.sf %>% 
      mutate(index = transform_champlain_olci(dn.val)) 

  } else if(lake_transform == "erie_olci"){
    
    # valid points: 2-249 is valid data
    # as of 2019-02-01 metadata
    points_base <- points.int.sf %>% 
      mutate(index = transform_erie_olci(dn.val))

  } else if(lake_transform == "erie_modis"){
    points_base <- points.int.sf %>%
      mutate(index = transform_erie_modis(dn.val))
    
  } else {
    stop("your lake transformation was not found")
  }
  
  
  # THRESHOLDS ---- 
  # upper bounds on each - in units of CI (hence the divide by 1e8)
  # data from from WHO tables
  thresh.low <- 20000 / 1e8
  thresh.mod <- 100000 / 1e8
  thresh.high <- 10000000 / 1e8
  
  # 
  points_in_low <- points_base %>% 
    filter(index < thresh.low) 
  
  points_in_mod <- points_base %>%
    filter(index >= thresh.low & index < thresh.mod)
  
  points_in_high <- points_base %>%
    filter(index >= thresh.mod & index < thresh.high)
  
  points_in_veryhigh <- points_base %>%
    filter(index > thresh.high)
  
  list_of_sfs <- c(points_in_low, points_in_mod, 
                   points_in_high, points_in_veryhigh)
  
  # calculate metrics for each set of sf points
  calculate_area_pixels <- function(set_of_sfpoints){
    
    baseline_denom <- points_base %>% filter(!is.na(index)) %>% nrow()
    
    # 
    prop_in_range <- nrow(set_of_sfpoints) / baseline_denom
    
    # 
    area_m2_in_range <- pixel.area.m2 * nrow(set_of_sfpoints)
    
    toReturn <- data.frame(prop_in_range, area_m2_in_range, 
                           start_date, end_date) %>%
      magrittr::set_colnames(c("prop_in_range", "area_m2_in_range", 
                               "start_date", "end_date"))
  }
  
  # 
  area_low <- calculate_area_pixels(points_in_low) %>% 
    mutate(whoCat = "low")
  area_mod <- calculate_area_pixels(points_in_mod) %>% 
    mutate(whoCat = "moderate")
  area_high <- calculate_area_pixels(points_in_high) %>% 
    mutate(whoCat = "high")
  area_veryhigh <- calculate_area_pixels(points_in_veryhigh) %>% 
    mutate(whoCat = "very_high")
  
  # combine and re-level the category factor
  all_areas <- bind_rows(area_low, area_mod, area_high, area_veryhigh) %>% 
    mutate(whoCat = forcats::fct_relevel(whoCat, c("very_high", 
                                                   "high", 
                                                   "moderate", 
                                                   "low")))
}



# NOAA transform for CHAMPLAIN data
# valid as of 2019-02-01 metadata
transform_champlain_olci <- function(x){
  
  # valid points: 2-249 is valid data
  ifelse(x > 1 & x < 250,
         10**(((3.0 / 250.0) * x) - 4.2),
         NA)
}


# read the data
myraster <- raster::raster("./data/ts_2016.1007_1013.L4.LCHMP3.CIcyano.MAXIMUM_7day.tif")

## point to the bounding box
bb.path <- fs::path("./data/wildcard_friday/bb_miss.shp")

# run the function
area <- myraster %>% calc_area_by_thresholds(., bb.path, 
                                             "2016-10-07",
                                             "2016-10-13",
                                             "champlain_olci")

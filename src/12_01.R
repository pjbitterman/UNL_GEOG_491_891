
library(tidyverse)
library(leaflet)


# What does it mean that a map is "interactive"?

m <- leaflet()

m <- leaflet() %>%
  addTiles()


m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng = -96.703090, lat = 40.819288, popup="The Burnett Hall GIS Lab")

m


m2 <- leaflet() %>% addTiles()
df <- data.frame(
  lat = rnorm(100),
  lng = rnorm(100),
  size = runif(100, 5, 20),
  color = sample(colors(), 100)
)



m2 <- leaflet(df) %>% addTiles()
# How can we look at the properties/attriutes of an object?
# "$"

# check it out
m2$x

# add the visualizations programmatically
m2 %>% addCircleMarkers(radius = ~size, color = ~color, fill = FALSE)
m2 %>% addCircleMarkers(radius = runif(100, 4, 10), color = c('red'))




# Let's check out some other tiles

m <- leaflet() %>% setView(lng = -96.703090, lat = 40.81928, zoom = 14)
m %>% addTiles()


# third party tiles using addProvider() function

m %>% addProviderTiles(providers$Stamen.Toner)
m %>% addProviderTiles(providers$CartoDB.Positron)
m %>% addProviderTiles(providers$CartoDB.DarkMatter)
m %>% addProviderTiles(providers$Esri.NatGeoWorldMap)



# Markers

parks <- sf::read_sf("./data/State_Park_Locations.shp")

# set up the map, zoom out a bit
mp <- leaflet(data = parks) %>% setView(lng = -96.703090, lat = 40.81928, zoom = 10)
mp %>% addTiles() %>% 
  addMarkers(popup = ~AreaName, label = ~AreaName)

# What's the diff between popup and label?



# lines

streams <- sf::read_sf("./data/Streams_303_d_.shp")
ms <- leaflet(data = streams) %>% 
  setView(lng = -96.703090, lat = 40.81928, zoom = 10) %>% 
  addTiles() %>%
  addPolylines(., color = "blue", 
               popup = ~paste0(Waterbody_, " - ", Impairment))


# do multiple layers by not passing the first "leaflet()" call a data argument
m.both <- leaflet() %>%
  setView(lng = -96.703090, lat = 40.81928, zoom = 10) %>% 
  addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
  addMarkers(data = parks, popup = ~AreaName, label = ~AreaName) %>% 
  addPolylines(data = streams, color = "blue", 
               popup = ~paste0(Waterbody_, " - ", Impairment))



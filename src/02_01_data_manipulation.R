library(tidyverse)


mydf <- read_csv("./data/ne_counties.csv")

summary(mydf)


mytib <- tibble(mydf)

mydf$Total
summary(mydf$Total)
hist(mydf$Total)

dplyr::filter(mydf, Total > 10000 & MedHousInc < 40000)

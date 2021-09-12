# Week 4: Writing reproducible code

library(tidyverse)

# Indexing

### let's assume inches of rain
rainfall <- c(0.0, 2.1, 2.5, .1, 0.0, 0.0, 6.8, 3.1, 2.2)

# find the first element

rainfall[1]

# a VERY big storm is one 3" or greater, so let's check

rainfall[1] >= 3


# Let's make an if-else block
if(rainfall[1] >= 3){
  print("big storm")
} else{
  print("little storm")
}

# But how does that generalize across the entire vector?

# first, let's wrap the block in a function
f.storm.test <- function(rainfallAmount){
  if(rainfallAmount >= 3){
    print("big storm")
  } else{
    print("little storm")
  }
}

for(i in rainfall){
  f.storm.test(i)
}

# or use the tidy way
rainfall %>% purrr::map(., f.storm.test)

# or a vectorized way
rainfall >= 3


# Searching our data for other items

# What's largest rainfall record in the vector?

max(rainfall)

which(rainfall == max(rainfall))


### A tidyverse way on a dataframe

mydf <- read_csv("./data/ne_counties.csv")
glimpse(mydf)

# our variable: MedValHous

max(mydf$MedValHous)


which(mydf$MedValHous == max(mydf$MedValHous))

which(mydf$MedValHous == max(mydf$MedValHous)) %>% mydf[.,]

### a contrived but useful example question

### for each county, calculate the how much its median housing value is LESS than the maximum value

newdf <- mydf %>% mutate(deviation = MedValHous - max(MedValHous))

newdf %>% ggplot(., aes(x = deviation)) +
  geom_histogram() +
  theme_minimal()

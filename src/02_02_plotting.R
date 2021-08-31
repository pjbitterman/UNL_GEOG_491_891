library(tidyverse)
library(ggplot2)


mydf <- read_csv("./data/ne_counties.csv")


glimpse(mydf)


### base R plots ----

# scatter plot
# should be highly correlated
plot(mydf$Total, mydf$TotalUnits)

# scatter plot #2
plot(mydf$Total, mydf$PerCapInc)


# histogram
hist(mydf$PerCapInc)

# change the number of breaks
hist(mydf$PerCapInc, breaks = 20)


### ggplot ----

## Let's go step-by-step

# the initial call
ggplot(mydf, aes(x = Total, y = PerCapInc))


# let's add a geom
ggplot(mydf, aes(x = Total, y = PerCapInc)) +
  geom_point()


# and change the points
ggplot(mydf, aes(x = Total, y = PerCapInc)) +
  geom_point(colour = "blue")


# and alter the theme
ggplot(mydf, aes(x = Total, y = PerCapInc)) +
  geom_point(colour = "blue") +
  theme_minimal()


# and make the labels a bit more useful
ggplot(mydf, aes(x = Total, y = PerCapInc)) +
  geom_point(colour = "blue") +
  theme_minimal() +
  labs(x = "Total Population", y = "Per capita income")


# and give it a title
ggplot(mydf, aes(x = Total, y = PerCapInc)) +
  geom_point(colour = "blue") +
  theme_minimal() +
  labs(x = "Total Population", y = "Per capita income",
       title = "My first ggplot")

# and fit a line
ggplot(mydf, aes(x = Total, y = PerCapInc)) +
  geom_point(colour = "blue") +
  geom_smooth(method = "glm", colour = "red") +
  theme_minimal() +
  labs(x = "Total Population", y = "Per capita income",
       title = "My first ggplot")


### try another plot
ggplot(mydf, aes(x = MedianAgeF)) +
  geom_histogram(bins = 15) + 
  theme_classic()


### One more, let's do something categorical
# first, make categories

mydf2 <- mydf %>% mutate(sizeCategory = ifelse(Total > 20000, "big", "small"))

# let's count each category

# doesn't work (strings)
summary(mydf2$sizeCategory)

# count the factors
summary(as.factor(mydf2$sizeCategory))


# two examples

ggplot(mydf2, aes(x = Total, y = PerCapInc)) +
  geom_point(aes(shape = sizeCategory, colour = sizeCategory), size = 3) +
  theme_minimal() +
  labs(x = "Total Population", y = "Per capita income",
       title = "My formatted ggplot")

# use a pipe in a boxplot

mydf2 %>% ggplot(., aes(x = sizeCategory, y = PerCapInc)) +
  geom_boxplot(aes(fill = sizeCategory)) +
  theme_minimal() + 
  labs(x = "Categorical size",
       y = "Per capita income", 
       title = "I made a boxplot",
       subtitle = "it's handy")

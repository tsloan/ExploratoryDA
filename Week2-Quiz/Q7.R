####################################################################
##
## Q.7
##
## Load the `airquality' dataset form the datasets package in R.
## library(datasets)
## data(airquality)
## 
## I am interested in examining how the relationship between
## ozone and wind speed varies across each month. 
## What would be the appropriate code to visualize that 
## using ggplot2?
## 
## a. qplot(Wind, Ozone, data = airquality)
## 
## b. qplot(Wind, Ozone, data = airquality, geom = "smooth")
## 
## c. airquality = transform(airquality, Month = factor(Month))
##    qplot(Wind, Ozone, data = airquality, facets = . ~ Month)
##
## d. qplot(Wind, Ozone, data = airquality, facets = . ~ factor(Month))
##
#####################################################################

library(ggplot2)
library(datasets)
data(airquality)

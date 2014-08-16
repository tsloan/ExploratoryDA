#######################################################################
## 
## Q10
## 
## The following code creates a scatterplot of 'votes' and 
## 'rating' from the movies dataset in the ggplot2 package. 
## After loading the ggplot2 package with the library() 
## function, I can run
##
## qplot(votes, rating, data = movies)
##
## How can I modify the the code above to add a 
## smoother to the scatterplot?
## 
## a. qplot(votes, rating, data = movies) + geom_smooth()
##
## b. qplot(votes, rating, data = movies, panel = panel.loess)
##
## c. qplot(votes, rating, data = movies, smooth = "loess")
##
## d. qplot(votes, rating, data = movies) + stats_smooth("loess")
##
##################################################################
library(ggplot2)

qplot(votes, rating, data = movies)

qplot(votes, rating, data = movies) + geom_smooth()

qplot(votes, rating, data = movies, panel = panel.loess)

qplot(votes, rating, data = movies, smooth = "loess")

qplot(votes, rating, data = movies) + stats_smooth("loess")


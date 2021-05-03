library(lionessR)
exp <- read.delim("exp.txt")
system.time(lionessResults <- lioness(exp)) # this is 1000*1000 edges, should reduce it to (1000 2)=499500
lionessResults <- lionessResults[ !duplicated(apply(lionessResults[,1:2], 1, sort), MARGIN = 2), ] 
idx <- which(lionessResults[,1]==lionessResults[,2])
lionessResults <- lionessResults[-idx,] 

# save it as an R object
save(file="lionessResults.RData", list="lionessResults")



# combine networks into one .RData object
setwd("txt")
filenames <- list.files()
# order filenames on nr instead of on string
fileidx <- substr(filenames, 9, nchar(filenames)-4)
fileidx <- as.numeric(fileidx)
filenames <- cbind(filenames, fileidx)
filenames <- as.data.frame(filenames, stringsAsFactors=F)
filenames[,2] <- as.numeric(filenames[,2])
filenames <- filenames[order(filenames[,2]),]

for(i in 1:nrow(filenames)){
	prednet <- read.delim(filenames[i,1], header=F)
	prednet <- unlist(c(prednet))
	if(i==1){
		net <- as.matrix(prednet)
		colnames(net) <- i
	} else {
		net <- cbind(net, prednet)
		colnames(net)[i] <- i
	}
	print(i)
}
setwd("..")
	
# get tf names and order them alphabetically, which is what is done by panda_run.m
tfs <- read.delim("input/motif_human.txt", header=F)
tfs <- unique(as.character(tfs[,1]))
tfs <- tfs[order(tfs)]

# get expression data, keep order of gene names as in expression data, as that is what panda_run.m outputs
exp <- read.delim("input/expression_human.txt", header=F, row.names=1)
genes <- row.names(exp)

# combine them in an edgelist that corresponds to the (:) command in matlab (which converts the matrix into a vector)
tfsnew <- rep(tfs,length(genes))
genesnew <- rep(genes, each=length(tfs))
edges <- cbind(tfsnew, genesnew)

sampleorderfile <- paste("input/sampleorder.txt", sep="")
samples <- scan(sampleorderfile, what="character")
colnames(net) <- samples
net <- as.data.frame(net)
row.names(net) <- 1:nrow(net)
edges <- edges[,1:2]
edges <- as.data.frame(edges, stringsAsFactors=F)
colnames(edges) <- c("reg","tar")
row.names(edges) <- 1:nrow(edges)
net <- cbind(edges, net)

save(list=c("net"), file="lionessResults.RData")

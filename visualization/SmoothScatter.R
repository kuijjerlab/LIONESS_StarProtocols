# Packages
	library(jamba)

# Functions
	CapStr <- function(y) {
	  c <- strsplit(y, " ")[[1]]
	  paste(toupper(substring(c, 1,1)), substring(c, 2),
	      sep="", collapse=" ")
	}

# Load the LIONESS networks
	load("../lioness_networks/yeast/pearson/lionessResults.RData")
	coexp <- lionessResults
	load("../lioness_networks/yeast/panda/lionessResults.RData")
	panda <- net

# Define samples of interest (5' time point for Pearson, 10' time point for PANDA)
	coexp_samples <- c(2,26)+2 # Adding 2 because the first 2 columns include edge information
	panda_samples <- c(3,27)+2

# Remove outliers (Pearson range [-6.25,6.25], PANDA range [-8,8])
	coexp_cut <- 6.25
	panda_cut <- 8
	
	coexp_dat <- coexp[,coexp_samples]
	coexp_rem <- which(coexp_dat[,1]<(-coexp_cut) | coexp_dat[,1]>coexp_cut | coexp_dat[,2]<(-coexp_cut) | coexp_dat[,2]>coexp_cut) # 1026/499500 edges removed
	coexp_dat <- coexp_dat[-coexp_rem,]

	panda_dat <- panda[,panda_samples]
	panda_rem <- which(panda_dat[,1]<(-panda_cut) | panda_dat[,1]>panda_cut | panda_dat[,2]<(-panda_cut) | panda_dat[,2]>panda_cut) # 207/362202 edges removed
	panda_dat <- panda_dat[-panda_rem,]

# Define axis labels
	axlabel_coexp <- paste("Sample", coexp_samples-2, sep=" ")
	axlabel_panda <- paste("Sample", panda_samples-2, sep=" ")

# Plot
	pdf("smoothScatter_Pearson.pdf", w=5, h=5)
		par(pty="s", mgp=c(2,0.5,0))
		plotSmoothScatter(coexp_dat, xlim=c(-6.25,6.25), ylim=c(-6.25,6.25), nrpoints=0, colramp = c("white", "gray", "purple2", "purple4", "black"), xaxt="n", yaxt="n", bandwidthN=500, main="Pearson Network Comparison")
		axis(side=1, at=seq(-6,6,by=3))
		mtext(axlabel_coexp[1], side=1, line=1.5)
		axis(side=2, at=seq(-6,6,by=3))
		mtext(axlabel_coexp[2], side=2, line=1.5)
	dev.off()
	pdf("smoothScatter_PANDA.pdf", w=5, h=5)
		par(pty="s", mgp=c(2,0.5,0))
		plotSmoothScatter(panda_dat, xlim=c(-8,8), ylim=c(-8,8), nrpoints=0, colramp = c("white", "gray", "purple2", "purple4", "black"), xaxt="n", yaxt="n", bandwidthN=500, main="PANDA Network Comparison")
		axis(side=1, at=seq(-8,8,by=4))
		mtext(axlabel_panda[1], side=1, line=1.5)
		axis(side=2, at=seq(-8,8,by=4))
		mtext(axlabel_panda[2], side=2, line=1.5)
	dev.off()
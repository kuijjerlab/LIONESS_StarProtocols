load('../lioness_networks/yeast/pearson/lionessResults.RData');
write.table(lionessResults, './Data/yeast_coexp_net.txt', quote=F, sep='\t', row.names=F, col.names=T);

load('../lioness_networks/panda/lionessResults.RData');
write.table(net, './Data/yeast_panda_net.txt', quote=F, sep='\t', row.names=F, col.names=T);

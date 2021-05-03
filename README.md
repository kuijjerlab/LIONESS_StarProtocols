# LIONESS STAR Protocols #
## Code to reproduce networks and figures from the LIONESS STAR Protocol ##

This GitHub repository contains the code to reproduce the networks modeled in the LIONESS STAR Protocols manuscript. The code and files are structured into two main folders. The first folder is titled `lioness_networks` and includes files and scripts to run the LIONESS networks. The second folder is titled `visualization` and includes scripts and data to reproduce Figure 2.

## Code to model individual sample networks ##
The code that is included in `lioness_networks` models four types of networks---networks modeled on data from human and yeast, using either Pearson correlation or PANDA as aggregate network reconstruction algorithms. We separated the files into two folders, one titled `human` and one titled `yeast`. For both organisms, we include two folders with data and scripts, one for the LIONESS networks modeled on Pearson correlation (folder `pearson`) and one for the LIONESS networks modeled on PANDA (folder `panda`).

### Networks based on Pearson correlation ###
The Pearson correlation networks are modeled with lionessR. The data that is included (file `exp.txt`) contains the 1000 most variable genes. The networks are be modeled with a simple R script titled `script.R`. The output is saved into a file titled `lionessResults.RData`.

### Networks based on PANDA ###
The PANDA networks are modeled on the gene expression data that we presented in the LIONESS paper, as well as a prior network of putative transcription factor-DNA binding (a "motif" prior) and protein-protein interactions ("ppi") between transcription factors. These files can be found in the `input` folder. This folder also includes a `sampleorder.txt` file, that is used to combine sample names with the output networks. The networks can be modeled by executing the `run_read_combine.sh` script. This script executes multiple scripts. It starts modeling an aggregate panda network by executing `panda_run.sh`, then runs each of the individual sample networks with `lioness_run.sh`. After this, it reads the MATLAB output files and prints them as .txt files (`read_and_print_networks.sh`), which are then loaded into R and combined into one matrix with edge information in `combine_networks.R`. The output is saved into a file titled `lionessResults.RData`.

## Code to reproduce Figure 2 ##
The folder `visualization` contains code to reproduce Figure 2.

### Visualization code ###
(1) `ExtractData.R`: convert the network files from RData to txt.
(2) `VizInitialData4.m`: Makes figures visualizing Pearson networks.
(3) `VizInitialData_PANDA4.m`: Makes figures visualizing the PANDA networks.

### Visualization folders ###
(1) Data: contains the original yeast gene expression data and the aggregate yeast PANDA network; where extracted networks will be written.
(2) Tools: contains additional matlab packages for the visualization.
(3) Figure: where the figures will be saved.

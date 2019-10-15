# Firt argument should be the URL
library(betty)
args <- as.list(commandArgs(TRUE))
args <- c(args, dest = "/data")
do.call(betty::update_universe, args)

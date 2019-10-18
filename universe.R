# Firt argument should be the URL
library(betty)
args <- as.list(commandArgs(TRUE))
# This can cause race conditions right now
#args <- c(args, dest = "/data")
args <- c(args, dest = tempdir())
do.call(betty::update_universe, args)

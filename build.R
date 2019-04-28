# Firt argument should be the URL
library(betty)
args <- commandArgs(TRUE)
remote <- args[1]
if(is.na(remote))
  stop("No remote argument provided")
build_site(remote, dest = "/data")

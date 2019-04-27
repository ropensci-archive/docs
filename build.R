# Firt argument should be the URL
library(betty)
args <- commandArgs(TRUE)
remote <- args[1]
if(is.na(remote))
  stop("No remote parameter provided")
deploy_org <- args[2]
build_site(remote, dest = "/data", deploy = deploy_org)

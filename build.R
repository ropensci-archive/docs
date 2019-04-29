# Firt argument should be the URL
library(betty)
args <- commandArgs(TRUE)
remote <- args[1]
if(is.na(remote)){
  build_all_sites(dest = "/data")
} else {
  build_site(remote, dest = "/data")
}

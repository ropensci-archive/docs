# Firt argument should be the URL
library(betty)
args <- commandArgs(TRUE)
repo <- args[1]
git_url <- args[2]
if(is.na(repo)){
  build_all_sites(dest = "/data")
} else {
  build_site(repo, dest = "/data", git_url = git_url)
}

# Container options
deploy_org = "ropensci-docs"
doc_root = "/data/docs"

# Firt argument should be the URL
library(betty)
args <- commandArgs(TRUE)
package <- args[1]
if(is.na(package)){
	deploy_all_sites(doc_root = doc_root, deploy_org = deploy_org)
} else {
	path <- paste0(doc_root, "/", package)
	deploy_site(path = path, deploy_org = deploy_org)
}

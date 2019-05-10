# Container options
deploy_org = "ropensci-docs"
site_root = "https://docs.ropensci.org"
doc_root = "/data/docs"

# Firt argument should be the URL
library(betty)
args <- commandArgs(TRUE)
package <- args[1]
if(is.na(package)){
	deploy_all_sites(doc_root = doc_root, deploy_org = deploy_org, site_root = site_root)
} else {
	path <- paste0(doc_root, "/", package)
	deploy_url <- paste0(site_root, "/", package)
	deploy_site(path = path, deploy_org = deploy_org, deploy_url = deploy_url)
}

# Firt argument should be the URL
library(betty)
deploy_all_sites(doc_root = "/data/docs", deploy_org = "ropensci-docs",
	site_root = 'https://docs.ropensci.org')

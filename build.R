# Firt argument should be the URL
options(menu.graphics=FALSE)
remote <- commandArgs(TRUE)[1]
if(is.na(remote))
  stop("No remote parameter set")

# Clone the URL and change dir
tmp <- tempfile()
gert::git_clone(remote, tmp)
#remotes::install_deps(tmp, dependencies = TRUE)
remotes::install_local(tmp, dependencies = TRUE, force = TRUE)

# Create source pkg
pkgfile <- pkgbuild::build(tmp, dest_path = tempdir())
pkg <- strsplit(basename(pkgfile), "_", fixed = TRUE)[[1]][1]

# Each pkg
title <- sprintf("rOpenSci package: %s", pkg)
url <- sprintf("https://docs.ropensci.org/%s", pkg)
dest <- sprintf("/data/docs/%s", pkg)
template <- list(package = "rotemplate")
pkgdown::build_site(tmp, document = FALSE, preview = FALSE, override = 
  list(destination = dest, title = pkg, url = url, template = template))

# Store the source pkg
dir.create("/data/src/", showWarnings = FALSE)
file.copy(pkgfile, "/data/src/")

# Firt argument should be the URL
options(menu.graphics=FALSE)
remote <- commandArgs(TRUE)[1]
if(is.na(remote))
  stop("No remote parameter set")

# Clone the URL and change dir
src <- tempfile()
gert::git_clone(remote, src)
#remotes::install_deps(tmp, dependencies = TRUE)
remotes::install_local(src, dependencies = TRUE, force = TRUE)

# Create source pkg
pkgfile <- pkgbuild::build(src, dest_path = tempdir())
pkg <- strsplit(basename(pkgfile), "_", fixed = TRUE)[[1]][1]

# Each pkg
title <- sprintf("rOpenSci: %s", pkg)
url <- sprintf("https://docs.ropensci.org/%s", pkg)
dest <- sprintf("/data/docs/%s", pkg)
tmp <- paste0(dest, "_TMP")
template <- list(package = "rotemplate")
unlink(tmp, recursive = TRUE)
pkgdown::build_site(src, document = FALSE, preview = FALSE, override = 
  list(destination = tmp, title = title, url = url, template = template))
file.rename(tmp, dest)

# Store the source pkg
dir.create("/data/src/", showWarnings = FALSE)
file.copy(pkgfile, "/data/src/", overwrite = TRUE)

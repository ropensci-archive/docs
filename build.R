# Fixed settings
options(menu.graphics = FALSE)
doc_dir <- "/data/docs/"
src_dir <- "/data/src/"

# Firt argument should be the URL
remote <- commandArgs(TRUE)[1]
if(is.na(remote))
  stop("No remote parameter set")

# Clone the URL and change dir
src <- tempfile()
gert::git_clone(remote, src)
setwd(src)
#remotes::install_deps(tmp, dependencies = TRUE)
remotes::install_local(dependencies = TRUE, force = TRUE)

if(!file.exists('DESCRIPTION'))
  stop("Not an R package")

# Create source pkg
pkgfile <- pkgbuild::build(dest_path = tempdir())
pkg <- strsplit(basename(pkgfile), "_", fixed = TRUE)[[1]][1]

# Each pkg
title <- sprintf("rOpenSci: %s", pkg)
url <- sprintf("https://docs.ropensci.org/%s", pkg)
dest <- paste0(doc_dir, pkg)
tmp <- paste0(dest, "_TMP")
template <- list(package = "rotemplate")
unlink(tmp, recursive = TRUE)
pkgdown::build_site(document = FALSE, preview = FALSE, override =
  list(destination = tmp, title = title, url = url, template = template))
unlink(dest, recursive = TRUE)
file.rename(tmp, dest)

# Store the source pkg and update repo
dir.create(src_dir, showWarnings = FALSE)
unlink(sprintf("%s%s_*.tar.gz", src_dir, pkg))
file.copy(pkgfile, src_dir)
tools::write_PACKAGES(src_dir)

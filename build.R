# Fixed settings
options(menu.graphics = FALSE)
doc_dir <- "/data/docs/"
src_dir <- "/data/src/"

# Workaround for pkgbuild
dir.create("~/.R", showWarnings = FALSE)
file.create("~/.R/Makevars", showWarnings = FALSE)

# Firt argument should be the URL
remote <- commandArgs(TRUE)[1]
if(is.na(remote))
  stop("No remote parameter set")

# Clone the URL and change dir
src <- tempfile()
gert::git_clone(remote, src)
setwd(src)
if(!file.exists('DESCRIPTION'))
  stop("Not an R package")

# Build and install
remotes::install_deps(dependencies = TRUE)
pkgfile <- pkgbuild::build(dest_path = tempdir())
remotes::install_local(pkgfile, build = FALSE)
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

# Store the source pkg and update repo
dir.create(src_dir, showWarnings = FALSE)
unlink(sprintf("%s%s_*.tar.gz", src_dir, pkg))
file.copy(pkgfile, src_dir)
tools::write_PACKAGES(src_dir)

# Get upstream commit state
commit <- gert::git_log(max = 1, repo = src)
commit_url <- paste0(remote, "/commit/", substring(commit$commit,1,7))
commit_message <- sprintf('Render from %s (%s...)', commit_url, 
  substring(trimws(commit$message), 1, 25))

# Deploy website
setwd(tmp)
gert::git_init()
gert::git_config_set('user.name', "Betty Builder")
gert::git_config_set('user.email', "noreply@ropensci.org")
gert::git_add(".")
gert::git_commit_all(commit_message)
gert::git_remote_add('origin', paste0('https://github.com/ropensci-docs/', pkg))
gert::git_branch_create("gh-pages")

# Create repo if needed and push
info <- tryCatch(gh::gh(paste0("/repos/ropensci-docs/", pkg)), http_error_404 = function(e){
  cat(sprintf("Creating new repo ropensci-docs/%s\n", pkg))
  gh::gh("/orgs/ropensci-docs/repos", .method = "POST",
    name = pkg,
    has_issues = FALSE,
    has_wiki = FALSE,
    has_downloads = FALSE,
    homepage = url,
    description = paste0("auto-generated pkgdown website for ropensci/", pkg)
  )
})
gert::git_push('origin', '+refs/heads/gh-pages:refs/heads/gh-pages')

# Move to final location
unlink(dest, recursive = TRUE)
file.rename(tmp, dest)

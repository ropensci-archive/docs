# Base tools to generate pkgdown site
options(menu.graphics = FALSE)
install.packages("remotes")
remotes::install_github(c("r-lib/pkgdown", "r-lib/gert", "r-lib/gh"), upgrade = TRUE)
remotes::install_github("ropensci/rotemplate", upgrade = TRUE)

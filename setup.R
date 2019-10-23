# Base tools to generate pkgdown site
options(menu.graphics = FALSE, repos = "https://cloud.r-project.org")

# Many packages use devtools in their README.rmd
install.packages(c("devtools", "testthat"))
remotes::install_github("jeroen/betty")

# Fixes https://github.com/rstudio/rmarkdown/issues/1667
remotes::install_github("rstudio/rmarkdown")

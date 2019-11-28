# Base tools to generate pkgdown site
options(menu.graphics = FALSE, repos = "https://cloud.r-project.org")

# Many packages use devtools in their README.rmd
install.packages(c("devtools", "testthat"))
remotes::install_github("jeroen/betty")

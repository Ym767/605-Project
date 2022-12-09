rm(list=ls())

args = (commandArgs(trailingOnly=TRUE))
if(length(args) == 1){
  RpackagesDir = args[1]
} else {
  cat('usage: Rscript Install.R <RpackagesDir>\n', file=stderr())
  stop()
}

# Tell R to search in RpackagesDir, in addition to where it already
# was searching, for installed R packages.
.libPaths(new=c(RpackagesDir, .libPaths()))
if (!require("tsfknn")) { # If loading package fails ...
  # Install package in RpackagesDir.
  install.packages(pkgs="tsfknn", lib=RpackagesDir, repos="https://cran.r-project.org")
  stopifnot(require("tsfknn")) # If loading still fails, quit.
}



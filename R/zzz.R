## load colour scheme for CPD and WF plots into R options
.onLoad <- function(libname, pkgname) {
   op <- options()
   op.kptech <- list(
      kptech.colour.datapoints = "#AA8F39",
      kptech.colour.fitline    = "#363377"
   )
   toset <- !(names(op.kptech) %in% names(op))
   if (any(toset)) options(op.kptech[toset])

   invisible()
}

## http://r-pkgs.had.co.nz/r.html

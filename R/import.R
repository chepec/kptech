#' Read data from KP single-point measurement
#'
#' Extracts data from Kelvin probe single-point measurements in *.dat (ASCII) files.
#'
#' @param datafile  string with full path to datafile
#'
#' @return Dataframe with the following columns:
#'    $ point         : integer
#'    $ CPD           : mV     ## denoted WF in source file
#'    $ CPD.mean      : mV     ## denoted WF in source file
#'    $ CPD.sd        : mV     ## denoted WF in source file
#'    $ GD            : au
#'    $ GD.sd         : au
#'    $ steps         : au
#'    $ RH            : relative humidity %
#'    $ temperature   : degrees Celsius
#'    $ time          : seconds
#'    $ substrateid   : chr
#'    $ sampleid      : chr
#' @export
dat2df <- function(datafile) {
      ## Value:

   #

   df <-
      utils::read.csv(datafile, header = TRUE, sep = ",", strip.white = TRUE,
                      col.names = c("point", "CPD", "CPD.mean", "CPD.sd",
                                    "GD", "GD.sd", "steps", "RH", "temperature", "time"))
   # convert $point to numeric (strip extraneous "=")
   df$point <- as.numeric(sub("=", "", df$point))

   # Create a sampleid for the current job
   df$sampleid <- common::ProvideSampleId(datafile, implementation = "filename")

   return(df)
}

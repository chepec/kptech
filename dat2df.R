source(HomeByHost("/home/taha/chepec/chetex/common/R/common/ProvideSampleId.R"))

##################################################
################### dat2df #######################
##################################################
dat2df <- function(datafile) {
   ## Description:
   ##   Extracts data from Kelvin probe single-point measurements
   ##   in *.dat (ASCII) files.
   ## Usage:
   ##   dat2df(datafile)
   ## Arguments:
   ##   datafile: text string with full path to DAT file
   ##             containing a measurement
   ## Value:
   ##   Dataframe with the following columns:
   ##   $ point         : integer
   ##   $ CPD           : mV     ## denoted WF in source file
   ##   $ CPD.mean      : mV     ## denoted WF in source file
   ##   $ CPD.sd        : mV     ## denoted WF in source file
   ##   $ GD            : au
   ##   $ GD.sd         : au
   ##   $ steps         : au
   ##   $ RH            : relative humidity %
   ##   $ temperature   : degrees Celsius
   ##   $ time          : seconds
   ##   $ substrateid   : chr
   ##   $ sampleid      : chr
   #
   
   df <- 
      read.csv(datafile, header = TRUE, sep = ",", strip.white = TRUE, 
               col.names = c("point", "CPD", "CPD.mean", "CPD.sd", 
                             "GD", "GD.sd", "steps", "RH", "temperature", "time")) 
   # convert $point to numeric (strip extraneous "=")
   df$point <- as.numeric(sub("=", "", df$point))

   # Create a sampleid for the current job (use the folder name)
   df$substrateid <- ProvideSampleId(datafile, implementation = "dirname")
   df$sampleid <- ProvideSampleId(datafile, implementation = "filename")
   
   return(df)
}

#' Calculate WF of tip
#'
#' @param CPD      measured contact potential difference value (in mV)
#' @param WF.gold  the standard WF of gold (default 5100 mV)
#'
#' @return scalar, work function of tip
#' @export
WF.tip <- function(CPD, WF.gold = 5100) {
   ## first step in determination of work function of sample:
   ## calculate the tip's work function
   WF <- WF.gold - CPD
   return(WF)
}


#' Calculate WF of sample
#'
#' @param CPD       measured CPD (in mV)
#' @param WF.tip    the known WF of the tip (in mV)
#' @param version   use version="2"
#'
#' @details use version="2", it calculates more data for you (mean, sd, etc.)
#'
#' @return depends on version, "2" returns a dataframe, "1" a scalar
#' @export
WF.sample <- function(CPD, WF.tip, version = "2") {
   ## second step in determination of work function of sample:
   ## calculate the sample's work function
   if (version == "1") {
      WF <- WF.tip + CPD
      return(WF)
   }
   #
   if (version == "2") {
      # I realised it's better to calculate wf, wf.mean and wf.final
      # immediately inside the function, instead of having to do
      # it outside.
      # But this means that this function will return more than one
      # column, and I decided to return them as a dataframe.
      # That way, you should be able to just cbind() this function's
      # output to your data.
      df <-
         # make wf negative to adhere to commonly used AVS scale
         data.frame(wf = -(WF.tip + CPD))
      # wf.mean is the "running" mean (vector of values)
      df$wf.cummean <- dplyr::cummean(df$wf) # previously wf.mean
      # wf.final is the final mean (vector of one, unique value)
      df$wf.mean <- mean(df$wf) # previously wf.final
      # median
      df$wf.median <- stats::median(df$wf)
      # dispersion measures
      df$wf.sd <- stats::sd(df$wf)
      df$wf.mad <- stats::mad(df$wf)
      return(df)
   }
   #
   return("Error in WF.sample(): please supply an allowed version string")
}

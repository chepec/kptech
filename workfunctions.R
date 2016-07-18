WF.tip <- function(CPD, WF.gold = 5100) {
   ## first step in determination of work function of sample:
   ## calculate the tip's work function
   WF <- WF.gold - CPD
   return(WF)
}


WF.sample <- function(CPD, WF.tip) {
   ## second step in determination of work function of sample:
   ## calculate the sample's work function
   WF <- WF.tip + CPD
   return(WF)
}

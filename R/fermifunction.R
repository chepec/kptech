#' The Fermi function
#'
#' @param energy      numeric vector, eV (must be supplied)
#' @param temperature numeric, temperature/Kelvin, default 0 K
#' @param fermilevel  numeric, energy/eV NB: make sure this lies \emph{within} the range of the supplied energy vector. Defaults to Ef of gold, 5.100 eV.
#'
#' @return Dataframe with the following columns (and no extra attributes):
#'    $ energy           : numeric, the supplied energy range
#'    $ fermilevel       : numeric, the supplied fermi level
#'    $ temperature      : numeric, the supplied temperature
#'    $ fermi.occupied   : probability an electron state is occupied
#'    $ fermi.unoccupied : probability an electron state is unoccupied
#' @export
#'
#' @examples \dontrun{Fermi(seq(1, 10, 0.1), temperature = 400, fermilevel = 5.5)}
Fermi <- function(energy,
                  temperature = 0,
                  fermilevel = 5.100) {

   # defines Boltzmann's constant
   Boltzmanns.constant <- 8.6173303E-5 # eV per Kelvin

   # check that fermilevel lies _within_ the energy vector
   stopifnot((fermilevel < max(energy)) && (fermilevel > min(energy)))

   fermi.df <-
      data.frame(energy = energy,
                 fermilevel = fermilevel,
                 temperature = temperature,
                 fermi.occupied = 1 / (exp((energy - fermilevel) /
                                              (Boltzmanns.constant * temperature)) + 1))

   # f(E == EF) => 0.5 requires a check and correction, because otherwise
   # zero divided by kT evaluates to NaN
   fermi.df$fermi.occupied[which(fermi.df$energy == fermilevel)] <- 0.5

   fermi.df$fermi.unoccupied <- 1 - fermi.df$fermi.occupied

   return(fermi.df)
}

instalar_paquetes_cran <- function(paquetes) {

  paquetes <- unique(paquetes)
  paquetes_nuevos <- paquetes[!(paquetes %in% installed.packages()[, "Package"])]

  for(pqt in paquetes_nuevos)
    install.packages(pqt, dependencies = TRUE, upgrade = "always")

  sapply(paquetes, require, character = TRUE)
}

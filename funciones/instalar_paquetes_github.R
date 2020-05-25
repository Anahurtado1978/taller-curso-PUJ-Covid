instalar_paquetes_github <- function(paquetes_github) {

  paquetes_github      <- unique(paquetes_github)
  paquetes_github_nom  <- vector("list", length(paquetes_github))
  paquetes_github_repo <- vector("list", length(paquetes_github))
  i = 0
  for (pqtgn in paquetes_github) {
    i = i + 1
    paquetes_github_repo[[i]] <- strsplit(pqtgn, "/")[[1]][1]
    paquetes_github_nom[[i]]  <- strsplit(pqtgn, "/")[[1]][2]
  }

  paquetes_github_nom  <- unlist(paquetes_github_nom)
  paquetes_github_repo <- unlist(paquetes_github_repo)

  df.paqs_github <- data.frame(
    repo = paquetes_github_repo,
    paquete = paquetes_github_nom,
    repopaq = paste0(paquetes_github_repo, "/", paquetes_github_nom)
  )

  paquetes_github_nuevos <-
    paquetes_github_nom[!(paquetes_github_nom %in% installed.packages()[, "Package"])]
  df.paqs_github_nuevos <- subset(df.paqs_github, paquete %in% paquetes_github_nuevos)

  paquetes_github_nuevos_full <- as.character( unlist(df.paqs_github_nuevos$repopaq))

  for (pqtg in paquetes_github_nuevos_full)
    install_github(pqtg, dependencies = TRUE, upgrade = "always", force = TRUE)

  sapply(paquetes_github_nom, require, character = TRUE)
}

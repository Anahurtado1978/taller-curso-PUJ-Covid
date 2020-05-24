# 00-Configuracion.R
# 1. Instala los paquetes R requeridos
# 2. Crea subdirectorios
# 3. Carga algunas funciones


# instala devtools and backports

if (!require(backports)) {
install.packages("backports")
  library(backports)
}

if (!require(devtools)) {
  install.packages("devtools")
  library(devtools)
}


# actualizar paquetes actualmente en su pc - demorado!
# update.packages(ask = FALSE, dependencies = c('Suggests'))


# Lista de paquetes a instalar

paquetes <-
  c(
    "av",
    "bayesplot",
    "cowplot",
    "curl",
    "data.table",
    "DataExplorer",
    "descr",
    "DescTools",
    "digest",
    "dplyr",
    "DT",
    "EpiEstim",
    "flextable",
    "forcats",
    "foreign",
    "formattable",
    "geoR",
    "gganimate",
    "gghighlight",
    "ggpubr",
    "gifski",
    "glue",
    "gridExtra",
    "hexbin",
    "incidence",
    "kableExtra",
    "knitr",
    "Matrix",
    "magrittr",
    "officer",
    "pander",
    "png",
    "processx",
    "projections",
    "readr",
    "readxl",
    "reshape2",
    "rgeos",
    "rJava",
    "rlang",
    "rmarkdown",
    "RSocrata",
    "sf",
    "stringi",
    "stringr",
    "survival",
    "tables",
    "tibble",
    "tidyr",
    "tidytext",
    "tinytex",
    "transformr",
    "visdat",
    "xfun",
    "xlsx",
    "xtable"
  )

paquetes_github <- c(
  "tidyverse/ggplot2",
  "tidyverse/tibble"
  )


# Instalación de paquetes


# CRAN repo

paquetes <- unique(paquetes)
paquetes_nuevos <- paquetes[!(paquetes %in% installed.packages()[, "Package"])]

for(pqt in paquetes_nuevos)
  install.packages(pqt, dependencies = TRUE, upgrade = "always")
sapply(paquetes, require, character = TRUE)


# Github

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


# Crear subdirectorios del proyecto

if (!dir.exists("data"))      {dir.create("data")}
if (!dir.exists("salidas"))   {dir.create("salidas")}
if (!dir.exists("figuras"))   {dir.create("figuras")}
if (!dir.exists("imagenes"))  {dir.create("imagenes")}
if (!dir.exists("funciones")) {dir.create("funciones")}
if (!dir.exists("shapes"))    {dir.create("shapes")}


# cargar las funciones

funciones <- list.files(path = "/funciones", full.names = TRUE)
sapply(funciones, source)

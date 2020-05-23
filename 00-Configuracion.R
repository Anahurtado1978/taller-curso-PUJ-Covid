# 00-Configuracion.R
# 1. Instala los paquetes R requeridos
# 2. Crea subdirectorios
# 3. Carga algunas funciones

# instala devtools - puede ser demorado
if (!require(devtools)) {
  install.packages("devtools")
  library(devtools)
}

# actualizar paquetes actualmente en su pc - demorado!
# update.packages(ask = FALSE, dependencies = c('Suggests'))

# Lista de paquetes a instalar

paquetes <-
  c("Rcpp", "ggpubr","gghighlight","tidyverse",
    "RSocrata",  "rlang","remotes","ps",
    "here", "sf", "rgeos", "earlyR",
    "curl", "projections", "incidence", "EpiEstim",
    "rJava","bayesplot","cowplot","gridExtra", "ps",
    "rmarkdown", "geoR", "usethis","glue",
    "tinytex","digest", "testthat","processx","reshape2",
    "data.table", "readxl",
    "xlsx", "readr", "dplyr", "stringr", "knitr", "tidyr",
    "foreign", "DataExplorer", "formattable",
    "survival", "xtable", "officer", "DescTools",
    "DT", "flextable", "pander", "descr", "tables",
    "visdat", "xfun", "tidytext","stringi", "Matrix",
    "hexbin","gganimate","gifski","png",
    "transformr","av","forcats"
    )

paquetes_github <-
  c("tidyverse/tibble", "tidyverse/ggplot2")


# Instalación de paquetes

# CRAN repo
paquetes <- unique(paquetes)
paquetes_nuevos <- paquetes[!(paquetes %in% installed.packages()[, "Package"])]
for(pqt in paquetes_nuevos)
  install.packages(pqt, dependencies = TRUE, upgrade = "always")
sapply(paquetes, require, character = TRUE)

# Versiones espcificas - manual
install_version("ps", version = "1.3.3",
                dependencies = TRUE, upgrade = "always",
               force = TRUE)
require(ps)

# Github
paquetes_github     <- unique(paquetes_github)
paquetes_github_nom <- vector("list", length(paquetes_github))
i=0
for (pqtgn in paquetes_github) {
  i = i + 1
  paquetes_github_nom[[i]] <- strsplit(pqtgn, "/")[[1]][2]
}
paquetes_github_nom <- unlist(paquetes_github_nom)
for (pqtg in paquetes_github)
  install_github(pqtg, dependencies = TRUE, upgrade = "always",
                 force = TRUE)
sapply(paquetes_github_nom, require, character = TRUE)


# Crear subdirectorios del proyecto

if (!dir.exists("data"))      {dir.create("data")}
if (!dir.exists("salidas"))   {dir.create("salidas")}
if (!dir.exists("figuras"))   {dir.create("figuras")}
if (!dir.exists("imagenes"))  {dir.create("imagenes")}
if (!dir.exists("funciones")) {dir.create("funciones")}
if (!dir.exists("shapes"))    {dir.create("shapes")}


# Funciones definidas por usuario

# Funcion para corregir año en algunas fechas con error e.g. 1950

correct_year <- function(xdate, year_ok) {
  lubridate::make_date(year  = ifelse(year(xdate) < 2019,
                                      as.numeric(year_ok),
                                      year(xdate) ),
                       month = month(xdate),
                       day   = mday(xdate)
  )
}

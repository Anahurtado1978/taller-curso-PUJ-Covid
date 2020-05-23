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
  c("Rcpp", "forcats","ggpubr","gghighlight",
    "RSocrata",  "rlang",
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
    "transformr","av"
    )

paquetes_github <-
  c("tidyverse/tibble", "tidyverse/ggplot2")


# Instalación de paquetes

paquetes <- unique(paquetes)
for(pqt in paquetes)
  install.packages(pqt, dependencies = TRUE)
sapply(paquetes, require, character = TRUE)

paquetes_github     <- unique(paquetes_github)
paquetes_github_nom <- vector("list", length(paquetes_github))

i=0
for (pqtgn in paquetes_github) {
  i = i + 1
  paquetes_github_nom[[i]] <- strsplit(pqtgn, "/")[[1]][2]
}
paquetes_github_nom <- unlist(paquetes_github_nom)

for (pqtg in paquetes_github)
  devtools::install_github(pqtg, dependencies = TRUE)
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

# 00-Configuracion.R
# 1. Instala los paquetes R requeridos
# 2. Crea subdirectorios
# 3. Carga algunas funciones

# instala devtools - puede ser demorado
if (!require(devtools)) {
  install.packages("devtools")
  library(devtools)
}

# Actualizar paquetes actualmente en su pc
#  quitar comentario en la siguiente linea
#  el proceso se demora ~20+ minutos en algunos casos
# update.packages(ask = FALSE, dependencies = c('Suggests'))

# Lista de paquetes a instalar

lista_paquetes <-
  c("tidyverse/ggplot2",
    "forcats","ggpubr","gghighlight", "RSocrata",
    "tidyverse", "rlang",
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
    "tidyverse/tibble",
    "transformr","av"
    )

# Instalación de paquetes

lista_paquetes <- unique(lista_paquetes)

for (pqt in lista_paquetes) {
  print(pqt)
}

pqt_nom <- ""
for (pqt in lista_paquetes) {
  print(pqt)
  if ( grepl("/", pqt) ) {
    pqt_nom <- as.name(strsplit(pqt,"/")[[1]][2])
    devtools::install_github(pqt)
  } else {
    pqt_nom <- as.name(pqt)
    install.packages(pqt_nom)
  }
  library(pqt_nom)
}

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

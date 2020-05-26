## 00-configuracion.R ####

# 1. Crea subdirectorios del proyecto
# 2. Instala los paquetes R requeridos
# 3. Carga funciones requeridas y tokens


# Quitar el comentario de la linea siguiente si desea
# forzar actualizacion de todos los paquetes (DEMORADO!!!)
# update.packages(ask = FALSE, dependencies = c('Suggests'))


## Crear subdirectorios si no existen ####

if (!dir.exists("data"))      {dir.create("data")}
if (!dir.exists("salidas"))   {dir.create("salidas")}
if (!dir.exists("figuras"))   {dir.create("figuras")}
if (!dir.exists("imagenes"))  {dir.create("imagenes")}
if (!dir.exists("shapes"))    {dir.create("shapes")}
if (!dir.exists("funciones")) {dir.create("funciones")}
if (!dir.exists("tokens"))    {dir.create("tokens")}


## Cargar las funciones y tokens ####

funciones <- list.files(path = "funciones", full.names = TRUE)
sapply(funciones, source)

tokens <- list.files(path = "tokens", full.names = TRUE)
sapply(tokens, source)



## Instala devtools and backports ####

if (!require(backports)) {
  install.packages("backports")
  library(backports)
}

if (!require(devtools)) {
  install.packages("devtools")
  library(devtools)
}

## Lista de paquetes CRAN a instalar ####

paquetes <-
  c(
    "av",
    "bayesplot",
    "boxr",
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

instalar_paquetes_cran(paquetes)

## Lista de paquetes github a installar ####

paquetes_github <- c(
  "tidyverse/ggplot2",
  "tidyverse/tibble"
)

instalar_paquetes_github(paquetes_github)


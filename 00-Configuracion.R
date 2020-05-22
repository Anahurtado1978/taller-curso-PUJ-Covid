# 00-Configuracion.R
#
# Instala los paquetes R requeridos
# Crea subdirectorios

# Actualizar paquetes actualmente en su pc
#  quitar comentario en la siguiente linea
#  el proceso se demora ~20+ minutos en algunos casos
# update.packages(ask = FALSE, dependencies = c('Suggests'))

# Lista de paquetes a instalar

packages <-
  c(
    "tidyverse", "tibble",
    "forcats","ggpubr","gghighlight", "RSocrata",
    "here", "sf", "rgeos", "earlyR",
    "curl","projections","incidence","EpiEstim",
    "rJava","bayesplot","cowplot","gridExtra", "ps",
    "rmarkdown", "geoR", "usethis","glue",
    "tinytex","digest", "testthat","processx","reshape2",
    "data.table", "readxl",
    "xlsx", "readr", "dplyr", "stringr", "knitr", "tidyr",
    "foreign", "DataExplorer", "formattable",
    "survival", "xtable", "officer", "DescTools",
    "DT", "flextable", "pander", "descr", "tables",
    "visdat", "xfun", "tidytext","stringi", "Matrix",
    "hexbin","gganimate","gifski","png","transformr","av"
  )


# Lista de paquetes adicionales que se instalan desde github

pkgs_from_github <-
  c(
    "tidyverse/ggplot2",
    "tidyverse/tibble"
    )


# Instalación de paquetes

# Instalar paquetes de github primero

if (!require("devtools") & length(pkgs_from_github) > 0) {
  install.packages("devtools", dependencies = TRUE, INSTALL_opts = '--no-lock')
  library(devtools)
}

for (pkg_github in pkgs_from_github) {
  pkg_name <- strsplit(pkg_github,"/")[[1]][2] # get name after forward-slash
  if (!require(pkg_name, character.only = T, quietly = T)) {
    devtools::install_github(pkg_github, dependencies = TRUE)
    library(pkg_name, character.only = T)
  }
  library(pkg_name, character.only = T)
}

# Cargar los paquetes de github instalados
for (package in pkgs_from_github) {
  pkg_name <- strsplit(pkg_github,"/")[[1]][2] # get name after forward-slash
  library(pkg_name, character.only = T)
}

# Instalar el resto de packages

new.packages <- packages

# quitar comentario a la linea siguiente si desea instalar
# solo paquetes nuevos en la lista packages

# new.packages <- packages[!(packages %in% installed.packages()[, "Package"])]

for (package in new.packages) {
  if (!require(package, character.only = T, quietly = T)) {
    install.packages(package, dependencies = TRUE, INSTALL_opts = '--no-lock')
    library(package, character.only = T)
  }
  library(package, character.only = T)
}

# Cargar el resto de paquetes instalados
for (package in packages) {
  library(package, character.only = T)
}

# forzar instalacion de versiones especificas de paquetes
devtools::install_version("tibble", version = "3.0.1", dependencies = TRUE)
# repos = "http://cran.us.r-project.org"
library(tibble)

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

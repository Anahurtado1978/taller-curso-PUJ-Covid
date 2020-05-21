# 00-Configuracion.R
#
# Instala los paquetes R requeridos
# Crea subdirectorios

# Paquetes a instalar
packages <-
  c(
    "forcats","ggpubr","gghighlight", "RSocrata",
    "here", "sf", "rgeos", "earlyR",
    "curl","projections","incidence","EpiEstim",
    "rJava","bayesplot","cowplot","gridExtra", "ps",
    "rmarkdown", "geoR","glue","usethis",
    "tinytex","digest", "testthat","processx","reshape2",
    "data.table", "readxl", "tidyverse",
    "xlsx", "readr", "dplyr", "stringr", "knitr", "tidyr",
    "foreign", "DataExplorer", "formattable",
    "survival", "xtable", "officer", "DescTools",
    "DT", "flextable", "pander", "descr", "tables",
    "visdat", "xfun", "tidytext","stringi", "Matrix",
    "hexbin","gganimate","gifski","png","transformr","av"
  )

# Algunos paquetes se instalan desde github
pkgs_from_github <- c("tidyverse/ggplot2")


# Instalar packages
new.packages <- packages[!(packages %in% installed.packages()[, "Package"])]
for (package in new.packages) {
  if (!require(package, character.only = T, quietly = T)) {
    install.packages(package, dependencies = T)
    library(package, character.only = T)
  }
  library(package, character.only = T)
}

# Instalar paquetes de github
for (pkg_github in pkgs_from_github) {
  pkg_name <- strsplit(pkg_github,"/")[[1]][2] # get name after forward-slash
  if (!require(pkg_name, character.only = T, quietly = T)) {
    devtools::install_github(pkg_github)
    library(pkg_name, character.only = T)
  }
  library(pkg_name, character.only = T)
}

# Cargar los paquetes de github instalados
for (package in pkgs_from_github) {
  pkg_name <- strsplit(pkg_github,"/")[[1]][2] # get name after forward-slash
  library(pkg_name, character.only = T)
}

# Cargar los paquetes instalados
for (package in packages) {
  library(package, character.only = T)
}

# Funcion para corregir año en algunas fechas con error e.g. 1950
correct_year <- function(xdate, year_ok) {
  lubridate::make_date(year  = ifelse(year(xdate) < 2019,
                                      as.numeric(year_ok),
                                      year(xdate) ),
                       month = month(xdate),
                       day   = mday(xdate)
  )
}

# Crear subdirectorios
if (!dir.exists("data"))      {dir.create("data")}
if (!dir.exists("salidas"))   {dir.create("salidas")}
if (!dir.exists("figuras"))   {dir.create("figuras")}
if (!dir.exists("imagenes"))  {dir.create("imagenes")}
if (!dir.exists("funciones")) {dir.create("funciones")}
if (!dir.exists("shapes"))    {dir.create("shapes")}


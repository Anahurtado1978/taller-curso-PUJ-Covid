# 10-Obtener-datos-INS

# Fecha actual
hoy <- as.Date(format(Sys.Date(), "%Y-%m-%d"))

library(RSocrata)
token <- "ew2rEMuESuzWPqMkyPfOSGJgE"
df.ins <- read.socrata("https://www.datos.gov.co/resource/gt2j-8ykr.json", app_token = token)

# fechas clave del INS
df.ins$fecha_sin <- as.Date(df.ins$fis, format = "%Y-%m-%d")
df.ins$fecha_not <- as.Date(df.ins$fecha_de_notificaci_n, format = "%Y-%m-%d")

# otras fechas importantes INS
df.ins$fecha_dx  <- as.Date(df.ins$fecha_diagnostico, format = "%Y-%m-%d")
df.ins$fecha_def <- as.Date(df.ins$fecha_de_muerte, format = "%Y-%m-%d")

# otras fechas en los datos del INS
df.ins$fecha_rec <- as.Date(df.ins$fecha_recuperado, format = "%Y-%m-%d")
df.ins$fecha_rpw <- as.Date(df.ins$fecha_reporte_web, format = "%Y-%m-%d")

# algunas fechas especificas
ins_max_fecha_not <- with(df.ins, max(fecha_not, na.rm = TRUE))
ins_min_fecha_not <- with(df.ins, min(fecha_not, na.rm = TRUE))
ins_max_fecha_sin <- with(df.ins, max(fecha_sin, na.rm = TRUE))
ins_min_fecha_sin <- with(df.ins, min(fecha_sin, na.rm = TRUE))

# tipo caso: confirmados y fallecidos
df.ins$tipo_caso <- "Confirmados"
df.ins$tipo_caso[which(df.ins$atenci_n=="Fallecido" | df.ins$estado=="Fallecido")] <- "Fallecidos"

# mover campos importantes (fechas, ajuste_) al principio
df.ins <- df.ins %>%
  dplyr::select(id_de_caso,
                tipo_caso,
                fecha_not,
                fecha_sin,
                fecha_dx,
                fecha_def,
                everything())


if (!dir.exists("data")) {dir.create("data")}


# Colombia
write_csv(df.ins,
          paste0("data/", "datos_ins_colombia.csv"))

# salvar una copia de los datos de Colombia en csv
write_csv(df.ins,
          paste0("data/", hoy, "-datos_ins-colombia-fecnot-", ins_max_fecha_not, ".csv"))


# Cali
df.ins.cali <- df.ins %>%
  filter(codigo_divipola=="76001" | ciudad_de_ubicaci_n=="Cali")

# salvar una copia de los datos de Cali en csv
write_csv(df.ins.cali,
          paste0("data/", "datos_ins_cali.csv"))
write_csv(df.ins.cali,
          paste0("data/", hoy, "-datos_ins-cali-fecnot-", ins_max_fecha_not, ".csv"))

# algunas fechas especificas
ins_max_fecha_not.cali <- with(df.ins.cali, max(fecha_not, na.rm = TRUE))
ins_min_fecha_not.cali <- with(df.ins.cali, min(fecha_not, na.rm = TRUE))
ins_max_fecha_sin.cali <- with(df.ins.cali, max(fecha_sin, na.rm = TRUE))
ins_min_fecha_sin.cali <- with(df.ins.cali, min(fecha_sin, na.rm = TRUE))

# Palmira
df.ins.palmira <- df.ins %>%
  filter(codigo_divipola=="76520" | ciudad_de_ubicaci_n=="Palmira")

# salvar una copia de los datos de Palmira en csv
write_csv(df.ins.palmira,
          paste0("data/", "datos_ins_palmira.csv"))
write_csv(df.ins.palmira,
          paste0("data/", hoy, "-datos_ins-palmira-fecnot-", ins_max_fecha_not, ".csv"))


# Buenaventura
df.ins.bventura <- df.ins %>%
  filter(codigo_divipola=="76109" | ciudad_de_ubicaci_n=="Buenaventura")

# salvar una copia de los datos de Bventura en csv
write_csv(df.ins.bventura,
          paste0("data/", "datos_ins_bventura.csv"))
write_csv(df.ins.bventura,
          paste0("data/", hoy, "-datos_ins-bventura-fecnot-", ins_max_fecha_not, ".csv"))

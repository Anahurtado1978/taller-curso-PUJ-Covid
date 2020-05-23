# 10-Obtener-datos-INS
library(tidyverse)

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
write_csv(df.ins,
          paste0("data/", hoy, "-datos_ins-colombia-fecnot-", ins_max_fecha_not, ".csv"))
ins_max_fecha_not <- with(df.ins, max(fecha_not, na.rm = TRUE))
ins_min_fecha_not <- with(df.ins, min(fecha_not, na.rm = TRUE))
ins_max_fecha_sin <- with(df.ins, max(fecha_sin, na.rm = TRUE))
ins_min_fecha_sin <- with(df.ins, min(fecha_sin, na.rm = TRUE))
saveRDS(df.ins, file = "data/Colombia.RDS")


# Cali
df.ins.cali <- df.ins %>%
  filter(codigo_divipola=="76001" | ciudad_de_ubicaci_n=="Cali")
write_csv(df.ins.cali,
          paste0("data/", "datos_ins_cali.csv"))
write_csv(df.ins.cali,
          paste0("data/", hoy, "-datos_ins-cali-fecnot-", ins_max_fecha_not, ".csv"))
ins_max_fecha_not.cali <- with(df.ins.cali, max(fecha_not, na.rm = TRUE))
ins_min_fecha_not.cali <- with(df.ins.cali, min(fecha_not, na.rm = TRUE))
ins_max_fecha_sin.cali <- with(df.ins.cali, max(fecha_sin, na.rm = TRUE))
ins_min_fecha_sin.cali <- with(df.ins.cali, min(fecha_sin, na.rm = TRUE))
saveRDS(df.ins.cali, file = "data/Cali.RDS")


# Buenaventura
df.ins.bventura <- df.ins %>%
  filter(codigo_divipola=="76109" | ciudad_de_ubicaci_n=="Buenaventura")
write_csv(df.ins.bventura,
          paste0("data/", "datos_ins_bventura.csv"))
write_csv(df.ins.bventura,
          paste0("data/", hoy, "-datos_ins-bventura-fecnot-", ins_max_fecha_not, ".csv"))
ins_max_fecha_not.bventura <- with(df.ins.bventura, max(fecha_not, na.rm = TRUE))
ins_min_fecha_not.bventura <- with(df.ins.bventura, min(fecha_not, na.rm = TRUE))
ins_max_fecha_sin.bventura <- with(df.ins.bventura, max(fecha_sin, na.rm = TRUE))
ins_min_fecha_sin.bventura <- with(df.ins.bventura, min(fecha_sin, na.rm = TRUE))
saveRDS(df.ins.bventura, file = "data/Bventura.RDS")


# Palmira
df.ins.palmira <- df.ins %>%
  filter(codigo_divipola=="76520" | ciudad_de_ubicaci_n=="Palmira")
write_csv(df.ins.palmira,
          paste0("data/", "datos_ins_palmira.csv"))
write_csv(df.ins.palmira,
          paste0("data/", hoy, "-datos_ins-palmira-fecnot-", ins_max_fecha_not, ".csv"))
ins_max_fecha_not.palmira <- with(df.ins.palmira, max(fecha_not, na.rm = TRUE))
ins_min_fecha_not.palmira <- with(df.ins.palmira, min(fecha_not, na.rm = TRUE))
ins_max_fecha_sin.palmira <- with(df.ins.palmira, max(fecha_sin, na.rm = TRUE))
ins_min_fecha_sin.palmira <- with(df.ins.palmira, min(fecha_sin, na.rm = TRUE))
saveRDS(df.ins.palmira, file = "data/Palmira.RDS")

# Jamundi
df.ins.jamundi <- df.ins %>%
  filter(codigo_divipola=="76364")
ins_max_fecha_not.jamundi <- with(df.ins.jamundi, max(fecha_not, na.rm = TRUE))
ins_min_fecha_not.jamundi <- with(df.ins.jamundi, min(fecha_not, na.rm = TRUE))
ins_max_fecha_sin.jamundi <- with(df.ins.jamundi, max(fecha_sin, na.rm = TRUE))
ins_min_fecha_sin.jamundi <- with(df.ins.jamundi, min(fecha_sin, na.rm = TRUE))
saveRDS(df.ins.jamundi, file = "data/Jamundi.RDS")


# Yumbo
df.ins.yumbo <- df.ins %>%
  filter(codigo_divipola=="76892")
ins_max_fecha_not.yumbo <- with(df.ins.yumbo, max(fecha_not, na.rm = TRUE))
ins_min_fecha_not.yumbo <- with(df.ins.yumbo, min(fecha_not, na.rm = TRUE))
ins_max_fecha_sin.yumbo <- with(df.ins.yumbo, max(fecha_sin, na.rm = TRUE))
ins_min_fecha_sin.yumbo <- with(df.ins.yumbo, min(fecha_sin, na.rm = TRUE))
saveRDS(df.ins.yumbo, file = "data/Yumbo.RDS")


# Tulua
df.ins.tulua <- df.ins %>%
  filter(codigo_divipola=="76834")
ins_max_fecha_not.tulua <- with(df.ins.tulua, max(fecha_not, na.rm = TRUE))
ins_min_fecha_not.tulua <- with(df.ins.tulua, min(fecha_not, na.rm = TRUE))
ins_max_fecha_sin.tulua <- with(df.ins.tulua, max(fecha_sin, na.rm = TRUE))
ins_min_fecha_sin.tulua <- with(df.ins.tulua, min(fecha_sin, na.rm = TRUE))
saveRDS(df.ins.tulua, file = "data/Tulua.RDS")


# Valle del Cauca
df.ins.valle <- df.ins %>%
  filter(codigo_divipola>="76000" & codigo_divipola<="76999")
write_csv(df.ins.valle,
          paste0("data/", "datos_ins_valle.csv"))
write_csv(df.ins.valle,
          paste0("data/", hoy, "-datos_ins-valle-fecnot-", ins_max_fecha_not, ".csv"))
ins_max_fecha_not.valle <- with(df.ins.valle, max(fecha_not, na.rm = TRUE))
ins_min_fecha_not.valle <- with(df.ins.valle, min(fecha_not, na.rm = TRUE))
ins_max_fecha_sin.valle <- with(df.ins.valle, max(fecha_sin, na.rm = TRUE))
ins_min_fecha_sin.valle <- with(df.ins.valle, min(fecha_sin, na.rm = TRUE))
saveRDS(df.ins.valle, file = "data/Valle.RDS")


# Valle Resto
df.ins.valle.resto <- df.ins.valle %>%
  filter(!(codigo_divipola %in% c("76001","76109","76520","76364","76892","76834")) )
ins_max_fecha_not.vre <- with(df.ins.valle.resto, max(fecha_not, na.rm = TRUE))
ins_min_fecha_not.vre <- with(df.ins.valle.resto, min(fecha_not, na.rm = TRUE))
ins_max_fecha_sin.vre <- with(df.ins.valle.resto, max(fecha_sin, na.rm = TRUE))
ins_min_fecha_sin.vre <- with(df.ins.valle.resto, min(fecha_sin, na.rm = TRUE))
saveRDS(df.ins.valle.resto, file = "data/Valle_resto.RDS")


# Valle No Distritos
df.ins.valle.nodis <- df.ins.valle %>%
  filter(!(codigo_divipola %in% c("76001","76109")) )
ins_max_fecha_not.vnd <- with(df.ins.valle.nodis, max(fecha_not, na.rm = TRUE))
ins_min_fecha_not.vnd <- with(df.ins.valle.nodis, min(fecha_not, na.rm = TRUE))
ins_max_fecha_sin.vnd <- with(df.ins.valle.nodis, max(fecha_sin, na.rm = TRUE))
ins_min_fecha_sin.vnd <- with(df.ins.valle.nodis, min(fecha_sin, na.rm = TRUE))
saveRDS(df.ins.valle.nodis, file = "data/Valle_nodis.RDS")

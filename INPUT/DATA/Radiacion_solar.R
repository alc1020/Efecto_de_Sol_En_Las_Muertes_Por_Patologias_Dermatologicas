# ESTRUCTURACIÓN DE LOS DATOS DE RADIACIÓN SOLAR EN CSV

library(readr)
library(tidyverse)

Radiacion_solar <- read_delim(file = "INPUT/DATA/Radiacion_solar csv.csv",
                           delim = ";", escape_double = FALSE, trim_ws = TRUE)

Radiacion_solar

str(Radiacion_solar)
summary(Radiacion_solar)
view(Radiacion_solar)


datosrad <- Radiacion_solar %>%
  mutate(
    Comunidad = case_when(
      
      Localidad %in% c("ALMERIA", "CADIZ", "CORDOBA", "GRANADA", "HUELVA", "JAEN", "MALAGA", "SEVILLA") ~ "Andalucía",
      Localidad %in% c("HUESCA", "ZARAGOZA", "TERUEL") ~ "Aragón",
      Localidad %in% c("ASTURIAS") ~ "Asturias",
      Localidad %in% c("CANTABRIA") ~ "Cantabria",
      Localidad %in% c("TOLEDO", "CIUDAD REAL", "GUADALAJARA", "CUENCA", "ALBACETE") ~ "Castilla La Mancha",
      Localidad %in% c("LEON", "ZAMORA", "SALAMANCA", "PALENCIA", "VALLADOLID", "AVILA", "BURGOS", "SORIA", "SEGOVIA") ~ "Castilla y León",
      Localidad %in% c("LERIDA", "GERONA", "BARCELONA", "TARRAGONA") ~ "Cataluña",
      Localidad %in% c("CASTELLON", "VALENCIA", "ALICANTE") ~ "Comunidad Valenciana",
      Localidad %in% c("CACERES", "BADAJOZ") ~ "Extremadura",
      Localidad %in% c("LUGO", "ORENSE", "PONTEVEDRA", "LA CORUÑA") ~ "Galicia",
      Localidad %in% c("BALEARES") ~ "Islas Baleares",
      Localidad %in% c("ST.C.TENERIFE", "LAS PALMAS") ~ "Islas Canarias",
      Localidad %in% c("LA RIOJA") ~ "La Rioja",
      Localidad %in% c("MADRID") ~ "Madrid",
      Localidad %in% c("MURCIA") ~ "Murcia",
      Localidad %in% c("NAVARRA") ~ "Navarra",
      Localidad %in% c("ALAVA", "VIZCAYA", "GUIPUZCOA") ~ "País Vasco",
      
      TRUE ~ NA_character_
    ))%>%
  
  #uso filter porque no vamos a trabajar con los datos de ceuta y melilla, y como no se han agregado a ninguna comunidad figuran como null
  filter(!is.na(Comunidad))

print(datosrad)


#hago la media de la cantidad de radiación solar en KW/m2. Los demás datos no se tienen en cuenta
mediarad <- datosrad %>%
  group_by(Comunidad) %>%
  summarise(KW_por_m2 = mean(KW_por_m2))

print(mediarad)

#convierto los datos a df
datos_radiacion_solar <- data.frame(
  c(mediarad)
)

print(datos_radiacion_solar)


# gráfico de barras
ggplot(data = datos_radiacion_solar, aes(x = Comunidad, y = KW_por_m2)) +
  geom_bar(stat = "identity")


################################################################################


# vamos a crear un mapa con los datos obtenidos de radiación solar en España 
#información obtenida de rpubs by rstudio

# para manipular dataframes
library(tidyverse)

install.packages("sf")
library(sf)

# Cargar el shapefile
shapefile_path <- "INPUT/DATA/ComunidadesAutonomas_ETRS89_30N/Comunidades_Autonomas_ETRS89_30N"
comunidades <- st_read(shapefile_path)

# Verifica los datos cargados
print(comunidades)

##################


# Para transformar los archivos shapefiles 
library(broom)


setwd("INPUT/DATA/ComunidadesAutonomas_ETRS89_30N")

# Guardamos el archivo shapefile
shapefile_ccaa <- readOGR("Comunidades_Autonomas_ETRS89_30N.shp")
## OGR data source with driver: ESRI Shapefile 
## Source: "C:\Users\Usuario\Desktop\r_que_r\r_que_r\content\datasets\ComunidadesAutonomas_ETRS89_30N\Comunidades_Autonomas_ETRS89_30N.shp", layer: "Comunidades_Autonomas_ETRS89_30N"
## with 19 features
## It has 3 fields

# Para convertir el archivo shapefile en un dataframe utilizamos la función tidy()
data_ccaa <- tidy(shapefile_ccaa)

# primeras observaciones del dataset
head(data_ccaa)


nombres_ccaa <- data.frame(shapefile_ccaa$Texto)

head(nombres_ccaa)

nombres_ccaa$id <- as.character(seq(0, nrow(nombres_ccaa)-1))

head(nombres_ccaa)

data_ccaa_mapa <- left_join(data_ccaa, nombres_ccaa, by = "id")

head(data_ccaa_mapa)

data_ccaa_mapa %>%
  ggplot() +
  geom_polygon(aes( x= long, y = lat, group = group),
               fill = "violetred4",
               color = "white") +
  theme_minimal() +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.title = element_blank(),
    axis.ticks = element_blank(),
    panel.background = element_rect(colour= "darkgrey", size= 0.5)) +
  ggtitle("Comunidades Autónomas Españolas")








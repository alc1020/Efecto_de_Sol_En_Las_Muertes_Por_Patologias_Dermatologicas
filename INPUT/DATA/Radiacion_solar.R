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




# vamos a crear un mapa con los datos obtenidos de radiación solar en España

install.packages(c("sf", "ggplot2", "dplyr"))
library(sf)
library(ggplot2)
library(dplyr)

install.packages("devtools")
library(devtools)
install.packages("rnaturalearth")
library(rnaturalearth)
library(rnaturalearthdata)

# Descargar shapefile de España
spain_map <- ne_states(country = "Spain", returnclass = "sf")



# Supongamos que el dataframe `datos_radiacion_solar` tiene las columnas:
# - "comunidad" con los nombres de las comunidades autónomas
# - "radiacion" con los valores de radiación solar

# Verifica los nombres
unique(spain_map$name) # Nombres en el shapefile
unique(datos_radiacion_solar$comunidad) # Nombres en el dataframe


# Une los datos con el shapefile
mapa_datos <- spain_map %>%
  left_join(datos_radiacion_solar, by = c("name" = "comunidad"))


ggplot(data = mapa_datos) +
  geom_sf(aes(fill = KW_por_m2), color = "white") +
  scale_fill_viridis_c(option = "C", name = "Radiación Solar") +
  theme_minimal() +
  labs(
    title = "Radiación Solar en España por Comunidad Autónoma",
    subtitle = "Datos de radiación solar",
    caption = "Fuente: datos_radiacion_solar"
  )

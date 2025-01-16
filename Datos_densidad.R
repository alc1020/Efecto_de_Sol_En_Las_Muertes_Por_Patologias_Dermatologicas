# ESTRUCTURACIÓN DE LOS DATOS EN CSV DE LA SUPERCICIE DE CADA COMUNIDAD Y CÁLCULO DE LA DENSIDAD DE MUERTES POR CÁNCER DE PIEL

library(readr)
library(tidyverse)

poblac_superf <- read_delim(file = "INPUT/DATA/poblacion_superficie_provincias.csv",
                           delim = ";", escape_double = FALSE, trim_ws = TRUE)
poblac_superf

str(poblac_superf)
summary(poblac_superf)
view(poblac_superf)

#voy a hacer un case when una provincia de la tabla, asignarle una ccaa. Asignar NA si no se cumple ninguna condición
#luego hago un mutate para añadir la columna

datos <- poblac_superf %>%
  mutate(
    Comunidad = case_when(
      
      Provincia %in% c("Almería", "Cádiz", "Córdoba", "Granada", "Huelva", "Jaén", "Málaga", "Sevilla") ~ "Andalucía",
      Provincia %in% c("Huesca", "Zaragoza", "Teruel") ~ "Aragón",
      Provincia %in% c("Asturias") ~ "Asturias",
      Provincia %in% c("Cantabria") ~ "Cantabria",
      Provincia %in% c("Toledo", "Ciudad Real", "Guadalajara", "Cuenca", "Albacete") ~ "Castilla La Mancha",
      Provincia %in% c("León", "Zamora", "Salamanca", "Palencia", "Valladolid", "Ávila", "Burgos", "Soria", "Segovia") ~ "Castilla y León",
      Provincia %in% c("Lleida", "Girona", "Barcelona", "Tarragona") ~ "Cataluña",
      Provincia %in% c("Castellón / Castelló", "Valencia / València", "Alicante / Alacant") ~ "Comunidad Valenciana",
      Provincia %in% c("Cáceres", "Badajoz") ~ "Extremadura",
      Provincia %in% c("Lugo", "Ourense", "Pontevedra", "A Coruña") ~ "Galicia",
      Provincia %in% c("Illes Balears") ~ "Islas Baleares",
      Provincia %in% c("Santa Cruz de Tenerife", "Las Palmas") ~ "Islas Canarias",
      Provincia %in% c("La Rioja") ~ "La Rioja",
      Provincia %in% c("Madrid") ~ "Madrid",
      Provincia %in% c("Murcia") ~ "Murcia",
      Provincia %in% c("Navarra") ~ "Navarra",
      Provincia %in% c("Araba / Álava", "Bizkaia", "Gipuzkoa") ~ "País Vasco",
      
      TRUE ~ NA_character_
    ))%>%
  
  #uso filter porque no vamos a trabajar con los datos de ceuta y melilla, y como no se han agregado a ninguna comunidad figuran como null
  filter(!is.na(Comunidad))

print(datos)


#Asegúrate de que ambas columnas contengan datos numéricos. Si no, conviértelos con as.numeric:
datos$Superficie <- as.numeric(datos$`Superf. (km2)`)

#LAS SUPERFICIES SE SUMAN
superficie_tot <- datos %>%
  group_by(Comunidad) %>%
  summarise(Superficie = sum(`Superf. (km2)`))

print(superficie_tot)


datos_defunciones_2022

# Crear un dataframe combinando las columnas por "Comunidad"
datos_def_sup <- merge(datos_defunciones_2022, superficie_tot, by = "Comunidad")
# Mostrar el resultado
print(datos_def_sup)


#AHORA TOCA DENSIDAD DE DEFUNCIONES POR SUPERFICIE
# comentar que otra posibilidad es hacerlo uno por uno, pero es más costoso
# en el csv calculamos la densidad a partir de la media de las comunidades ya


#Evitar divisiones por cero: Si la columna Superficie puede contener ceros, puedes manejarlo para evitar errores:

# Asegúrate de que tienes el paquete dplyr cargado
library(dplyr)

# Usar dplyr para calcular la densidad y ordenar
datos_densidad <- datos_def_sup %>%
  mutate(Densidad = ifelse(Superficie != 0, Defunciones / Superficie, NA)) %>%
  group_by(Comunidad) %>%
  summarise(Densidad = mean(Densidad, na.rm = TRUE)) %>%  # Si hay duplicados en Comunidad, calcular la media
  arrange(desc(Densidad))  # Ordenar de mayor a menor por Densidad

#mutate(): Añade una nueva columna Densidad calculando la densidad (Población / Superficie). Si Superficie es 0, asigna NA.
#group_by(Comunidad): Agrupa los datos por la columna Comunidad.
#summarise(): Si hay varias filas para la misma comunidad, toma el promedio de la columna Densidad (puedes cambiar la operación si prefieres otra cosa, como la suma o el valor máximo).
#arrange(desc(Densidad)): Ordena las comunidades de mayor a menor según la densidad.
#Notas:
# summarise(): Si tienes comunidades repetidas, summarise() las combina. Por ejemplo, si tienes múltiples registros por comunidad, podrías querer hacer un cálculo (como la media) de las densidades para cada comunidad.
#arrange(desc()): Ordena el dataframe por la columna Densidad de mayor a menor.
#Este código elimina la necesidad del bucle for y realiza todas las operaciones de manera vectorizada y eficiente dentro de dplyr.

# Mostrar el resultado
print(datos_densidad)

# Gráfico de rosquilla del número de muertes en cada comunidad
ggplot(datos_def_sup, aes(x = 2, y = Defunciones, fill = Comunidad)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar(theta = "y") +
  xlim(0.5, 2.5) + # Crea el agujero
  theme_void() +
  labs(
    title = "Muertes por CCAA",
    fill = "Comunidad"
  ) +
  theme(plot.title = element_text(hjust = 0.5))


# Gráfico de barras de Superficie por Comunidad Autónoma ordenado de mayor a menor superficie
ggplot(data = datos_def_sup, aes(x = reorder(Comunidad, -Superficie), y = Superficie)) +
  geom_bar(stat = "identity", fill = "darkolivegreen") + 
  theme_minimal() + 
  labs(
    title = "Superficie por Comunidad Autónoma",
    x = "Comunidad Autónoma",
    y = "Superficie"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) # Rotar etiquetas del eje x


# Gráfico de barras de Densidad de muertes por cáncer de piel por Comunidad Autónoma ordenado de más a menos densidad
ggplot(data = datos_densidad) + 
  geom_bar(
    mapping = aes(x = reorder(Comunidad, -Densidad), y = Densidad, fill = Comunidad), 
    stat = "identity", 
    show.legend = FALSE, 
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(
    title = "Densidad de muertes por ccaa",
    x = "Comunidad Autónoma", 
    y = "Proporción de muertes"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) # Rotar etiquetas del eje x

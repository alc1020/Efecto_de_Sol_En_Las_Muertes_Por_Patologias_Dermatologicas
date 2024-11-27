# ESTRUCTURACIÓN DE LOS DATOS DE HORAS DE SOL EN CSV

library(readr)
library(tidyverse)

Horas_de_sol <- read_delim(file = "INPUT/DATA/Horas_de_sol csv.csv",
                               delim = ";", escape_double = FALSE, trim_ws = TRUE)
Horas_de_sol

str(Horas_de_sol)
summary(Horas_de_sol)
view(Horas_de_sol)


#voy a hacer un case when una provincia de la tabla, asignarle una ccaa. Asignar NA si no se cumple ninguna condición
#luego hago un mutate para añadir la columna

datos <- Horas_de_sol %>%
  mutate(
    Comunidad = case_when(
      
      Provincia %in% c("Almería", "Cádiz", "Córdoba", "Granada", "Huelva", "Jaén", "Málaga", "Sevilla") ~ "Andalucía",
      Provincia %in% c("Huesca", "Zaragoza", "Teruel") ~ "Aragón",
      Provincia %in% c("Asturias") ~ "Asturias",
      Provincia %in% c("Cantabria") ~ "Cantabria",
      Provincia %in% c("Toledo", "Ciudad Real", "Guadalajara", "Cuenca", "Albacete") ~ "Castilla La Mancha",
      Provincia %in% c("León", "Zamora", "Salamanca", "Palencia", "Valladolid", "Ávila", "Burgos", "Soria", "Segovia") ~ "Castilla y León",
      Provincia %in% c("Lleida", "Girona", "Barcelona", "Tarragona") ~ "Cataluña",
      Provincia %in% c("Castellón", "Valencia", "Alicante") ~ "Comunidad Valenciana",
      Provincia %in% c("Cáceres", "Badajoz") ~ "Extremadura",
      Provincia %in% c("Lugo", "Ourense", "Pontevedra", "A Coruña") ~ "Galicia",
      Provincia %in% c("Menorca", "Mallorca") ~ "Islas Baleares",
      Provincia %in% c("Tenerife", "La Palma", "Lanzarote") ~ "Islas Canarias",
      Provincia %in% c("La Rioja") ~ "La Rioja",
      Provincia %in% c("Madrid") ~ "Madrid",
      Provincia %in% c("Murcia") ~ "Murcia",
      Provincia %in% c("Pamplona") ~ "Navarra",
      Provincia %in% c("Álava", "Vizcaya", "Guipúzcoa") ~ "País Vasco",

      TRUE ~ NA_character_
    ))%>%

  filter(!is.na(Comunidad))

print(datos)
  

#media de las horas de sol cuyas filas tengan el mismo nombre de ccaa

medias <- datos %>%
  group_by(Comunidad) %>%
  summarise(HorasDeSol = mean(HorasDeSol))

print(medias)


#hago el dataframe con las horas de sol por ccaa

datos_horas_de_sol <- data.frame(
  c(medias)
)

print(datos_horas_de_sol)


# gráfico
ggplot(data = datos_horas_de_sol, aes(x = Comunidad, y = HorasDeSol)) +
  geom_bar(stat = "identity")

library(dplyr)
library(readr)
library(ggplot2)


#datos_defs_decada <- read.csv(file = "INPUT/DATA/defunciones_2010_2022.csv")



datos_defs_decada <- read_delim(file = "INPUT/DATA/defunciones_2010_2022.csv",
                               delim = ";", escape_double = FALSE, trim_ws = TRUE)



datos_defs_decada$"Causa de muerte" <- NULL
datos_defs_decada$Sexo <- NULL

datos_defs_decada <- datos_defs_decada %>%
  rename(Comunidad = "Comunidades y Ciudades Autónomas")%>%
 

datos_defs_decada





datos_defs_decada <- datos_defs_decada %>%
  mutate(Comunidad = case_when(
    Comunidad == "Asturias, Principado de" ~ "Asturias",
    Comunidad == "Balears, Illes" ~ "Islas Baleares",
    
    Comunidad == "Canarias" ~ "Islas Canarias",
    #Comunidad == "Balears, Illes" ~ "Islas Baleares",
    
    Comunidad == "Castilla - La Mancha" ~ "Castilla La Mancha",
    Comunidad == "Comunitat Valenciana" ~ "Comunidad Valenciana",
    
    Comunidad == "Madrid, Comunidad de" ~ "Madrid",
    Comunidad == "Murcia, Región de" ~ "Murcia",
    
    Comunidad == "Navarra, Comunidad Foral de" ~ "Navarra",
    Comunidad == "Rioja, La" ~ "La Rioja",
    
    TRUE ~ Comunidad  # Mantener los valores actuales si no coinciden
  ))

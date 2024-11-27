library(readr)
library(dplyr)
Defunciones_2022 <- read_delim(file = "INPUT/DATA/defunciones_2022 csv.csv",
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)
#print(Defunciones_2022)

#Eliminamos la columna de Ids para poder unir las tablas
Defunciones_2022$ID <- NULL
#print(Defunciones_2022)





# vamos a renombrar la columna de nombre a comunidad, para que sea compatible
#con los datos de horas de sol y radiacion
datos_defunciones_2022 <- Defunciones_2022 %>%
  rename(Comunidad = Nombre)%>%
  rename(Defunciones = Valor)



# Filtrar para excluir 'Ceuta' y 'Melilla'
#datos_defunciones_2022 <- datos_defunciones_2022 %>%
 #filter(!Comunidad %in% c("Ceuta", "Melilla"))




#cambiamos mediante un case when los casos puntuales de cambio de nombre,
#abajo del todo establecemos que si coinciden los nombres que se mantengan

datos_defunciones_2022 <- datos_defunciones_2022 %>%
  mutate(Comunidad = case_when(
    Comunidad == "Asturias, Principado de" ~ "Asturias",
    Comunidad == "Balears, Illes" ~ "Islas Baleares",
    
    Comunidad == "Canarias" ~ "Islas Canarias",
    Comunidad == "Balears, Illes" ~ "Islas Baleares",
    
    Comunidad == "Castilla - La Mancha" ~ "Castilla La Mancha",
    Comunidad == "Comunitat Valenciana" ~ "Comunidad Valenciana",

    Comunidad == "Madrid, Comunidad de" ~ "Madrid",
    Comunidad == "Murcia, Región de" ~ "Murcia",
    
    Comunidad == "Navarra, Comunidad Foral de" ~ "Navarra",
    Comunidad == "Rioja, La" ~ "La Rioja",
    
    TRUE ~ Comunidad  # Mantener los valores actuales si no coinciden
))


# Filtramos, para eliminar Ceuta y Melilla, y después ordenamos la tabla
#alfabéticamente de nuevo
datos_defunciones_2022 <- datos_defunciones_2022 %>%
  filter(!Comunidad %in% c("Ceuta", "Melilla")) %>%
  arrange(Comunidad)

view(datos_defunciones_2022)



# Crear un nuevo data frame combinando ambas tablas por la columna 'Comunidad'
datos_combinados <- merge(datos_horas_de_sol, datos_defunciones_2022, by = "Comunidad")
datos_combinados <- merge(datos_combinados, datos_radiacion_solar, by = "Comunidad")

# Ver el resultado
view(datos_combinados)




# Unir las tablas por la columna 'Comunidad'
#datos_def_media <- datos_horas_de_sol %>%
 # inner_join(datos_radiacion_solar, by = "Comunidad")

# Ver el resultado
#view(datos_combinados)



library(greenR)

vector_provincias <- c("Huelva, Spain", "Sevilla, Spain", "Cordoba, Spain", "Jaen, Spain", "Cadiz, Spain", "Malaga, Spain", "Granada, Spain", "Almeria, Spain", 
                       "Huesca, Spain", "Zaragoza, Spain", "Teruel, Spain", 
                       "Asturias, Spain",
                       "Mallorca, Spain", "Menorca, Spain", 
                       "El hierro, Spain", "Gran Canaria, Spain", "La Gomera, Spain", "La Palma, Spain", "Tenerife, Spain", 
                       "Cantabria, Spain", 
                       "Leon, Spain", "Palencia, Spain", "Burgos, Spain", "Soria, Spain", "Zamora, Spain", "Valladolid, Spain", "Segovia, Spain", "Salamanca, Spain", "Avila, Spain", 
                       "Guadalajara, Spain", "Cuenca, Spain", "Albacete, Spain", "Toledo, Spain", "Ciudad Real, Spain",
                       "Gerona, Spain", "Barcelona, Spain", "Lerida, Spain", "Tarragona, Spain", 
                       "Castellon, Spain", "Valencia, Spain","Alicante, Spain", 
                       "Caceres, Spain", "Badajoz, Spain", 
                       "La Coruña, Spain", "Lugo, Spain", "Pontevedra, Spain", "Orense, Spain",
                       "Madrid, Spain", 
                       "Murcia, Spain",
                       "Navarra, Spain", 
                       "Vizcaya, Spain", "Guipuzcoa, Spain", "Alava, Spain", 
                       "La Rioja, Spain",
                       "Ceuta, Spain", 
                       "Melilla, Spain" 
                       )
vector_relevante <- c("El Rocío, Spain", "La Puebla del Río, Spain", "Hornachuelos, Spain", "Cazorla, Spain", "Grazalema, Spain", "Ronda, Spain", "Capileira, Spain", "Níjar, Spain", 
                      "Torla, Spain", "Añón de Moncayo, Spain", "Tramacastilla, Spain",
                      "Cangas de Onís, Spain", 
                      "Escorca, Spain", "Es Mercadal, Spain", 
                      "Sabinosa, Spain", "Tejeda, Spain", "Hermigua, Spain", "El Paso, Spain", "La Orotava, Spain", 
                      "Potes, Spain", 
                      " Posada de Valdeón, Spain", " Cervera de Pisuerga, Spain", "Covarrubias, Spain", "Ucero, Spain", "Galende, Spain", "Castronuño, Spain", "Sepúlveda, Spain", "La Alberca, Spain", "Hoyos del Espino, Spain", 
                      "Cantalojas, Spain", "Beteta, Spain", "Ossa de Montiel, Spain", "Los Navalucillos, Spain", "Villarrubia de los Ojos, Spain",
                      "Cadaqués, Spain", "Montseny , Spain", "Espot , Spain", "Deltebre, Spain", 
                      "Morella, Spain", "Parque Natural de la Albufera, Spain", "Sierra de Mariola, Spain", 
                      "Torrejón el Rubio, Spain", "Alange , Spain",
                      "Pontedeume, Spain", "Cervantes, Spain", "O Grove, Spain", "Rubiá, Spain", 
                      "Rascafría, Spain", 
                      "Alhama de Murcia, Spain",
                      "Ochagavía, Spain", 
                      "Gernika, Spain", "Oiartzun, Spain", "Arraia-Maeztu, Spain", 
                      "Villoslada de Cameros, Spain", 
                      "Monte Hacho, Spain", 
                      "Gurugú y Parque Forestal de Rostrogordo, Spain" 
                      )

vector_comunidades <- c("Andalucía", 
                        "Aragón", 
                        "Asturias", 
                        "Islas Baleares", 
                        "Islas Canarias", 
                        "Cantabria", 
                        "Castilla y León", 
                        "Castilla La Mancha", 
                        "Cataluña", 
                        "Comunidad Valenciana", 
                        "Extremadura",
                        "Galicia",
                        "Madrid",
                        "Murcia", 
                        "Navarra", 
                        "País Vasco", 
                        "La Rioja",
                        "Ceuta", 
                        "Melilla"
                        )
                        
                        

vector_provincias <- c("Huelva", "Sevilla", "Cordoba", "Jaen", "Cadiz", "Malaga", "Granada", "Almeria", "Huesca", "Zaragoza", "Teruel","Huelva, Spain", "Sevilla, Spain", "Cordoba, Spain", "Jaen, Spain", "Cadiz, Spain", "Malaga, Spain", "Granada, Spain", "Almeria, Spain", "Huesca, Spain", "Zaragoza, Spain", "Teruel, Spain")
vector_relevante <- c("El Rocío, Spain", "La Puebla del Río, Spain", "Hornachuelos, Spain", "Cazorla, Spain", "Grazalema, Spain", "Ronda, Spain", "Capileira, Spain", "Níjar, Spain", "Torla, Spain", "Añón de Moncayo, Spain", "Tramacastilla, Spain")
                        
vector_relevante<-c("La rondilla, Spain", "Gorliz, Spain")
vector_provincias<-c("La rondilla, Spain",  "Gorliz, Spain")


porcent = c()
for (i in vector_provincias){
  datos <- get_osm_data(i)
  green_index <- calculate_green_index(datos, 4326, 100)
  percentage <- calculate_percentage(green_index)
  porcent = c(porcent, percentage$percentage[3])
  print (porcent)
}
DF<-data.frame(vector_provincias,porcent)
DF

datos<-get_osm_data("La rondilla, Spain")
green_index <- calculate_green_index(datos, 4326, 100)
percentage <- calculate_percentage(green_index)
porcent = c(porcent, percentage$percentage[3])




#write_csv(DF) PARA CUANDO ESTE TERMINADO EL DF
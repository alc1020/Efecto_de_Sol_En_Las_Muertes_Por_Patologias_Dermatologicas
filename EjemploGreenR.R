library(greenR)

vector_provincias <- c("La Coruña, Spain", "Lugo, Spain", "Pontevedra, Spain", "Orense, Spain",
                      "Asturias, Spain",
                      "Cantabria, Spain",
                      "Vizcaya, Spain", "Guipuzcoa, Spain", "Alava, Spain",
                      "Navarra, Spain", 
                      "La Rioja, Spain",
                      "Castellon, Spain", "Valencia, Spain","Alicante, Spain",
                      "Madrid, Spain",
                      "Gerona, Spain", "Barcelona, Spain", "Lerida, Spain", "Tarragona, Spain", 
                      "Huesca, Spain", "Zaragoza, Spain", "Teruel, Spain",
                      "Leon, Spain", "Palencia, Spain", "Burgos, Spain", "Soria, Spain", "Zamora, Spain", "Valladolid, Spain", "Segovia, Spain", "Salamanca, Spain", "Avila, Spain",
                      "Guadalajara, Spain", "Cuenca, Spain", "Albacete, Spain", "Toledo, Spain", "Ciudad Real, Spain",
                      "Caceres, Spain", "Badajoz, Spain",
                      "Murcia, Spain",
                      "Huelva, Spain", "Sevilla, Spain", "Cordoba, Spain", "Jaen, Spain", "Cadiz, Spain", "Malaga, Spain", "Granada, Spain", "Almeria, Spain",
                      "Mallorca, Spain", "Menorca, Spain",
                      "El hierro, Spain", "Gran Canaria, Spain", "La Gomera, Spain", "La Palma, Spain", "Tenerife, Spain",
                      "Ceuta, Spain",
                      "Melilla, Spain"
                      )
vector_relevante <- c("Pontedeume, Spain", "Cervantes, Spain", "O Grove, Spain", "Rubiá, Spain",
                      "Cangas de Onís, Spain",
                      "Potes, Spain",
                      "Gernika, Spain", "Oiartzun, Spain", "Arraia-Maeztu, Spain",
                      "Ochagavía, Spain",
                      "Villoslada de Cameros, Spain",
                      "Morella, Spain", "Parque Natural de la Albufera, Spain", "Sierra de Mariola, Spain",
                      "Rascafría, Spain",
                      "Cadaqués, Spain", "Montseny , Spain", "Espot , Spain", "Deltebre, Spain",
                      "Torla, Spain", "Añón de Moncayo, Spain", "Tramacastilla, Spain",
                      " Posada de Valdeón, Spain", " Cervera de Pisuerga, Spain", "Covarrubias, Spain", "Ucero, Spain", "Galende, Spain", "Castronuño, Spain", "Sepúlveda, Spain", "La Alberca, Spain", "Hoyos del Espino, Spain",
                      "Cantalojas, Spain", "Beteta, Spain", "Ossa de Montiel, Spain", "Los Navalucillos, Spain", "Villarrubia de los Ojos, Spain",
                      "Torrejón el Rubio, Spain", "Alange , Spain",
                      "Alhama de Murcia, Spain",
                      "El Rocío, Spain", "La Puebla del Río, Spain", "Hornachuelos, Spain", "Cazorla, Spain", "Grazalema, Spain", "Ronda, Spain", "Capileira, Spain", "Níjar, Spain", 
                      "Escorca, Spain", "Es Mercadal, Spain",
                      "Sabinosa, Spain", "Tejeda, Spain", "Hermigua, Spain", "El Paso, Spain", "La Orotava, Spain",
                      "Monte Hacho, Spain",
                      "Gurugú y Parque Forestal de Rostrogordo, Spain"
                      )

vector_comunidades <- c("Galicia",
                        "Asturias",
                        "Cantabria",
                        "Pais Vasco",
                        "Navarra",
                        "La Rioja",
                        "Comunidad Valenciana",
                        "Madrid",
                        "Cataluña",
                        "Aragón",
                        "Castilla y León",
                        "Castilla La Mancha",
                        "Extremadura",
                        "Murcia",
                        "Andalucía",
                        "Islas Baleares",
                        "Islas Canarias",
                        "Ceuta", 
                        "Melilla")


porcent = c()
for (i in vector_relevante){
  datos <- get_osm_data(vector_provincias[i])
  green_index <- calculate_green_index(datos, 4326, 100)
  percentage <- calculate_percentage(green_index)
  porcent = c(porcent, percentage$percentage[3])
}
DF<-data.frame(vector_provincias,porcent)
DF



#write_csv(DF) PARA CUANDO ESTE TERMINADO EL DF
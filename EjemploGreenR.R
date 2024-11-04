library(greenR)

datagor <- get_osm_data("Gorliz, Spain")

green_index <- calculate_green_index(dataGor, 4326, 100)
percentage <- calculate_percentage(green_index)
View(percentage)

?calculate_percentage

#dataElex <- get_osm_data("Elexalde, Gorliz, Spain")
#dataLaRond <- get_osm_data("La Rondilla, Valladolid, Spain")
#El indice lo divide en tres categorias, la baja, la  media y la alta, nosotras hemos trabajado solo con los de la alta
#De baja categoria y un porcentaje
#De media y un porcentage
#De alta y un porcentage

vector_provincias <- c#("La Coruña, Spain","Lugo, Spain","Pontevedra, Spain","Orense, Spain",
                      #( "Asturias, Spain")
                      # "Cantabria, Spain",
                      # "Vizcaya, Spain", "Guipuzcoa, Spain", "Alava, Spain",
                      # "Navarra, Spain", 
                      # "La Rioja, Spain",
                      # "Castellon, Spain", "Valencia, Spain", "Alicante, Spain",
                       #"Madrid, Spain",
                      # "Gerona, Spain", "Barcelona, Spain", "Lerida, Spain", "Tarragona, Spain", 
                      # "Huesca, Spain", "Zaragoza, Spain", "Teruel, Spain",
                      # "Leon, Spain", "Palencia, Spain", "Burgos, Spain", "Soria, Spain", "Zamora, Spain", "Valladolid, Spain", "Segovia, Spain", "Salamanca, Spain", "Avila, Spain",
                      # "Guadalajara, Spain", "Cuenca, Spain", "Albacete, Spain", "Toledo, Spain", "Ciudad Real, Spain",
                      # "Caceres, Spain", "Badajoz, Spain",
                      # "Murcia, Spain",
                      # "Huelva, Spain", "Sevilla, Spain", "Cordoba, Spain", "Jaen, Spain", "Cadiz, Spain", "Malaga, Spain", "Granada, Spain", "Almeria, Spain",
                      # "Islas Baleares, Spain",
                      # "Santa Cruz de Tenerife, Spain", "Las Pamas, Spain",
                      # "Ceuta, Spain",
                      # "Melilla, Spain"
                      # )

porcent = c()
for (i in vector_provincias){
  datos <- get_osm_data(i)
  green_index <- calculate_green_index(datos, 4326, 100)
  percentage <- calculate_percentage(green_index)
  porcent = c(porcent, percentage$percentage[3])
}
DF<-data.frame(vector_provincias,porcent)
DF



#write_csv(DF) PARA CUANDO ESTE TERMINADO EL DF
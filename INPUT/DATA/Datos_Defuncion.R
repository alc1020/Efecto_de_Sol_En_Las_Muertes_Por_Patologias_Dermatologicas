library(tidyverse)
library(rjson)
library(tidyjson)

dato_pato <- fromJSON(file = "INPUT/datos anna/defuncion_patologiasdepiel.json")
head(dato_pato)

Datos_Patologia <- spread_all(dato_pato)
view(Datos_Patologia)





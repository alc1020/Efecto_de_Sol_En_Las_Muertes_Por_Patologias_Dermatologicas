library(tidyverse)
library(rjson)
library(tidyjson)
library(readr)

dato_pato <- fromJSON(file = "INPUT/DATA/defuncion_patologiasdepiel.json")
head(dato_pato)

Datos_Patologia <- spread_all(dato_pato)

view(Datos_Patologia)



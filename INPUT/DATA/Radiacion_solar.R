# ESTRUCTURACIÓN DE LOS DATOS DE RADIACIÓN SOLAR EN CSV

library(readr)
library(tidyverse)

Radiacion_solar <- read_delim(file = "INPUT/DATA/Radiacion_solar csv.csv",
                           delim = ";", escape_double = FALSE, trim_ws = TRUE)

Radiacion_solar

str(Radiacion_solar)
summary(Radiacion_solar)
view(Radiacion_solar)

# Hacemos un dataframe con la media de los índices de radiación por provincia, agrupados por comunidad autónoma

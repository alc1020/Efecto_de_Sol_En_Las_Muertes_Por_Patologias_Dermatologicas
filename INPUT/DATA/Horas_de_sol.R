# ESTRUCTURACIÓN DE LOS DATOS DE HORAS DE SOL EN CSV

library(readr)
library(tidyverse)

Datos_insolacion <- read_delim(file = "INPUT/DATA/Maestroinsolacion2022.csv",
                               delim = ";", escape_double = FALSE, trim_ws = TRUE)

Datos_insolacion

str(Datos_insolacion)
summary(Datos_insolacion)
view(Datos_insolacion)

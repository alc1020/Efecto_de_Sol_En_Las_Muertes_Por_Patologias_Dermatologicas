# ESTRUCTURACIÓN DE LOS DATOS DE HORAS DE SOL EN CSV

library(readr)
library(tidyverse)

Horas_de_sol <- read_delim(file = "INPUT/DATA/Horas_de_sol csv.csv",
                               delim = ";", escape_double = FALSE, trim_ws = TRUE)

Horas_de_sol

str(Horas_de_sol)
summary(Horas_de_sol)
view(Horas_de_sol)

# Hacemos un dataframe con la media de horas de sol por provincia, agrupadas por comunidad autónoma


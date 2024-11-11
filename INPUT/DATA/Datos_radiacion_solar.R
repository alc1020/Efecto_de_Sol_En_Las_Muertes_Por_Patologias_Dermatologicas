
install.packages("readr")
library(readr)

# Paso 1: Definir la ruta del archivo
archivo_txt <- "radiacion_global.txt"

# Paso 2: Leer el archivo como un CSV
datos <- read.csv(archivo_txt, header = TRUE, sep = ";")

# Paso 3: Verifica los datos
print(datos)

# Leer el archivo
datos <- read_delim(archivo_txt, delim = ";", col_names = TRUE)

# Mostrar los datos
print(datos)

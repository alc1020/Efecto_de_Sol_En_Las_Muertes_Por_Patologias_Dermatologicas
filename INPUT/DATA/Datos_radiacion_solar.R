library(readr)

# Paso 1: Definir la ruta del archivo
archivo_txt <- "INPUT/DATA/radiacion_global_txt.txt"

# Paso 2: Leer el archivo como un CSV
radiacion_global <- read.csv(archivo_txt, header = TRUE, sep = ";")

radiacion_global <- read_delim(file = "INPUT/DATA/radiacion_global_txt",delim = ";", escape_double = FALSE, trim_ws = TRUE)

# Mostrar los datos
print(datos)



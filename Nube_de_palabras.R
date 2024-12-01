# NUBE DE PALABRAS

install.packages("RColorBrewer")
install.packages("NLP")

if (!require("tm")) install.packages("tm")
if (!require("wordcloud")) install.packages("wordcloud")

library(tm)
library(wordcloud)

# Leer el archivo .rmd
file_path <- "Summary.rmd"  # Asegúrate de que el archivo esté en el directorio de trabajo
text <- readLines(file_path, encoding = "UTF-8")

# Crear un Corpus para procesamiento
corpus <- Corpus(VectorSource(text))

# Procesamos el texto
corpus <- tm_map(corpus, content_transformer(tolower)) # Convertir a minúsculas
corpus <- tm_map(corpus, removePunctuation)           # Eliminar puntuación
corpus <- tm_map(corpus, removeNumbers)               # Eliminar números
corpus <- tm_map(corpus, removeWords, stopwords("spanish")) # Eliminar palabras vacías en español
corpus <- tm_map(corpus, stripWhitespace)             # Eliminar espacios adicionales

# Creamos la matriz de términos
tdm <- TermDocumentMatrix(corpus)
m <- as.matrix(tdm)
word_freq <- sort(rowSums(m), decreasing = TRUE)

# Creamos la nube de palabras
set.seed(1234)  # Para reproducibilidad
wordcloud(
  names(word_freq),
  freq = word_freq,
  min.freq = 2,            # Ajusta según sea necesario
  max.words = 200,         # Número máximo de palabras
  random.order = FALSE,    # Ordenar por frecuencia
  colors = brewer.pal(8, "Dark2")
)

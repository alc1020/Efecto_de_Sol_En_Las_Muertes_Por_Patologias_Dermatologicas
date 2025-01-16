# COMPRACIÓN DEFUNCIONES, RADIACIÓN SOLAR Y HORAS DE SOL

library(ggplot2)

datos_defunciones_2022
datos_horas_de_sol
datos_radiacion_solar

# Asegurarse de que los datos de radiación solar estén en la misma escala
datos_radiacion_solar$RadiacionSolar <- datos_radiacion_solar$KW_por_m2 * 100

# Combinar los tres conjuntos de datos por la clave "Comunidad"
datos_completo <- merge(datos_defunciones_2022, datos_horas_de_sol, by = "Comunidad")
datos_completo <- merge(datos_completo, datos_radiacion_solar, by = "Comunidad")

# Transformar los datos a formato largo para ggplot
datos_completo_largo <- datos_completo %>%
  pivot_longer(cols = c(Densidad, HorasDeSol, KW_por_m2), 
               names_to = "Variable", 
               values_to = "Valor")

# Crear el gráfico comparativo
grafico_completo <- ggplot(datos_completo_largo, aes(x = Comunidad, y = Valor, fill = Variable)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Defunciones, Horas de Sol y Radiación Solar por Comunidad",
       x = "Comunidad",
       y = "Valores",
       fill = "Variable") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

grafico_completo

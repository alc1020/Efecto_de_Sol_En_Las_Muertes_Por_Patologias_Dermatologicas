# GRÁFICO COMPARATIVO DE DENSIDAD DE DEFUNCIONES POR CÁNCER DE PIEL Y RADIACIÓN SOLAR POR COMUNIDAD AUTÓNOMA

library(ggplot2)
library(dplyr)
library(tidyr)

datos_radiacion_solar
datos_densidad

def_rad <- merge (datos_densidad, datos_radiacion_solar, by= "Comunidad")
def_rad <- def_rad %>%
  mutate(
    Densidad = Densidad * 10000,  # Multiplicar la densidad por 10,000
    KW_por_m2 = KW_por_m2 /10,
  )
def_rad

defs_rad <- def_rad %>%
  pivot_longer(cols = c(Densidad, KW_por_m2), 
               names_to = "Variable", 
               values_to = "Valor")

ggplot(defs_rad, aes(x = reorder(Comunidad, Valor), y = Valor, fill = Variable)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7) + 
  labs(
    title = "Muertes y KW/m² por ccaa",
    x = "Comunidad Autónoma",
    y = "Valores (Ajustados)",
    fill = "Variable"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "top"
  ) +
  scale_fill_manual(values = c("Densidad" = "steelblue", "KW_por_m2" = "orange"))

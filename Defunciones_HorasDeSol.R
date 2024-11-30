library(ggplot2)
datos_defunciones_2022
datos_horas_de_sol

datos_horas_de_sol$HorasDeSol <- datos_horas_de_sol$HorasDeSol*100 

datos_horas_sol_def <- merge(datos_defunciones_2022, datos_horas_de_sol, by = "Comunidad")
datos_horas_sol_def
 



datos_horas_sol_def_largo <- datos_horas_sol_def %>%
  pivot_longer(cols = c(Defunciones, HorasDeSol), 
               names_to = "Variable", 
               values_to = "Valor")


grafico_horas_sol_def <- ggplot(datos_horas_sol_def_largo, aes(x = Comunidad, y = Valor, fill = Variable)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Defunciones y Horas de Sol por Comunidad",
       x = "Comunidad",
       y = "Valores",
       fill = "Variable") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

grafico_horas_sol_def

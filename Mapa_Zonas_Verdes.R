#### Mapa de la cantidad de zonas verdes m²/hab



Provs <- esp_get_prov()%>%
  rename("Provincia"=ine.prov.name)
provincias<-st_as_sf(inner_join(y=Provs, x= zonas_verdes, by="Provincia"))
Can <- esp_get_can_box()
ggplot(provincias) +
  geom_sf(aes(fill =Parques m²/hab),
          color = "grey70",
          linewidth = .3
  ) +
  geom_sf(data = Can, color = "grey70") +
  geom_sf_label(aes(label = Parques m²/hab),
                fill = "white", alpha = 0.5,
                size = 3,
                label.size = 0
  ) +
  scale_fill_gradientn(
    colors = hcl.colors(15, "Greens", rev = TRUE),
    n.breaks = 10,
    labels = function(x) {
      sprintf("%1.1f%%", 1 * x)
    },
    guide = guide_legend(title = "parques")
  ) +
  theme_void() +
  theme(legend.position = c(0.1, 0.6))
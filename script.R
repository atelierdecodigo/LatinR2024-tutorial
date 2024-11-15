# LatinR 2024
#
# Tutorial: Llevá tus gráficos con ggplot2 al siguiente nivel
# Docentes: Noelia Stetie & Macarena Quiroga



# Paquetes y funciones #########################################################
library(tidyverse)



# Base de datos ################################################################
df <- read_csv("salarios_uba_sep_24.csv")

df <- df %>% 
  mutate(across(where(is.character), as.factor))
df <- df %>% 
  mutate(antiguedad = as.factor(antiguedad))


# categoria: categoría docente con 5 niveles: titular, asociado, adjunto, jtp, ayudante de 1°
# dedicacion: solo categoría exclusiva
# antiguedad: años de antigüedad docente con 3 niveles: 0, 10 y 20
# sueldo_bruto: en pesos de septiembre
# cot_dolar: cotización del dólar de septiembre
# sueldo_dolar: sueldo equivalente en dólares



# Gráfico base en ggplot 2 #####################################################

# gráfico de barras
g_barras <- 
  ggplot(df) + 
  aes(x = categoria, y = sueldo_dolar, fill = antiguedad) + 
  geom_bar(stat = "identity", position = "dodge")


# gráfico de perfiles
g_perfiles <- 
  ggplot(df) + 
  aes(x = antiguedad, y = sueldo_dolar, group = categoria, color = categoria) +
  geom_line(linewidth = 1) +
  geom_point(size = 3)



# Parte 1: Texto ###############################################################

# 4° capa: "labs" --> títulos y leyendas
g_barras + 
  labs(title = "Incremento salarial (US$) por antigüedad para cada categoría docente", 
       y = "sueldo en dólares",
       x = "categorías docentes",
       fill = "antigüedad")

# cortar el título (o cualquier texto)
g_barras + 
  labs(title = "Incremento salarial (US$) por antigüedad\npara cada categoría docente", 
       y = "sueldo en dólares",
       x = "categorías docentes",
       fill = "antigüedad")

# nombres de niveles de las variables
g_barras <- g_barras + 
  labs(title = "Incremento salarial (US$) por antigüedad\npara cada categoría docente", 
       y = "sueldo en dólares",
       x = "categorías docentes",
       fill = "antigüedad") + 
  scale_x_discrete(labels = c("adjunto" = "Adjunto", "asociado" = "Asociado", 
                              "atp1" = "ATP 1°", "jtp" = "JTP", "titular" = "Titular")) +
  scale_fill_discrete(labels = c("0" = "0 años", "10" = "10 años", "20" = "20 años"))

# theme() y element_text()
# theme(
#   text = # all text items
#     plot.title = 
#     plot.subtitle = 
#     plot.caption = # bottom right
#     plot.tag =  # top left
#     axis.title = # axis labels
#     axis.title.x = 
#     axis.title.y = 
#     axis.text = # axis tick labels
#     axis.text.x = 
#     axis.text.y = 
#     legend.title = 
#     legend.text = 
# )
# 
# 
# element_text(
#   face = NULL, 
#   color = NULL, 
#   size = NULL,
#   family = NULL
# )
# 

g_barras + 
  theme(text = element_text(face = "bold")) # bold.italic, italic

g_barras + 
  theme(plot.title = element_text(color = "deeppink4", 
                                    face = "bold",
                                    family = "times")) # mono
g_barras + 
  theme(plot.title = element_textbox_simple(
  size = 12,
  face = "bold",
  linetype = 1,
  box.color = "coral3",
  fill = "bisque",
  padding = margin(5, 5, 5, 5),
  margin = margin(10, 0, 10, 0)))











# Parte 2: Colores

# Parte 3: Paletas

# Parte 4: Guardado








# Links útiles #################################################################

# R Graph Gallery: https://www.r-graph-gallery.com
# Tidyverse: https://www.tidyverse.org/
# Libro "R for Data Science": https://r4ds.had.co.nz/index.html
# Colores incorporados en R: https://r-charts.com/es/colores/
# Cheat sheets: https://rstudio.com/resources/cheatsheets/
# Tutoriales de dplyr - Parte 1: https://www.kaggle.com/jessemostipak/dive-into-dplyr-tutorial-1
# Tutoriales de dplyr - Parte 2: https://www.kaggle.com/jessemostipak/dive-deeper-into-dplyr-tutorial-2
# Introductory tutorials on data vis and wrangling in R: https://r-bootcamp.netlify.app/
# Instructivos paso a paso de ggplot: http://www.cookbook-r.com/Graphs/
# Instructivo interactivo con ejemplos de todas las scales: https://ggplot2tor.com/scales/
# Color Brewer: https://colorbrewer2.org/

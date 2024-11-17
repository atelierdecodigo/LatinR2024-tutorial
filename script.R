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

# orden de niveles de las variables (solo en el gráfico)
g_barras <- g_barras + 
  labs(title = "Incremento salarial (US$) por antigüedad\npara cada categoría docente", 
       y = "sueldo en dólares",
       x = "categorías docentes",
       fill = "antigüedad") + 
  scale_x_discrete(limits = c("titular", "asociado", "adjunto", "jtp", "atp1"), # reordeno
                   labels = c("adjunto" = "Adjunto", "asociado" = "Asociado", 
                              "atp1" = "ATP 1°", "jtp" = "JTP", "titular" = "Titular")) +
  scale_fill_discrete(labels = c("0" = "0 años", "10" = "10 años", "20" = "20 años"))



# theme() y element_text()
# theme(
#   text = # todo el texto
#     plot.title = 
#     plot.subtitle = 
#     plot.caption =
#     plot.tag = 
#     axis.title =
#     axis.title.x = 
#     axis.title.y = 
#     axis.text = 
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
  size = 12, # tamaño fuente
  face = "bold",
  linetype = 1, # agrega borde
  box.color = "coral3", # color borde
  fill = "bisque", # color de relleno interno
  padding = margin(5, 5, 5, 5), # margen interno
  margin = margin(10, 0, 10, 0))) # margen externo

# valores en el gráfico: geom_text() & geom_text_repel()
g_barras +
  geom_text(aes(label = round(sueldo_dolar)), 
            position = position_dodge(width = 0.9), 
            vjust = -0.5,
            size = 3)


## Ejercicio 1: cambiar texto

# Tomen el g_perfiles y reordenen las categorías docentes, cambien los nombres de las variables 
# para que estén todos con mayúsculas, en itálicas de un color que elijan.

g_perfiles + 
  labs(title = "Incremento salarial (US$) por antigüedad\npara cada categoría docente", 
       y = "sueldo en dólares",
       x = "antigüedad docente",
       color = "categoría\ndocente") + 
  scale_color_discrete(limits = c("titular", "asociado", "adjunto", "jtp", "atp1"), 
                       labels = c("adjunto" = "Adjunto", "asociado" = "Asociado", 
                                  "atp1" = "ATP 1°", "jtp" = "JTP", "titular" = "Titular")) + 
  theme(plot.title = element_text(face = "italic", color = "darkolivegreen"),
        axis.title.x = element_text(face = "italic", color = "darkolivegreen"),
        axis.title.y = element_text(face = "italic", color = "darkolivegreen"),
        legend.title = element_text(face = "italic", color = "darkolivegreen"))





# Parte 2: Colores #############################################################

# color vs fill

# gráfico base
ggplot(df) + 
  aes(x = categoria, y = sueldo_dolar) + 
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Incremento salarial (US$) por antigüedad\npara cada categoría docente", 
       y = "sueldo en dólares",
       x = "categorías docentes",
       fill = "antigüedad") + 
  scale_x_discrete(limits = c("titular", "asociado", "adjunto", "jtp", "atp1"), 
                   labels = c("adjunto" = "Adjunto", "asociado" = "Asociado", 
                              "atp1" = "ATP 1°", "jtp" = "JTP", "titular" = "Titular"))

# color en el geom_
ggplot(df) + 
  aes(x = categoria, y = sueldo_dolar) + 
  geom_bar(stat = "identity", position = "dodge", color = "maroon") +
  labs(title = "Incremento salarial (US$) por antigüedad\npara cada categoría docente", 
       y = "sueldo en dólares",
       x = "categorías docentes",
       fill = "antigüedad") + 
  scale_x_discrete(limits = c("titular", "asociado", "adjunto", "jtp", "atp1"), 
                   labels = c("adjunto" = "Adjunto", "asociado" = "Asociado", 
                              "atp1" = "ATP 1°", "jtp" = "JTP", "titular" = "Titular"))

# fill en el geom_
ggplot(df) + 
  aes(x = categoria, y = sueldo_dolar) + 
  geom_bar(stat = "identity", position = "dodge", fill = "maroon") +
  labs(title = "Incremento salarial (US$) por antigüedad\npara cada categoría docente", 
       y = "sueldo en dólares",
       x = "categorías docentes",
       fill = "antigüedad") + 
  scale_x_discrete(limits = c("titular", "asociado", "adjunto", "jtp", "atp1"), 
                   labels = c("adjunto" = "Adjunto", "asociado" = "Asociado", 
                              "atp1" = "ATP 1°", "jtp" = "JTP", "titular" = "Titular"))

# color en aesthetics
ggplot(df) + 
  aes(x = categoria, y = sueldo_dolar, color = antiguedad) + 
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Incremento salarial (US$) por antigüedad\npara cada categoría docente", 
       y = "sueldo en dólares",
       x = "categorías docentes",
       fill = "antigüedad") + 
  scale_x_discrete(limits = c("titular", "asociado", "adjunto", "jtp", "atp1"), 
                   labels = c("adjunto" = "Adjunto", "asociado" = "Asociado", 
                              "atp1" = "ATP 1°", "jtp" = "JTP", "titular" = "Titular"))

# fill en aesthetics
ggplot(df) + 
  aes(x = categoria, y = sueldo_dolar, fill = antiguedad) + 
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Incremento salarial (US$) por antigüedad\npara cada categoría docente", 
       y = "sueldo en dólares",
       x = "categorías docentes",
       fill = "antigüedad") + 
  scale_x_discrete(limits = c("titular", "asociado", "adjunto", "jtp", "atp1"), 
                   labels = c("adjunto" = "Adjunto", "asociado" = "Asociado", 
                              "atp1" = "ATP 1°", "jtp" = "JTP", "titular" = "Titular"))


# colores por nombre
g_barras + 
  scale_fill_manual(values = c("0" = "deepskyblue4", "10" = "aquamarine4", "20" = "firebrick"),
                    labels = c("0" = "0 años", "10" = "10 años", "20" = "20 años"))

# colores por código hex
g_barras + 
  scale_fill_manual(values = c("0" = "#CD6090", "10" = "#8B8386", "20" = "#548B54"),
                    labels = c("0" = "0 años", "10" = "10 años", "20" = "20 años"))

# transparencia: alpha
ggplot(df) + 
  aes(x = categoria, y = sueldo_dolar, fill = antiguedad) + 
  geom_bar(stat = "identity", position = "dodge", alpha = 0.7) +
  labs(title = "Incremento salarial (US$) por antigüedad\npara cada categoría docente", 
       y = "sueldo en dólares",
       x = "categorías docentes",
       fill = "antigüedad") + 
  scale_x_discrete(limits = c("titular", "asociado", "adjunto", "jtp", "atp1"), 
                   labels = c("adjunto" = "Adjunto", "asociado" = "Asociado", 
                              "atp1" = "ATP 1°", "jtp" = "JTP", "titular" = "Titular"))

# scale_color_gradient()
ggplot(df) + 
  aes(x = antiguedad, y = sueldo_dolar, group = categoria, color = sueldo_dolar) +
  geom_line(linewidth = 1) +
  geom_point(size = 3) + 
  scale_color_gradient(low = "#FFB6C1", high = "#B03060")

ggplot(df) + 
  aes(x = categoria, y = sueldo_dolar, fill = sueldo_dolar) + 
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_gradient(low = "#BCD2EE", high = "#B03060") + 
  scale_x_discrete(limits = c("atp1", "jtp", "adjunto", "asociado", "titular"), 
                   labels = c("adjunto" = "Adjunto", "asociado" = "Asociado", 
                              "atp1" = "ATP 1°", "jtp" = "JTP", "titular" = "Titular"))

# tema

# cambio de tema
g_barras +
  theme_minimal() # fondo transparente

g_barras + 
  theme_dark()


# customizar fill & color en el tema (element_rect())
g_barras + 
  theme(panel.background = element_rect(fill = '#FFA07A', color = "#548B54"),
        panel.grid = element_line(color = "#8B0000"))




# Parte 3: Paletas #############################################################

# guardar una paleta propia
paleta <- c("deepskyblue4", "aquamarine4", "firebrick")
g_barras + 
  scale_fill_manual(values = paleta,
                    labels = c("0" = "0 años", "10" = "10 años", "20" = "20 años"))

# usar paletas preexistentes

## RColorBrewer
g_barras +
  scale_fill_brewer(palette = "Set2",
                    direction = 1
                    # direction = -1
                    )

g_perfiles+
  scale_color_brewer(palette = "Accent")


## Viridis

a <- g_barras + 
  scale_fill_viridis_d(option = "viridis"
                        #"plasma"
                       #"magma"
                       #"inferno"
                       )

## Paletas temáticas

# Wes Anderson
install.packages("wesanderson")
g_barras + 
  scale_fill_manual(values = wesanderson::wes_palette("Royal2"))

# mariposas
devtools::install_github("junqueiragaabi/ButterflyColors")
g_barras + 
  scale_fill_manual(values = ButterflyColors::butterfly_palettes(specie = "lycorea_hallia"))

# artistas latines
devtools::install_github("jbgb13/peRReo") 
g_barras + 
  scale_fill_manual(values = peRReo::latin_palette("buenavista"))

## Chequear accesibilidad

install.packages("colorspace", repos = "http://R-Forge.R-project.org")
remotes::install_github("clauswilke/colorblindr")

colorblindr::cvd_grid(g_barras) # default
colorblindr::cvd_grid(a) # viridis




# Parte 4: Guardado  ############################################################

# copypaste

# export

# ggsave
ggsave("graf_barras.jpg", plot = g_barras, dpi = 600,
       width = 15, height = 10, units = "cm")


# para vectorizarlo y abrirlo en ppt
install.packages("svglite")
ggsave("graf_barras.svg")



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

# LatinR 2024
#
# Tutorial: Llevá tus gráficos con ggplot2 al siguiente nivel
# Docentes: Noelia Stetie & Macarena Quiroga



# Paquetes y funciones #########################################################
library(tidyverse)
library(ggtext)
library(ggrepel)



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
g_perfiles + 
  geom_text(aes(label = round(sueldo_dolar)), size = 2.5, color = "black")

g_perfiles + 
  geom_text(aes(label = round(sueldo_dolar)),
            vjust = -0.5, hjust = -0.3, size = 2.5, color = "black")

g_perfiles + 
  geom_text_repel(aes(label = round(sueldo_dolar)), size = 2.5, color = "black")

g_perfiles + 
  geom_label_repel(aes(label = round(sueldo_dolar)), size = 2.5, color = "black")



## Ejercicio 1: cambiar texto ###################################################

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



## Ejercicio 2: cambiar colores #################################################

# A partir del gráfico de barras con el que venimos trabajando, cambien los colores de
# la antigüedad docente. Utilicen khaki4 para los 0 años, lightpink para los 10 años y 
# maroon para los 20 años.

g_barras + 
  scale_fill_manual(values = c("0" = "khaki4", "10" = "lightpink", "20" = "maroon"),
                    labels = c("0" = "0 años", "10" = "10 años", "20" = "20 años"))



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


## viridis

a <- g_barras + 
  scale_fill_viridis_d(option = "viridis"
                       #"plasma"
                       #"magma"
                       #"inferno"
  )

## paletas temáticas

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


## chequear accesibilidad

install.packages("colorspace", repos = "http://R-Forge.R-project.org")
remotes::install_github("clauswilke/colorblindr")

colorblindr::cvd_grid(g_barras) # default
colorblindr::cvd_grid(a) # viridis



## Ejercicio 3: Paletas ########################################################

# Elegí tres colores para construir una paleta propia y aplicala al gráfico de barras.
# Comprobá que sean aptos para personas con daltonismo y, de ser necesario, modificala.

paleta2 <- c("deeppink4", "darkslategray4", "orangered3")
b <- g_barras + 
  scale_fill_manual(values = paleta2,
                    labels = c("0" = "0 años", "10" = "10 años", "20" = "20 años"))

colorblindr::cvd_grid(b)



# Parte 4: Guardado  ###########################################################

# combinación de gráficos
devtools::install_github("thomasp85/patchwork")
library(patchwork)

g_barras + g_perfiles
g_barras / g_perfiles

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
# Colores incorporados en R: https://r-charts.com/es/colores/
# ggplot2 cheat sheet: https://rstudio.github.io/cheatsheets/html/data-visualization.html
# Instructivos paso a paso de ggplot: http://www.cookbook-r.com/Graphs/
# Instructivo interactivo con ejemplos de todas las scales: https://ggplot2tor.com/scales/
# Color Brewer: https://colorbrewer2.org/

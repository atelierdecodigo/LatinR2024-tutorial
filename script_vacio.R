# LatinR 2024
#
# Tutorial: Llevá tus gráficos con ggplot2 al siguiente nivel
# Docentes: Noelia Stetie & Macarena Quiroga



# Paquetes y funciones #########################################################



# Base de datos ################################################################



# categoria: categoría docente con 5 niveles: titular, asociado, adjunto, jtp, ayudante de 1°
# dedicacion: solo categoría exclusiva
# antiguedad: años de antigüedad docente con 3 niveles: 0, 10 y 20
# sueldo_bruto: en pesos de septiembre
# cot_dolar: cotización del dólar de septiembre
# sueldo_dolar: sueldo equivalente en dólares



# Gráfico base en ggplot 2 #####################################################

# gráfico de barras



# gráfico de perfiles




# Parte 1: Texto ###############################################################

# 4° capa: "labs" --> títulos y leyendas



# cortar el título (o cualquier texto)



# nombres de niveles de las variables



# orden de niveles de las variables (solo en el gráfico)



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



# valores en el gráfico: geom_text() & geom_text_repel()




## Ejercicio 1: cambiar texto ###################################################

# Tomen el g_perfiles y reordenen las categorías docentes, cambien los nombres de las variables 
# para que estén todos con mayúsculas, en itálicas de un color que elijan.




# Parte 2: Colores #############################################################

# color vs fill



# gráfico base



# color en el geom_



# fill en el geom_



# color en aesthetics



# fill en aesthetics



# colores por nombre



# colores por código hex



# transparencia: alpha



# scale_color_gradient()



# tema

# cambio de tema



# customizar fill & color en el tema (element_rect())




## Ejercicio 2: cambiar colores #################################################

# A partir del gráfico de barras con el que venimos trabajando, cambien los colores de
# la antigüedad docente. Utilicen khaki4 para los 0 años, lightpink para los 10 años y 
# maroon para los 20 años.




# Parte 3: Paletas #############################################################

# guardar una paleta propia



# usar paletas preexistentes

## RColorBrewer



## viridis



## paletas temáticas

# Wes Anderson



# mariposas



# artistas latines



## chequear accesibilidad




## Ejercicio 3: Paletas ########################################################

# Elegí tres colores para construir una paleta propia y aplicala al gráfico de barras.
# Comprobá que sean aptos para personas con daltonismo y, de ser necesario, modificala.




# Parte 4: Guardado  ###########################################################

# combinación de gráficos



# copypaste



# export



# ggsave



# para vectorizarlo y abrirlo en ppt




# Links útiles #################################################################

# R Graph Gallery: https://www.r-graph-gallery.com
# Colores incorporados en R: https://r-charts.com/es/colores/
# ggplot2 cheat sheet: https://rstudio.github.io/cheatsheets/html/data-visualization.html
# Instructivos paso a paso de ggplot: http://www.cookbook-r.com/Graphs/
# Instructivo interactivo con ejemplos de todas las scales: https://ggplot2tor.com/scales/
# Color Brewer: https://colorbrewer2.org/

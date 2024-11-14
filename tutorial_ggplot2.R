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


# categoria:
# dedicacion:
# antigüedad:
# sueldo_bruto
# cot_dolar:
# sueldo_dolar:



# Gráfico base en ggplot 2 #####################################################

# gráfico de barras
ggplot(df) + 
  aes(x = categoria, y = sueldo_bruto, fill = categoria) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ antiguedad)

# gráfico de perfiles
ggplot(df) + 
  aes(x = antiguedad, y = sueldo_bruto, group = categoria, color = categoria) +
  geom_line(linewidth = 1) +
  geom_point(size = 3)


# Customización de texto #######################################################
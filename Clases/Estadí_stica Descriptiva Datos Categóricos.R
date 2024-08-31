
###############################################
# Estadística descriptiva                     #
# (datos categóricos)                         #
###############################################

## Limpieza del "Environment" y liberación de espacio en memoria
## (buena práctica)
rm(list = ls(all.names = TRUE))
gc()


# 1. Datos ----------------------------------------------------------------

## Trabajaremos con los datos del CONEVAL: "Anexo estadístico 2010-2020" 
## sobre la Medición de la pobreza: "Pobreza a nivel municipio 2010-2020" 
## disponible en: 
## https://www.coneval.org.mx/Medicion/Paginas/Pobreza-municipio-2010-2020.aspx

## De acuerdo a la metodología para la medición de la pobreza en México una 
## persona se encuentra en situación de:
##
##  - Pobreza: cuando tiene un ingreso inferior a la Línea de Pobreza por 
##             Ingresos (valor de la canasta alimentaria más la no alimentaria) 
##             y presenta al menos una de las seis carencias sociales 
##             (alimentación, rezago educativo, salud, seguridad social, 
##             servicios básicos de la vivienda, y calidad y espacios de la vivienda).
##
##  - Pobreza extrema: cuando su ingreso es inferior a la Línea de Pobreza Extrema 
##                     por Ingresos (valor de la canasta alimentaria) y presenta al 
##                     menos tres de las seis carencias sociales consideradas en la Metodología.

## Nuestro objetivo será clasificar el total de individuos que están contenidos 
## en municipios cuya población tiene de 0% a 25% de pobreza, entre 25% y 50% y más de 50%. 
## El análisis lo haremos a nivel nacional y también por entidad federativa.

##  -------------------------------------------------------------------
## |Variable        | Descripción                                      |
## |-------------------------------------------------------------------|
## | Entidad        | Nombre de la entidad federativa                  | 
## | Municipio      | Nombre del municipio                             |
## | Porcentaje2020 | Porcentaje de personas en situación de "pobreza" |
## | Personas2020   | Total de personas en situación de "pobreza"      |
##  -------------------------------------------------------------------


# 1.1 Lectura de datos ----------------------------------------------------

## install.packages("readxl")
library(readxl)

## Guardamos la base en el "DataFrame" "Datos"
Datos <- read_excel(path = "Concentrado_indicadores_de_pobreza_2020.xlsx",
                    sheet = "Concentrado municipal", #Permite especificar la hoja
                    range = cell_cols(c("C:N")), #Rango de celdas
                    col_names = LETTERS[3:14])

# 1.2 Variables de interés y limpieza de datos ----------------------------

## Seleccionamos las columnas "C", "E", "K" y "N"
Datos <- Datos[,c("C", "E", "K", "N")]

## Cambiamos los nombres de las columnas (variables)
colnames(Datos) <- c("Entidad", "Municipio", "Porcentaje2020", "Personas2020")

## Estructura del DataFrame "Datos"
str(Datos)

## Quitamos las primeras 4 filas del DataFrame
## - Convertimos la variable "Entidad" de tipo character a tipo factor
## - Convertimos la variable "Porcentaje2020" de tipo character a tipo numeric
Datos <- Datos[-c(1:4),]
Datos$Entidad <- factor(Datos$Entidad)
Datos$Porcentaje2020 <- as.numeric(Datos$Porcentaje2020)
Datos$Personas2020 <- as.numeric(Datos$Personas2020)

## Verificamos si hay datos faltantes
Datos[is.na(Datos$Porcentaje2020),]

## Quitamos los datos faltantes del DataFrame "Datos"
Datos <- Datos[!is.na(Datos$Porcentaje2020),]

## Estructura del DataFrame "Datos" limpios
str(Datos)


# 1.3 Clasificación de la población (nuevas variables) --------------------

## Definimos la variable tipo factor "Pobreza2020Cat" que categoriza a la variable
## tipo numeric "Porcentaje2020" en los niveles [0,25], (25,50] y (50,100]
Datos$Pobreza2020Cat <- cut(Datos$Porcentaje2020,
                            breaks = c(0, 25, 50, 100),
                            labels = c("[0,25]", "(25,50]", "(50,100]"), #Vector con los cortes
                            include.lowest = TRUE,#Incluye el valor m?s peque?o en el primer intervalo
                            right = TRUE) #Si el intervalo derecho esta cerrado y el izquierdo abierto

## Estructura de los "Datos"
str(Datos)


# 2. Estadísticas descriptivas --------------------------------------------

# 2.1 Tabla de frecuencias absolutas --------------------------------------

## Función table()
### Total de municipios clasificados según el rango de población
### en situación de pobreza.
FA_Nacional <- table(Datos$Pobreza2020Cat)
FA_Nacional

## Interpretación: - 140 municipios del país están contenidos en municipios cuyo porcentaje de población
##                   en situación de pobreza va de [0%, 25%].
##                 - 629 municipios del país están contenidos en municipios cuyo porcentaje de población
##                   en situación de pobreza va de (25%, 50%].
##                 - 1,697 municipios del país están contenidos en municipios cuyo porcentaje de población
##                   en situación de pobreza es mayor al 50%.

### Total de personas que están contenidas en municipios cuya población 
### en situación de pobreza va de [0%, 25%].
sum(Datos$Personas2020[Datos$Pobreza2020Cat == "[0,25]"])

### Total de personas que están contenidas en municipios cuya población 
### en situación de pobreza va de (25%, 50%].
sum(Datos$Personas2020[Datos$Pobreza2020Cat == "(25,50]"])

### Total de personas que están contenidas en municipios cuya población 
### en situación de pobreza es mayor al 50%.
sum(Datos$Personas2020[Datos$Pobreza2020Cat == "(50,100]"])

### Lo mismo pero con otro "enfoque" (enfoque tidyverse)
### install.packages("dplyr")
library(dplyr)
Datos %>% group_by(Pobreza2020Cat) %>% 
  summarise(PersonasPobreza = sum(Personas2020))


# 2.2 Tabla de frecuencias relativas --------------------------------------

## Función table() y prop.table()
### Porcentaje de municipios clasificados según el rango de población
### en situación de pobreza.
FR_Nacional <- prop.table(FA_Nacional)
round(FR_Nacional,2)

## Interpretación: - 6% de los municipios del país están contenidos en municipios cuyo porcentaje de población
##                   en situación de pobreza va de [0%, 25%].
##                 - 26% de los municipios del país están contenidos en municipios cuyo porcentaje de población
##                   en situación de pobreza va de (25%, 50%].
##                 - 69% de los municipios del país están contenidos en municipios cuyo porcentaje de población
##                   en situación de pobreza es mayor al 50%.


### Total de personas en situación de pobreza (variable auxiliar)
Total <- sum(Datos$Personas2020)
Total

### Porcentaje de personas que están contenidas en municipios cuya población 
### en situación de pobreza va de [0%, 25%].
round(sum(Datos$Personas2020[Datos$Pobreza2020Cat == "[0,25]"])/Total,2)

### Porcentaje de personas que están contenidas en municipios cuya población 
### en situación de pobreza va de (25%, 50%]
round(sum(Datos$Personas2020[Datos$Pobreza2020Cat == "(25,50]"])/Total,2)

### Porcentaje de personas que están contenidas en municipios cuya población 
### en situación de pobreza va de (50%, 100%]
round(sum(Datos$Personas2020[Datos$Pobreza2020Cat == "(50,100]"])/Total,2)

### Lo mismo pero con otro "enfoque" (enfoque tidyverse)
### install.packages("dplyr")
### library(dplyr)
Datos %>% group_by(Pobreza2020Cat) %>% 
  summarise(PorcentajePerPob = sum(Personas2020)/Total)


# 2.3 Tabla de frecuencias absolutas de dos variables categóricas ---------

## Función table()
### Total de municipios clasificados según el rango de población
### en situación de pobreza por entidad.
FA_Entidad <- table(Datos$Entidad,Datos$Pobreza2020Cat)
FA_Entidad

### Total de municipios clasificados según el rango de población
### en situación de pobreza por entidad "ordenada".
FA_Entidad[order(-FA_Entidad[,3]),]

### Interpretación: - 6 municipios de Oaxaca están contenidos en municipios cuyo porcentaje de población
###                   en situación de pobreza va de [0%, 25%].
###                 - 47 municipios de Oaxaca están contenidos en municipios cuyo porcentaje de población
###                   en situación de pobreza va de (25%, 50%].
###                 - 517 municipios de Oaxaca están contenidos en municipios cuyo porcentaje de población
###                   en situación de pobreza es mayor al 50%.


### Total de personas clasificadas según el rango de población
### en situación de pobreza por entidad "ordenada".
###install.packages("tidyr")
###install.packages("tibble")
library(tidyr)
library(tibble)
Datos %>% group_by(Entidad, Pobreza2020Cat) %>% 
  summarise(TotalPersonas = sum(Personas2020)) %>% 
  spread(key = Pobreza2020Cat, value = TotalPersonas, fill = 0) %>% 
  column_to_rownames(var = "Entidad") %>% 
  arrange(desc(`(50,100]`)) %>% 
  as.matrix()

### Interpretación: - 3,550,608 personas del estado de México están contenidos en municipios cuyo porcentaje 
##                    de población en situación de pobreza va de (25%, 50%].
###                 - 5,655,574 personas del estado de México están contenidos en municipios cuyo porcentaje 
##                    de población en situación de pobreza es mayor al 50%.


# 2.4 Tabla de frecuencias relativas de dos variables categóricas ---------

## Función table() y prop.table()
### Porcentaje de municipios clasificados según el rango de población
### en situación de pobreza por entidad.
FR_Entidad <- prop.table(FA_Entidad, margin = 1)
round(FR_Entidad,2)

### Porcentaje de municipios clasificados según el rango de población
### en situación de pobreza por entidad "ordenada".
round(FR_Entidad[order(-FR_Entidad[,3]),],2)

## Interpretación: - 2% de los municipios en Chiapas están contenidos 
##                   en municipios cuyo porcentaje de población en situación 
##                   de pobreza va de (25%, 50%].
##                   98% de los municipios en Chiapas están contenidos 
##                   en municipios cuyo porcentaje de población en situación 
##                   de pobreza es mayor al 50%.


### Porcentaje de personas clasificadas según el rango de población
### en situación de pobreza por entidad "ordenada".
FR_Entidad_Personas <- Datos %>% group_by(Entidad, Pobreza2020Cat) %>% 
  summarise(TotalPersonas = sum(Personas2020)) %>% 
  spread(key = Pobreza2020Cat, value = TotalPersonas, fill = 0) %>% 
  column_to_rownames(var = "Entidad") %>%
  as.matrix() %>% 
  prop.table(margin = 1) %>% 
  round(2)

### Desordenada
FR_Entidad_Personas

### Ordenada
FR_Entidad_Personas[order(-FR_Entidad_Personas[,3]),]

## Interpretación: - 4% de las personas en situación de pobreza en Guerrero 
##                   están contenidas en municipios cuyo porcentaje de población en 
##                   situación de pobreza esta entre el 25 y 50%.
##                 - 96% de las personas en situación de pobreza en Guerrero 
##                   están contenidas en municipios cuyo porcentaje de población en 
##                   situación de pobreza esta entre el 50% y 100%.


# 3. Visualización de datos -----------------------------------------------

# 3.1 Gráfica de barras ---------------------------------------------------

## Gráfica de barras utilizando frecuencias absolutas
FA_Barras <- barplot(FA_Nacional,
                     col = c("steelblue2","steelblue3","steelblue4"),
                     main = "Frecuencias Absolutas",
                     cex.main = 0.7,
                     xlab = "Clasificación de los municipios, según rango de pobreza",
                     ylab = "Total",
                     cex.lab = 0.7, 
                     cex.axis = 0.7, 
                     las = 1, 
                     ylim = c(0,2000))
text(FA_Barras,
     y = FA_Nacional, 
     labels = FA_Nacional, 
     pos = 3,
     cex = 0.7, 
     col = "mediumpurple3") 

## Gráfica de barras utilizando frecuencias relativas
## install.packages("lessR")
library(lessR)
BarChart(data = Datos,
         x = Pobreza2020Cat)


# 3.2 Gráfica de pie ------------------------------------------------------

## Gráfica de pie utilizando frecuencias absolutas
pie(FA_Nacional,
    labels = FA_Nacional, 
    col = c("white", "lightblue", "mistyrose"),
    main = "Pie Frecuencias Absolutas", 
    cex.main = 0.7, 
    xlab = "Clasificación de los municipios, según rango de pobreza", 
    cex.lab = 0.7, 
    cex.axis = 0.7) 
legend("topleft", 
       legend = c("[0,25]","(25,50]","(50,100]"),
       fill =  c("white", "lightblue", "mistyrose"),
       cex = 0.75)

## Gráfica de pie utilizando frecuencias relativas
## library(lessR)
PieChart(data = Datos,
         x = Pobreza2020Cat, 
         hole = 0)


# 3.3 Gráfica de Mosaico --------------------------------------------------

## library(lessR)
BarChart(x = Entidad,
         by = Pobreza2020Cat,
         data = Datos,
         horiz = TRUE,
         fill = "blues",
         transparency = .5,
         stack100 = TRUE)

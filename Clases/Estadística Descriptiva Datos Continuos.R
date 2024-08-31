#############################################
# Estadística descriptiva (datos numéricos) #
#############################################

## Limpieza del "Environment" y liberación de espacio en memoria
rm(list = ls(all.names = TRUE))
gc()


# 1. Datos ----------------------------------------------------------------

# 1.1 Lectura de datos y descriptor ---------------------------------------

## Fijamos directorio y guardamos la base en el DataFrame "Datos"
setwd("C:/Users/Aaron/Documents/R Clases")
Datos <- read.csv("INE_DISTRITO_2020.CSV", 
                  encoding = "latin1")

## Visualizar el nombre de las columnas
names(Datos)

## Visualizar las primeras cuatro entradas 
head(Datos)

## Guardamos el descriptor de variables en el DataFrame "Descriptor"
Descriptor <- read.csv("Descriptor_indicadores_ECEG_Distrito_2020.csv.csv",
                       encoding = "latin1")


# 1.2 Variables de interés ------------------------------------------------

## Selección de variables
Datos <- Datos[,c("ENTIDAD", "DISTRITO", "NOM_ENT", "VPH_CEL", "PSINDER", "HOGJEF_F",
                  "POBTOT", "TVIVPARHAB", "TOTHOG","P_15YMAS","VPH_EXCSA","P15YM_AN",
                  "P15YM_SE", "P15PRI_IN")]

# Estructura de los datos
str(Datos)

# Cambiamos la variable "NOM_ENT" de tipo caracter a tipo factor
Datos$NOM_ENT <- factor(Datos$NOM_ENT)

# Estructura de los datos
str(Datos)


# 1.3 Totales ------------------------------------------------------------------

attach(Datos)
## Total de viviendas habitadas
sum(TVIVPARHAB) 

##Total de Población 
sum(POBTOT)

#Total de población de 15 años o más
sum(P_15YMAS)

detach(Datos)


# 1.4 Porcentajes (nuevas variables) --------------------------------------
library(tidyverse)
##Nueva columna con población analfabeta, sin escolaridad o primaria incompleta.
Datos<-mutate(Datos, P15_ASI=P15YM_AN+ P15YM_SE+ P15PRI_IN)

attach(Datos)

### A nivel de cada distrito con su respectiva entidad

## Porcentaje de viviendas particulares habitadas que disponen de teléfono celular.
Datos$Porcentaje_VPH_CEL <- VPH_CEL/TVIVPARHAB

##Porcentaje de viviendas que disponen de excusado
Datos$Porcentaje_VPH_EXCSA <-VPH_EXCSA/TVIVPARHAB

## Porcentaje de población sin afiliación a servicios de salud.
Datos$Porcentaje_PSINDER <- PSINDER/POBTOT

## Porcentaje de hogares censales con persona de referencia mujer.
Datos$Porcentaje_HOGJEF_F <- HOGJEF_F/TOTHOG

## Porcentaje de Población de 15 a 130 años analfabeta, sin escolaridad o con primaria incompleta
Datos$Porcentaje_P15_ASI <- P15_ASI/P_15YMAS

### A nivel nacional 

## Porcentaje de viviendas particulares habitadas que disponen de teléfono celular.
sum(VPH_CEL)/sum(TVIVPARHAB)*100

##Porcentaje de viviendas que disponen de excusado
sum(VPH_EXCSA)/sum(TVIVPARHAB)*100

## Porcentaje de población sin afiliación a servicios de salud.
sum(PSINDER)/sum(POBTOT)*100

## Porcentaje de hogares censales con persona de referencia mujer.
sum(HOGJEF_F)/sum(TVIVPARHAB)*100

## Porcentaje de Población de 15 a 130 años analfabeta, sin escolaridad o con primaria incompleta
sum(P15_ASI)/sum(P_15YMAS)*100

detach(Datos)

## 1.5 Creación de ID unico para cada distrito ---------------------------

length(unique(Datos$DISTRITO))

Datos<-mutate(Datos, ID_DIST=as.factor(paste(ENTIDAD,"-",DISTRITO, sep="")))

length(unique(Datos$ID_DIST))


# 2. Estadísticas descriptivas --------------------------------------------

# 2.1 Media muestral ------------------------------------------------------
mean(Datos$Porcentaje_VPH_CEL)


# 2.2 Mediana muestral ----------------------------------------------------
median(Datos$Porcentaje_VPH_CEL)


# 2.3 Cuantiles -----------------------------------------------------------

# Cuartiles (25%, 50% y 75%)
quantile(Datos$Porcentaje_VPH_CEL, 
         probs = c(.25, .5, .75))

quantile(Datos$Porcentaje_VPH_CEL, 
         probs = c(.1,.2,.3,.4, .5,.6,.7,.8,.9))

quantile(Datos$Porcentaje_VPH_CEL, 
         probs = 0.95)

# 3. Visualización de datos -----------------------------------------------

# 3.1 Histograma de frec. abs ---------------------------------------------
hist(Datos$Porcentaje_VPH_CEL, # Variable (columna) del dataframe que queremos gráficar.
     breaks = "Sturges", # Nombre del algoritmo que calcula el número de breaks ("cajitas").
     freq = TRUE, # Si es TRUE, el gráfico del histograma es una representación de frecuencias absolutas.
     col = "lightblue", # Color de las "cajitas".
     main = "Histograma de frecuencias absolutas", # Titulo.
     cex.main = 0.7, # Tamaño del titulo
     cex.sub = 0.7, # Tamaño del subtitulo.
     xlab = "% de viviendas particulares habitadas que disponen de teléfono celular", # Nombre del eje de las X's.
     ylab = "", # Nombre del eje de las Y's.
     cex.lab = 0.7, # Tamaño de letra de "xlab" y "ylab" (nombre de los ejes).
     cex.axis = 0.7, # Tamaño de letra de los valores de las X's y Y`s.
     las = 1) # "las = 1" Sirve para que los valores de las Y's se muestren de forma horizontal.


# 3.2 Histograma de densidades --------------------------------------------
hist(Datos$Porcentaje_VPH_CEL, # Variable (columna) del dataframe que queremos gráficar.
     breaks = "Sturges", # Nombre del algoritmo que calcula el número de breaks ("cajitas").
     freq = FALSE, # Si es FALSE, se grafican las densidades de probabilidad (de modo que el histograma tiene un área total de uno).
     col = "lightblue", # Color de las "cajitas".
     main = "Histograma de densidades", # Titulo.
     cex.main = 0.7, # Tamaño del titulo.
     xlab = "% de viviendas particulares habitadas que disponen de teléfono celular", # Nombre del eje de las X's.
     ylab = "", # Nombre del eje de las Y's.
     cex.lab = 0.7, # Tamaño de letra de "xlab" y "ylab" (nombre de los ejes).
     cex.axis = 0.7, # Tamaño de letra de los valores de las X's y Y`s.
     las = 1) # "las = 1" Sirve para que los valores de las Y's se muestren de forma horizontal.


# 3.5 Box-Plot ------------------------------------------------------------
boxplot(Datos$Porcentaje_VPH_CEL, # Variable (columna) del dataframe que queremos gráficar.
        col = "lightblue", # Color de la gráfica.
        main = "Box-Plot", # Titulo.
        cex.main = 0.7, # Tamaño del titulo.
        xlab = "% de viviendas particulares habitadas que disponen de teléfono celular", # Nombre del eje de las X's.
        cex.lab = 0.7, # Tamaño de letra de "xlab" y "ylab" (nombre de los ejes).
        cex.axis = 0.7, # Tamaño de letra de los valores de las X's y Y`s.
        las = 1, # "las = 1" Sirve para que los valores de las Y's se muestren de forma horizontal.
        horizontal = T) # Si es TRUE, la gráfica se muestra de forma horizontal. Si es FALSE, la gráfica se muestra de forma vertical.


# 4. Funciones por grupo --------------------------------------------------

# 4.1 summary() -----------------------------------------------------------
summary(Datos)


# 4.2 describe() ----------------------------------------------------------
library(psych)
describe(Datos)


# Box Plot por grupos con ggplot2 -----------------------------------------

##install.packages("dplyr")
##install.packages("ggplot2")
library(dplyr)
library(ggplot2)

Datos %>% 
  ggplot(aes(x=reorder(x = NOM_ENT,
                       X = Porcentaje_VPH_CEL,
                       FUN = median), 
             y=Porcentaje_VPH_CEL)) +
  geom_boxplot(fill="steelblue1") + 
  coord_flip() + 
  labs(title = "Porcentaje de viviendas que disponen de telefono celular",
       x="",
       y="") +
  theme_bw()




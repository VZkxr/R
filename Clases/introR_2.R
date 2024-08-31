rm(list = ls(all.names = TRUE))
gc()
# 5. Simulación de variables aleatorias ------------------------------------
# Normales (tamaño de muestra, media, desviación estándar)

vec_norm_est = rnorm(1000) # Normal estándar
vec_norm1 = rnorm(1000,10,25)

# Poisson (tamaño de muestra, media)
vec_pois = rpois(1000, 3)

# Ejemplo con distribución empírica para normales estándar
x <- seq(-5, 5, by=0.05)
y <- pnorm(x, mean = 0, sd = 1) # La función pnorm(x,mean = mu , sd = sigma) regresa
                                # la evaluación en x de la función de distribución
                                # de una normal de media mu y desv. est. sigma.
n = 500
vec_norm_est = rnorm(n)

## Usando la función ed
plot(x,y, type = 'l', col = 'red', lwd = 2)
#Función de distribución acumulativa empírica
plot.ecdf(vec_norm_est, pch = 2, col = "blue", add = TRUE)

## Usando la definición de distribución empírica
vec_norm_est = sort(vec_norm_est)
Z = c()
for (i in 1:length(vec_norm_est)) {
  z = i*(1/length(vec_norm_est))
  Z[i] = z
}
plot(x,y, type = 'l', col = 'red', lwd = 2)
points(vec_norm_est,Z)

## Ejemplo con distribución empírica para exponenciales
x <- seq(0.01, 20, by=0.05)
y <- pexp(x, rate = 1) # La función pexp(x,rate = lambda) regresa
                        # la evaluación en x de la función de distribución
                        # de una normal de media lambda.

n = 100
#rexp nos permite obtener n observaciones de una distribución exponencial
vec_exp = rexp(n, rate = 1)

plot(x,y, type = 'l', col = 'red', lwd = 2)
plot.ecdf(vec_exp, pch = 2, col = "blue", add = TRUE)


# 6. DataFrames -----------------------------------------------------------

# Ejemplo de la construcción de un DataFrame
## Vector con la variable "ID del paciente"
ID <- seq(1:4)

## Vector con la variable "Edad
edad <- c(25, 34, 28, 52)

## Vector con la variable "Tipo de diabetes"
diabetes <- c(1, 2, 1, 1)

## Vector con la variable "Estatus"
estatus <- c("Mala", "Regular", "Excelente", "Mala")

## Creamos el DataFrame "datos_pacientes" con la función data.frame()
datos_pacientes <- data.frame(ID, edad, diabetes, estatus)
View(datos_pacientes)

datos_pacientes <- datos_pacientes[order(datos_pacientes$edad),]

# 6.1 Manipulación --------------------------------------------------------

# Manipulación del DataFrame
## DataFrame "datos_pacientes"
datos_pacientes

## Seleccionar todos los elementos de la primera fila
datos_pacientes[1,]

## Selecciona todos los elementos de la segunda columna
datos_pacientes[,2]

## Selecciona todos los elementos de la variable edad
datos_pacientes$edad

# Ejemplo de la función rbind()
## DataFrame "datos_pacientes" original
datos_pacientes

## Creamos el DataFrame "nueva_observacion"
nueva_observacion <- data.frame(ID = 5,
                                edad = 40,
                                diabetes = 2,
                                estatus = "Excelente")

## Agregamos la "nueva_observacion" al DataFrame original "datos_pacientes"
datos_pacientes <- rbind(datos_pacientes, nueva_observacion)
View(datos_pacientes)

# Ejemplo de la función cbind()
## DataFrame "datos_pacientes" original
datos_pacientes

## Creamos el vector "estatura"
estatura <- c(1.75, 1.65, 1.85, 1.69, 1.73)

## Creamos el vector "peso"
peso <- c(75, 70, 81, 70, 75)

## Agregamos las variables "estatura" y "peso" al DataFrame original "datos_pacientes"
datos_pacientes <- cbind(datos_pacientes, estatura, peso)
View(datos_pacientes)

tipo_san <- c(1,2,3,4,5)
datos_pacientes <- cbind(datos_pacientes, tipo_san)
View(datos_pacientes)

## Eliminar columnas de mi DataFrame
datos_pacientes <- subset(datos_pacientes, select = -tipo_san)
View(datos_pacientes)

# Definir variables a partir de variables ya existentes
## DataFrame "datos_pacientes" original
datos_pacientes

## Utilizamos el símbolo $ para definir la variable IMC a partir de las 
## variables peso y estatura
datos_pacientes$IMC <- datos_pacientes$peso/(datos_pacientes$estatura)^2
View(datos_pacientes)

# 6.2 Factores ------------------------------------------------------------

# Ejemplo de variable tipo factor y la función factor()
## Vector con la variable "Tipo de diabetes"
diabetes <- c(1, 2, 1, 1)
class(diabetes)

## Vector con la variable "Estatus"
estatus <- c("Mala", "Regular", "Excelente", "Mala")
class(estatus)

## Convertimos el objeto diabetes de tipo "numeric" a tipo "factor"
diabetes <- factor(diabetes)
class(diabetes)
diabetes

## Convertimos el objeto estatus de tipo "character" a tipo "factor"
estatus <- factor(estatus)
class(estatus)
estatus

# Función str()
## Aplicamos la función str() al DataFrame "datos_pacientes"
str(datos_pacientes)

# Convertir variables entre factor, numeric y character
## Signo $ y función factor() 

## Accedemos a la variable "diabetes" y la cambiamos de tipo numeric a tipo factor
datos_pacientes$diabetes <- factor(datos_pacientes$diabetes)

## Accedemos a la variable "estatus" y la cambiamos de tipo character a tipo factor
datos_pacientes$estatus <- factor(datos_pacientes$estatus)

## Revisamos la estructura de "datos_pacientes"
str(datos_pacientes)

# 6.3 Filtrar y Ordenar ---------------------------------------------------

## Valores de "diabetes"
datos_pacientes$diabetes

## Comparación lógica: 
datos_pacientes$diabetes == "1"

## Valores de "estatus"
datos_pacientes$estatus

## Comparación lógica:
datos_pacientes$estatus == "Mala"

## Filtramos las observaciones donde la variable "diabetes" == "1"
datos_pacientes[datos_pacientes$diabetes == "1", ]

## Filtramos las observaciones donde la variable "estatus" == "Mala"
datos_pacientes[datos_pacientes$estatus == "Mala", ]

## Valores de "edad"
datos_pacientes$edad

## Comparación lógica: 
datos_pacientes$edad >= 30

## Filtramos las observaciones donde la variable "edad" >= 30
datos_pacientes[datos_pacientes$edad >= 30,]

## Valores de "edad"
datos_pacientes$edad

## Valores de "estatus"
datos_pacientes$estatus

## Comparación lógica doble: 
datos_pacientes$edad >= 30 & datos_pacientes$estatus == "Mala"

## Filtramos las observaciones donde la variable "edad" >= 30 y "estatus" == "Mala"
datos_pacientes[datos_pacientes$edad >= 30 & datos_pacientes$estatus == "Mala", ]

# Ejemplo de la función order()
## Ordenamos las observaciones (filas) utilizando la variable (columna) "edad"
datos_pacientes[order(datos_pacientes$edad),]

## Ordenamos las observaciones (filas) utilizando la variable (columna) "peso"
datos_pacientes <- datos_pacientes[order(datos_pacientes$peso),]
View(datos_pacientes)


# 6.4 Exportar DataFrame --------------------------------------------------

# Exportar un DataFrame
## Fijamos carpeta de trabajo
setwd("/Users/maximilianoproanobernal/OneDrive/Documentos/UNAM/Ayudantias/MNPyR/R/Datos/")
getwd()
## Exportar un DataFrame en formato csv
write.csv(x = datos_join,
          file = "datos.csv", 
          row.names = FALSE)

## Exportar un DataFrame en formato Excel
### install.packages("writexl")
library("writexl")
write_xlsx(x = datos_pacientes, 
           path = "datos.xlsx")


# 6.5 Importar DataFrame --------------------------------------------------

# Importar un DataFrame
## Importar un DataFrame en formato csv

datos_csv <- read.csv(file = "datos.csv", 
                      header = TRUE)
View(datos_csv)


# 6.6 Unir dos DataFrames -------------------------------------------------

# Unir dos DataFrames a partir de un ID
## DataFrame "A"
datos_A <- data.frame(ID = seq(1:6),
                      x1 = paste("A", seq(1:6), sep = ""),
                      x2 = paste("a", seq(1:6), sep = ""))
View(datos_A)

## DataFrame "B"
datos_B <- data.frame(ID = seq(1:3),
                      y1 = paste("B", seq(1:3), sep = ""),
                      y2 = paste("B", seq(1:3), sep = ""))
View(datos_B)

## Unir "datos_A" y "datos_B" por medio del ID
### Inner join
datos_C <- merge(datos_A, datos_B, by = "ID")
View(datos_C)

# Unir dos DataFrames a partir de un ID
## Vector con nombres de pacientes y su ID
nombre <- c('Belen', "Daniel", "Ignacio", "Alejandra", "Claudia", "Arturo", "Angelica")
ID <- seq(1:7)

## DataDrame con ID y nombres de los pacientes
nombres <- data.frame(ID, nombre)
View(nombres)

## Unir "datos_pacientes" con "nombres" por medio del ID
datos_join <- merge(datos_pacientes, nombres, by = "ID")
View(datos_join)

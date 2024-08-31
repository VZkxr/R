# Lineas de codigo para limpiar memoria y borrar las variables (cuadrante 2) 
rm(list = ls(all.names = TRUE))
gc()

####################
# Introducción a R #
####################

# 1. Aritmética básica -------------------------------------------------------

## Suma
1+1
1+2+3.5

## Resta
6-9
5-4-2.3

## Multiplicación
5*9
(3+1)*5

## Dividisón
24/6
24/6+1
24/(6+1)

## Exponencial
3^3
2^3+1
2^(3+1)

## Asignación de variables
a <- 4 # Forma 1
b = 6  # Forma 2

## Jerarquía de operaciones 
(a+b)^2+1
(a+b)^(2+1)


# 2. Tipos de datos ----------------------------------------------------------

# Asignamos variables de diferentes tipos
n <- 42
c <- "¡Hola mundo!"
l <- FALSE

## Función class()
class(n)
class(c)
class(l)


# 3. Vectores ----------------------------------------------------------------

## Vector tipo númerico
a <- c(1, 2, 3, -19, 0)

## Vector tipo caracter
b <- c("pera", "manzana", "piña")

## Vector lógico
c <- c(TRUE, FALSE, TRUE, TRUE, FALSE)


# 3.1 Propiedades de los vectores -----------------------------------------

## Homogeneidad
a <- c("lunes", 1, "martes", TRUE, FALSE)
a

## Indexación por posición
b <- c("Prometeo", "Biblioteca", "El pulpo")
b[2]
b[1]

## Indexación por múltiples posiciones
b[c(1,2)]

## Indexación por nombres

### Vector con los gastos de la semana
gastos_semana <-c(100, 200, 50, 100, 400, 300, 300)

### Vector con los días de la semana
dias_semana <-c("Lunes", "martes", "miercoles", "jueves", 
                "viernes", "sabado","domingo")

### Asignamos el vector "dias_semana" a los nombres del vector "gastos_semana"
names(gastos_semana) <- dias_semana

gastos_semana
gastos_semana["sabado"]


# 3.2 Operaciones entre vectores ------------------------------------------

## Multiplicación por escalar
c <- 5
v <- c(1, 2, 3)

c*v

## Suma de vectores
a <- c(5, 10, 15)
b <- c(2, 4, 6)

a+b

## Multiplicación de vectores
a*b

## Producto punto
a%*%b


# 4. Matrices -------------------------------------------------------------

## Matriz tipo númerica
a <- matrix(c(1, 2, 3,
              4, 5, 6), nrow = 2, ncol = 3, byrow = TRUE)
a


## Matriz tipo caracter
b <- matrix(c("pera", "manzana", "piña",
              "sandia", "melón", "uva"), nrow = 2, ncol = 3, byrow = TRUE)
b

## Matriz tipo lógica
c <- matrix(c(TRUE, FALSE, FALSE,
              FALSE, FALSE, TRUE), nrow = 2, ncol = 3, byrow = TRUE)
c

# 4.1 Propiedades de las matrices -----------------------------------------

## Homogeneidad
a <- matrix(c("lunes", 2, 3,
              4, "martes", FALSE), nrow = 2, ncol = 3, byrow = TRUE)
a

## Indexación por posición
b <- matrix(c(1, 2, 3,
              4, 5, 6), nrow = 2, ncol = 3, byrow = TRUE)
b[1,2]
b[1,3]
b[2,1]

## Indexación por múltiples posiciones
b[1,]
b[,2]

## Indexación por nombres

### Vector con los gastos de la semana 1 y 2
gastos_semana_1 <-c(100, 200, 50, 100, 400, 300, 300)
gastos_semana_2 <-c(50, 100, 200, 100, 500, 200, 200)

### Matriz con los gastos de la semana 1 y 2
gastos <- matrix(c(gastos_semana_1,
                   gastos_semana_2), nrow = 2, byrow = TRUE)
gastos

### Vector con los días de la semana
dias_semana <-c("Lunes", "martes", "miercoles", "jueves", "viernes", "sabado",
                "domingo")

### Vector con las semana
semana <-c("Semana 1", "Semana 2")

### Asignamos el vector "dias_semana" a los nombres de las columnas de la matriz "gastos"
colnames(gastos) <- dias_semana

### Asignamos el vector "semana" a los nombres de las filas de la matriz "gastos"
rownames(gastos) <- semana
gastos

gastos["Semana 1", "sabado"]


# 4.2 Operaciones entre matrices ------------------------------------------

## Multiplicación por un escalar
c <- 4
M <- matrix(c(1, 2, 3,
              4, 5, 6,
              7, 8, 9), nrow = 3, ncol = 3, byrow = TRUE)
c*M

## Suma entre matrices
M1 <- matrix(c(1, 1, 1,
               1, 1, 1,
               1, 1, 1), nrow = 3, ncol = 3, byrow = TRUE)

M2 <-matrix(c(1, 1, 1,
              2, 2, 2,
              3, 3, 3), nrow = 3, ncol = 3, byrow = TRUE)
M1+M2

# Multiplicación entre matrices
M1 <- matrix(c(1, 1, 1, 1,
               2, 2, 2, 2,
               3, 3, 3, 3), nrow = 3, ncol = 4, byrow = TRUE)

M2 <-matrix(c(1, 1, 1,
              2, 2, 2,
              3, 3, 3,
              4, 4, 4), nrow = 4, ncol = 3, byrow = TRUE)

M1%*%M2

## Inversa de una matriz
M3 <- matrix(c(2, 1,
               7, 4), nrow = 2, ncol = 2, byrow = TRUE)
solve(M3)

M3Inv <- solve(M3)
M3%*%M3Inv

## Traza de una matriz
M4 <- matrix(c(1, 5, 4,
               9, 2, 8,
               4, 8, 3), nrow = 3, ncol = 3, byrow = TRUE)
diag(M4)
sum(diag(M4))

## Matriz transpuesta 
t(M4)
t(M2)


# 5. DataFrames -----------------------------------------------------------

# Ejemplo de la construcción de un DataFrame
## Vector con la variable "ID del paciente"
ID <- seq(1:4)
ID

## Vector con la variable "Edad
edad <- c(25, 34, 28, 52)

## Vector con la variable "Tipo de diabetes"
diabetes <- c(1, 2, 1, 1)

## Vector con la variable "Estatus"
estatus <- c("Mala", "Regular", "Excelente", "Mala")

## Creamos el DataFrame "datos_pacientes" con la función data.frame()
datos_pacientes <- data.frame(ID, edad, diabetes, estatus)
datos_pacientes


# 5.1 Manipulación --------------------------------------------------------

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
datos_pacientes

# Ejemplo de la función cbind()
## DataFrame "datos_pacientes" original
datos_pacientes

## Creamos el vector "estatura"
estatura <- c(1.75, 1.65, 1.85, 1.69, 1.73)

## Creamos el vector "peso"
peso <- c(75, 70, 81, 70, 75)

## Agregamos las variables "estatura" y "peso" al DataFrame original "datos_pacientes"
datos_pacientes <- cbind(datos_pacientes, estatura, peso)
datos_pacientes

# Definir variables a partir de variables ya existentes
## DataFrame "datos_pacientes" original
datos_pacientes

## Utilizamos el símbolo $ para definir la variable IMC a partir de las 
## variables peso y estatura
datos_pacientes$IMC <- datos_pacientes$peso/(datos_pacientes$estatura)^2

datos_pacientes


# 5.2 Factores ------------------------------------------------------------

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

# 5.3 Filtrar y Ordenar ---------------------------------------------------

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
datos_pacientes[datos_pacientes$edad >= 30, ]

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
datos_pacientes[order(datos_pacientes$peso),]


# 5.4 Exportar DataFrame --------------------------------------------------

# Exportar un DataFrame
## Fijamos carpeta de trabajo
setwd("C:/Users/DanielFrancoZarraga/Documents/Modelos no paramétricos y de regresión")
getwd
## Exportar un DataFrame en formato csv
write.csv(x = datos_pacientes, 
          file = "datos.csv", 
          row.names = FALSE)

## Exportar un DataFrame en formato Excel
### install.packages("writexl")
library("writexl")
write_xlsx(x = datos_pacientes, 
           path = "datos.xlsx")


# 5.5 Importar DataFrame --------------------------------------------------

# Importar un DataFrame
## Importar un DataFrame en formato csv
datos_csv <- read.csv(file = "datos.csv", 
                      header = TRUE)

## Importar un DataFrame en formato Excel
### install.packages("readxl")
library(readxl)
datos_xlsx <- read_excel(path = "datos.xlsx")


# 5.6 Unir dos DataFrames -------------------------------------------------

# Unir dos DataFrames a partir de un ID
## DataFrame "A"
datos_A <- data.frame(ID = seq(1:6),
                      x1 = paste("A", seq(1:6), sep = ""),
                      x2 = paste("a", seq(1:6), sep = ""))
datos_A

## DataFrame "B"
datos_B <- data.frame(ID = seq(1:3),
                      y1 = paste("B", seq(1:3), sep = ""),
                      y2 = paste("B", seq(1:3), sep = ""))
datos_B

## Unir "datos_A" y "datos_B" por medio del ID
### Inner join
new_df <- merge(datos_A, datos_B, by = "ID")
new_df

# Unir dos DataFrames a partir de un ID
## Vector con nombres de pacientes y su ID
nombre <- c("Belen", "Daniel", "Ignacio", "Alejandra", "Claudia", "Arturo", "Angelica")
ID <- seq(1:7)

## DataDrame con ID y nombres de los pacientes
nombres <- data.frame(ID, nombre)
nombres

## Unir "datos_pacientes" con "nombres" por medio del ID
datos_join <- merge(datos_pacientes, nombres, by = "ID")
datos_join

## Environment's clean
rm(list = ls(all.names = TRUE))
gc()

library(readxl)

## Pull data
Data <- read_excel(path = "C:/Users/Aaron/Documents/R/Ejercicios/Concentrado_indicadores_de_pobreza_2020.xlsx",
                    sheet = "Concentrado estatal", #Permite especificar la hoja
                    range = cell_cols(c("B:DD")), #Rango de celdas
                    )


## Select columns
Data <- Data[,c(2, 101, 104)]

## Change columns' names 
colnames(Data) <- c("Entidad", "Porcentaje2020", "Personas2020")

str(Data)

## Drop first 4 columns
Data <- Data[-c(1:4),]

## Convert character to factor and numeric type
Data$Entidad <- factor(Data$Entidad)
Data$Porcentaje2020 <- is.numeric(Data$Porcentaje2020)
Data$Personas2020 <- is.numeric(Data$Personas2020)

##Verify and delete NA
Data[is.na(Data$Porcentaje2020),]
Data <- Data[!is.na(Data$Porcentaje2020),]

str(Data)







## Environment's clean
rm(list = ls(all.names = TRUE))
gc()

library(readxl)

## Pull data
Data <- read_excel(path = "Concentrado_indicadores_de_pobreza_2020.xlsx",
                    sheet = "Concentrado estatal", #Permite especificar la hoja
                    range = cell_cols(c("C:N")), #Rango de celdas
                    col_names = LETTERS[3:14])


## Select columns "C", "E", "K", "N"
Data <- Data[,c("C", "E", "K", "N")]

## Change columns' names 
colnames(Datos) <- c("Entidad", "Municipio", "Porcentaje2020", "Personas2020")

str(Data)

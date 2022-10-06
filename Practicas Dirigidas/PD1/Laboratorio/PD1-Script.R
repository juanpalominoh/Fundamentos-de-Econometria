#-----------------------------------
# Practica Dirigida 1
# Curso: Fundamentos en Econometria
# Jefe de practicas: Tania Paredes

#-------------------------------
# Importamos la base de datos 
#-------------------------------

#Instalar paquete readx1
install.packages("readxl")

#cargar paquete readx1
library(readxl)

datos <- read_excel("G:/Mi unidad/Dictado PUCP/2022-II/FECO - Palomino/PDs/PD1/PD1-FECO-Palomino.xlsx")
View(datos)


#------------------------------------------------------------------
# Estimacion OLS
#------------------------------------------------------------------

"Estimacion OLS"

m1 <- lm(y ~ x,datos)
summary(m1)
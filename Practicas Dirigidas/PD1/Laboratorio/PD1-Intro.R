#-----------------------------------
# Practica Dirigida 1 - Introducción a RStudio
# Curso: Fundamentos en Econometria
# Jefe de practicas: Tania Paredes
#-----------------------------------

grasas <- read.table('http://verso.mat.uam.es/~joser.berrendero/datos/EdadPesoGrasas.txt', header = TRUE)
names(grasas)

regresion <- lm(grasas ~ edad, data = grasas)
summary(regresion)

plot(grasas$edad, grasas$grasas, xlab='Edad', ylab='Grasas')
abline(regresion)
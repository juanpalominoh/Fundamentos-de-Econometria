
library(readxl)
Datos <- read_excel("/Users/juanpalomino/Google Drive/Cursos/Fundamentos de Econometria/Examen Parcial/Pregunta 3/Datos.xlsx")
names(Datos)

# Pregunta 3a ----------
ols <- lm(cp ~ yd + i, data=Datos)
summary(ols)
sigma(ols)^2

# Pregunta 3b ----------
b_hat <- summary(ols)$coefficients[ , 1]  # Extrayendo coeficientes
se    <- summary(ols)$coefficients[ , 2]  # Extrayendo errores estándar
b_hat
se

t <- b_hat[2]/se[2]
t


# Pregunta 3c ----------
ic_low <- b_hat[3]-(2.306*se[3]) 
ic_low
ic_high <- b_hat[3]+(2.306*se[3]) 
ic_high

# Pregunta 3d --------------
summary(ols)$r.squared
summary(ols)$adj.r.squared

# Pregunta 3e --------------
install.packages("car")
library(car)
linearHypothesis(ols, c("yd=0","i=0"))
linearHypothesis(ols, c("yd","i"), c(0,0))



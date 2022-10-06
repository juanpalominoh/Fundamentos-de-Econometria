**************Práctica Dirigida 5****************
********Curso: Fundamentos de Econometría******** 
********Profesor: Juan Palomino *****************
********Jefe de práctica: Tania Paredes**********
*************************************************


*Pregunta 2

*a) Análisis de multicolinealidad

regress SNFAM RNDFAM TDFAM
reg SNFAM RNDFAM TDFAM
r SNFAM RNDFAM TDFAM

*Analizamos los siguientes factores

**R cuadrado = 0.9435 (muy alto)

**Significancia individual

**Coeficiente beta 2: 
	*La renta familiar es significativa al 1% para explicar el ahorro

**Coeficiente beta 3: 
	*Los impuestos no son significativos para explicar el ahorro


*Revisamos la significancia conjunta

* F(2, 32)        =    284.94
*Prob > F        =    0.0000

*Rechazamos la nula, de no significancia conjunta 


**Resulta llamativo que según el R-cuadrado las variables explicativas, 
**explican bastante bien el modelo, así como el F-estadístico, pero cuando
**vemos la significancia individual, solo uno de estos explica el comportamiento
** de la variable dependiente. 

**Analizamos la correlación entre las variables 

correlate 

pwcorr SNFAM RNDFAM TDFAM, sig

*\\ pwcorr: Mostrar matriz de correlación o matriz de covarianza
*\\ sig: muestra la significancia 

**Corr (TDFAN, RNDFAM) = 0.9924
**Corr(RNDFAM, SNFAM)= 0.9728
**Corr (TDFAN, SNFAM)= 0.9630


*Las variables explicativas en mi modelo están fuertemente correlacionadas
*(r=0.992), motivo por el cual me estaría trayendo problemas de
*colinealidad dado que de manera bivariada tanto RNFAM (r=0.9728) o TDFAM (r=0.9630)
*están fuertemente con la dependiente. 


*b) Análisis VIF

vif 

**VIF=>10 --> Problema de multicolinealidad

*Pregunta 4
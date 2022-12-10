
********* Replicamos las tablas logit - probit *********

use "G:\Mi unidad\Dictado PUCP\2022-II\FECO - Palomino\PDs\PD10\Laboratorio\desnutricion.dta", clear


*En principio, nos quedaremos solo con las variables de interés

keep des_cro urbana sexo2 v012 v133 peso_n leng_indi bord wi v136

*Dado que queremos analizar los factores que determinan la anemia, des_cro será nuestra variable dependiente. La analizaremos:

codebook des_cro 

*Obtenemos que esta es una variable binaria, 0 serán los individuos que no tienen anemia y 1 los que si tienen. Ahora procedemos a replicar ambas tablas mostradas en la PD y analizar los aspectos indicados:

*------------------------------------------------------------------------------
*I. Estimación logit 
*------------------------------------------------------------------------------

logit des_cro urbana sexo2 v012 v133 peso_n leng_indi bord wi v136

****Odds Ratio****

*El Odds Ratio o Ratio de ocurrencia del evento, es la razón entre la probabilidad de que ocurra un evento sobre la probabilidad de que no ocurre. Lo que nos indica es la ventaja o preferencia de que ocurra la opción 1 sobre la 0. 


logit des_cro urbana sexo2 v012 v133 peso_n leng_indi bord wi v136, or

*A manera de ejemplo, en el modelo logit estimado, el odds o ratio de ocurrencia de tener desnutrición en una zona urbana es 0.877 mayor respecto a vivir en una zona rural.


****Efectos marginales****

margins, dydx(*)

*Se halla la probabilidad de que haya desnutridos crónicos para cada variable, por lo que se obtiene el cambio marginal en probabilidad. 
*Ejemplo cualitativo: el ser niño (sexo=1) tiene 1% menos probabilidad de estar desnutrido que una niña (sexo=0) [el efecto marginal es el cambio de una categoría a otra]
*Ejemplo cuantitativo: si se pesa un kilo más, se reduce la probabilidad de tener desnutrición en 8%. [el efecto marginal tal como lo conocemos con la derivdada parcial]


*Podemos también graficar los efectos marginales****

marginsplot

*En el gráfico se observa el efecto marginal (en los puntos) y el intervalo de confianza en las líneas verticales al 5%.

****Correcta clasificación en cada categoría****

estat classification 

*Un aspecto final que se puede ver en los modelos de regresión logit o probit es la correcta clasificación de los individuos a cada una de las categorías u opciones de la variable dependiente.

*Lo que evidencia esta tabla es el poder de predicción del modelo, por ejemplo, cuantos de los individuos que tenían desnutrición efectivamente fueron clasificados como desnutridos y también cuantos de los no desnutridos fueron clasificados como no desnutridos.
*En la tabla, se observa que para los no desnutridos, 6373 fueron correctamente asignados, pero ello no ocurre para los nutridos, dado que 680 personas que estaban desnutridas fueron clasificadas como no desnutridas. 
*En este caso, se puede apreciar que el 90% de los individuos en el modelo estimado ha sido correctamente clasificado a la opción 0 y 1. Esto indica que se cuenta con un modelo adecuado
*De esto podemos concluir que, la especificidad será alta, dado que tenemos varios 0 correctamente clasificados y baja sensibilidad porque tiene pocos 1 correctamente clasificados. 


*------------------------------------------------------------------------------
*II. Estimación probit
*------------------------------------------------------------------------------
probit des_cro urbana sexo2 v012 v133 peso_n leng_indi bord wi v136

****Odds Ratio****

probit des_cro urbana sexo2 v012 v133 peso_n leng_indi bord wi v136, or

****Efectos marginales****

margins, dydx(*)

****Correcta clasificación en cada categoría****

estat clasification 

*----------------------------------------------------------------------------
*------------------------------------------------------------------------------
*III. Comparamos los dos modelos
*------------------------------------------------------------------------------

logit des_cro urbana sexo2 v012 v133 peso_n leng_indi bord wi v136

estimates store Modelo1

probit des_cro urbana sexo2 v012 v133 peso_n leng_indi bord wi v136

estimates store Modelo2

estimate table Modelo1 Modelo2, stats(N) star

*Como mencionamos en la parte de la PD, comparamos los coeficientes solo comparando los signos de los coeficientes y si son estadisticamente significativos. En esta tabla observamos que obtenemos para el modelo logit y probit los mismos signos para las variables y la misma significancia. Por ello se justifica que ambos modelos generan resultados iguales. 


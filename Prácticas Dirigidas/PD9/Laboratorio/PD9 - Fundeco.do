***** Fundamentos de Econometría (PUCP) **********
************ JPs: Tania Paredes*************** 

use casa_propia.dta, clear 

********* a. Estime un MPL e interprete los coeficientes

rename y propiedad_vivienda
rename x ingresos

reg propiedad_vivienda ingresos	

/* El intercepto es -0.9457, el cual es la probabilidad de que una familia sin 
ingresos tenga una casa propia. Si bien este valor es negativo, podemos asumir
que puede ser cero, lado que una familia sin ingresos no podrá adquirir una casa.
Ello va revelando algunas debilidades de este modelo.

El valor de la pendiente es 0.102, lo cual significa que si el ingreso familiar 
incrementa en mil dólares, en promedio, la probabilidad de tener casa propia 
aumenta en 0.1021 (10%).

Entonces para un nivel de ingreso dado podemos determinar la probabilidad de 
tener casa propia. Así, para X=12 (ingreso familiar de 12 mil dólares), la 
probabilidad estimada de tener casa propia es 27.95% (-0.9457+12(0.1021))
*/
display=-0.9457+12*0.1021

********* b. Obtenga las probabilidades condicionales de contar con una vivienda y analice sus resultados. 

reg propiedad_vivienda ingresos	
predict propiedad_vivienda_estimada
list propiedad_vivienda_estimada

/*Encontramos muchas probabilidades negativas*/

********* c. Estime el modelo utilizando el método de Mínimos Cuadrados Ponderados

gen varianza=propiedad_vivienda_estimada*(1-propiedad_vivienda_estimada)
replace varianza=. if varianza<0
gen desv_estandar=varianza^0.5
//Generando los ponderadores 
gen y=propiedad_vivienda/desv_estandar
gen x=ingresos/desv_estandar
gen constante=1/desv_estandar
//Creando las nuevas variables, se dividen los ponderadores
reg y x constante, noconstant

********* d. Compare las desviaciones estándar de ambas estimaciones y comente

reg propiedad_vivienda ingresos	

/*Observamos estimadores más eficientes por la menor varianza y el mayor 
t-estadístico. Asimismo, hemos perdido 12 observaciones al ser la probabilidad 
negativa*/

reg y x constante, noconstant
predict y_estimada
list y_estimada

/*Finalmente, seguimos encontrando probabilidades estimadas menores a cero
y mayores a uno*/

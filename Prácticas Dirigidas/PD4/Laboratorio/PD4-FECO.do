*########### PD4. Laboratorio de Stata ########### 
***************** FECO (PUCP) *******************
**************** JPs: Tania Paredes*************** 

********* a
clear all
use "G:\Mi unidad\Dictado PUCP\2022-II\FECO - Palomino\PDs\PD4\LAB\datos.dta", clear
codebook
summarize

regress income educ jobexp race

********* b
/* Si dividimos los coeficientes entre la desviación estandar, obtenemos los 
estadísticos t pues la hipótesis nula es cero */

********* c
/*Hallamos el valor crítico. Tanto en Stata como en la mayoría de literatura 
econométrica, se suele trabajar con un nivel de significancia de 5%
t_(1-0.05/2)(N-k)=2.12.
	-En función al test t:
	Comparamos el estadístico t con los valores críticos, y observamos en qué 
	parámetros se rechaza la Ho.
	-En función del p-value:
	Stata por defecto calcula el p-value. En función de PD4 1d definimos la 
	significancia
	- En función del IC
	Vemos que el IC no considera en algunos casos cero; por lo tanto, se rechaza 
	la Ho*/

********* d
/*
H0: B2=0, B3=0, B4=0
H1: Bj!=0

Matricialmente
H0:
 0 1 0 0		B1	 		0	
[0 0 1 0]	[	B2  ] = [	0	]
 0 0 0 1		B3			0	
				B4			

Donde en esta matríz k=4 y q=3
				
Por defecto Stata calcula el test F. El estadístico F es 29.16 y el valor
crítico es F(q,N-k)=F(3,16). El p-value (Prob > F) es 0.0000, lo cual implica que se 
rechaza la H0 donde los 3 parámetros son iguales a cero.
*/
test educ jobexp race //obtenemos exactamente los mismos resultados



**********************Práctica Dirigida 2***********************
*****************************************************************
/*
Pontificia Universidad Catolica del Peru
Curso: Fundamentos de Econometria
Fecha: 3 de septiembre del 2022
Profesor: Juan Palomino
Jefe de Practica: Tania Paredes
*/

*--------------------------------------------------------------------------

clear

import excel "G:\Mi unidad\Dictado PUCP\2022-II\FECO- Palomino\PDs\PD2\Laboratorio\Ejercicio 3 - PD2.xlsx", sheet("Hoja1") firstrow


rename Salariosolesporhora salario

rename Educaciónañosdeestudio educ

** a
reg salario educ

** b

*El comando mat extrae y guarda los coeficientes de la matriz e(b) (de la regresión) como b

mat betha=e(b)

*El comando svmat guarda los coeficientes betas de la regresión como variables

svmat double betha, names(matcol)

*Generamos el salario estimado con la información de los coeficientes betas

generate salario_est=betha_cons[1]+bethaeduc[1]*educ

*Hallamos el error que es el valor poblacional de los salarios restado del valor estimado de los salarios
gen e=salario-salario_est

*Hallamos el error al cuadrado
g e2=e^2

** c
*Graficamos 
graph twoway (scatter salario educ) (lfit salario educ)

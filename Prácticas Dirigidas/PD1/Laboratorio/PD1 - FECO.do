**********************Práctica Dirigida 1***********************
*****************************************************************
/*
Pontificia Universidad Catolica del Peru
Curso: Fundamentos de Econometria
Fecha: 27 de agosto del 2022
Profesor: Juan Palomino
Jefe de Practica: Tania Paredes
*/

*--------------------------------------------------------------------------

*Correr el código usamos control+D

*Sesión 1: Introducción a STATA

* Limpiar la memoria del programa
clear all

*Definimos la carpeta que usaremos
cd "G:\Mi unidad\Dictado PUCP\2022-II\FECO - Palomino\PDs\PD1"


*1)Abriendo la base de datos

*Importar excel
*use "import excel "G:\Mi unidad\Dictado PUCP\2022-II\FECO - Palomino\PDs\PD1\PD1-FECO-Palomino.xlsx", sheet ("PD1") firstrow", clear 

*Abrir dta
use PD1-FECO-Palomino.dta, clear

*2)Comando de ayuda
help 
h

*3)Exploración la base de datos
*Para ver la base de datos
browse 
br

*Comando para la descripción de las variables 
describe 
describe y x 

*Comando para la descipción más detallada de las variables 
codebook y

*Comando para el análisis de información
summarize 
sum 
sum y x 


*Comando para análisis de información de una variable
tabulate x
tab y

*-------------------------------------------------------------

*Estimación de modelo bivariado

reg y x

*SS:Suma de cuadrados del modelo = Suma de cuadrados totales - suma de cuadrados residuales 
 

*Hallar valores predichos --> y gorro/ y estimado con valores de beta1 y beta2

predict y_hat, xb





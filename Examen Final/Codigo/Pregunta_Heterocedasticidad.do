

* Pregunta Heterocedasticidad
*=============================


global dta "/Users/juanpalomino/Google Drive/Cursos/Fundamentos de Econometria/Examen Final/Data"
use "$dta/base_anemia.dta", clear

global y "hemoglobina"
global x "sexo pesoalnacer edadmeses i.educmadre area"


* Test White
*------------
reg $y $x
whitetst
imtest, white		 

* Con un nivel de significancia del 1%, se rechaza la H0 de homocedasticidad


* Test de Breusch-Pagan
*------------------------
reg $y $x
estat hettest, rhs

* Con un nivel de significancia del 1%, se rechaza la H0 de homocedasticidad 

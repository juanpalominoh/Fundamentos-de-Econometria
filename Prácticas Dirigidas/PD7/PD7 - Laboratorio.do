
******************************************************************
********************Práctica Dirigida 7 **************************
****************Fundamentos de Econometría***********************
************Jefe de Práctica : Tania Paredes*********************
******************************************************************

*Declaramos la ruta donde está la base de datos
cd "G:\Mi unidad\Dictado PUCP\2022-II\FECO - Palomino\PDs\PD7"

*1.Importamos la base de datos
import excel "G:\Mi unidad\Dictado PUCP\2022-II\FECO - Palomino\PDs\PD7\acemoglu_datos_64.xlsx", sheet("datos") firstrow


*2.Estimador de MCO + errores estándar robustos

reg logpgp95 avexpr, vce(robust)


*3. Estimamos por MC2E (2SLS/TSLS) + errores estándar robustos

ivregress 2sls logpgp95 (avexpr=logem4), vce(robust)


*4. Calcule el efecto marginal de Xi sobre Yi usando los estimados IV. ¿Por qué es diferente al efecto marginal obtenido con los estimados OLS?

*Para OLS

reg logpgp95 avexpr, vce(robust)
mfx

*Parámetro estimado = 0.522107
*Calculamos (e^(0.522107)-1)*100
*Obtenemos:68.38%


*Para 2SLS/TSLS

ivregress 2sls logpgp95 (avexpr=logem4), vce(robust)
mfx

*Parámetro estimado = 0.9442794
*Calculamos (e^(0.94427947)-1)*100
*Obtenemos: 157.1%

*5. Evalue la relevancia del instrumento. ¿Se puede decir que el instrumento es débil?

*Se usa Test de Stock, Wright y Yogo (2002)
*Se debe rechazar la H0 : θ2 = 0
*Si la correlación entre Zi y Xi es débil (a pesar de rechazar la H0, los instrumentos son débiles.
*Si se rechaza H0 : θ2 = 0 con F > 10, el instrumento no es débil

estat firststage

*Se rechaza la Hipótesis Nula con un F igual a 16.32, por lo que en este caso no nos encontramos ante un instrumento débil al 1% de significancia.


*6. Evalée la exogeneidad del regresor Xi
*Se usa el test de Hausman
*En este caso lo que se evalúa es la H0: de que ambos betas son iguales (\beta_OLS=\beta_TSLS)
*Si se rechaza H0, quiere decir que en el modelo se tiene un regreso endógeno y que es válido usar MC2E o TSLS

estat endog

*Se encuentra que rechaza la H0 al 1% de significancia

*7. Incluya en el modelo 1 la variable “lat abst”, “asia”, “africa” y “malfal94”; además, utilice como instrumento adicional “euro1900”. Analice la validez de los instrumentos. ¿Cómo cambia el efecto marginal de las instituciones?

ivregress 2sls logpgp95 lat_abst asia africa malfal94 (avexpr=logem4 euro1900)

**7.1)Analizamos la validez de los instrumentos


*Relevancia (Stock, Wright y Yog) --> Se rechaza H0, no es un instrumento débil 
estat firststage

*Exogeneidad (Hausman) --> Se rechaza H0, por lo que se encuentra que el modelo si tiene un regresor endógeno y es necesario usar MC2E o TSLS
estat endog 

*Validez de los instrumentos (por medio de la identificación)
*Lo que se plantea testear aquí es 

*H0: Instrumentos válidos
*H1: Instrumentos no válidos


**7.2) Vemos como cambia el efecto marginal y vemos que cambia el efecto de las instituciones (el efecto se incrementa)
*Parámetro estimado = 0.5479184
*Calculamos (e^(0.5479184)-1)*100
*Obtenemos: 73%

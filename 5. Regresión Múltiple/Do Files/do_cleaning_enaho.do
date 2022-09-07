
global enaho  	"/Users/juanpalomino/Google Drive/ENAHO"
global dta_3 	"$enaho/Modulo 300"
global dta_5 	"$enaho/Modulo 500"
global works 	"/Users/juanpalomino/Google Drive/Cursos/Fundamentos de Econometria/6. Regresión Múltiple Parte II/Procesadas"


*============================================
* Limpieza de Datos - ENAHO MODULO EDUCACIÓN
*============================================

use "$dta_3/enaho01a-2021-300.dta", clear

* Años de educacion
generate byte sch=p301b
replace sch=0 if p301a==1 | p301a==2
recode  sch (1=1) (2=2) (3=3) (4=4)               if p301a==3
recode  sch (5=5) (6=6)                           if p301a==4
recode  sch (1=7) (2=8) (3=9) (4=10)              if p301a==5
recode  sch (5=11)(6=12)                          if p301a==6
recode  sch (1=12)(2=13)(3=14)(4=15)              if p301a==7
recode  sch (3=14)(4=15)(5=16)                    if p301a==8
recode  sch (1=12)(2=13)(3=14)(4=15)(5=16) (6=17) if p301a==9
recode  sch (4=15)(5=16)(6=17)(7=18)              if p301a==10
recode  sch (1=17)(2=18)                          if p301a==11
g      _p301c=p301c
recode _p301c (0=1)
replace sch=_p301c if p301b==0 & p301a!=2
label value sch sch
label variable sch "Años de escolaridad" 

keep conglome vivienda hogar codperso sch

save "$works/enaho_escolaridad.dta", replace



*==========================================
* Limpieza de Datos - ENAHO MODULO LABORAL
*==========================================

use "$dta_5/enaho01a-2021-500.dta", clear

*========================
* Variables Individuales
*========================

* Edad
rename p208a edad
label var edad "Edad (años)"


* Sexo
recode p207 (2=1 "Mujer") (1=0 "Hombre"), gen(mujer)
label var mujer "Mujer"
	
	
* Estado Civil
recode p209 (1/2=1 "Casado/Conviviente") (3=2 "Viudo") (4/5=3 "Divorciado/Separado") (6=4 "Soltero"), gen(civil)
label var civil "Estado Civil"


* Nivel educativo
recode p301a (1/2=1 "Sin Nivel/Inicial") (3/4=2 "Primaria") (5/6 12=3 "Secundaria") (7/8=4 "Superior no universitaria") (9/10=5 "Superior universitaria") (11=6 "Maestria/Doctorado"), gen(educ)
label var educ "Nivel Educación"


* Raza
recode p558c (1/4 6 9=1 "Indigena") (5 7/8=0 "Otro"), gen(indigena)
label var indigena "Indígena"


* Jefe de hogar
recode p203 (1=1 "Jefe") (0 2/11=0 "Otro"), gen(jefe)
label var jefe "Jefe de Hogar"


* Residentes Habituales
gen residente=((p204==1 & p205==2) | (p204==2 & p206==1))
label var residente "Residente Habitual"


*=====================
* Variables Laborales
*=====================

* Pea
recode ocu500 (1/2=1 "PEA") (3/4=0 "NO PEA") (0=.), gen(pea)
label var pea "PEA"


* Pea Ocupada
label list ocu500
recode ocu500 (1=1 "Pea Ocupada") (2/4=0 "Otro"), gen(peao)
label var ocu500 "PEA ocupada"


* Actividades Sectoriales
recode p506r4 ///
	(0111/0322= 1 "Agricultura, ganadería, silvicultura y pesca") ///
	(0510/0990= 2 "Explotación de minas y canteras") ///
	(1010/3320= 3 "Industrias manufactureras") ///
	(3510/3530= 4 "Suministro de electricidad, gas, vapor y aire acondicionado") ///
	(3600/3900= 5 "Suministro de agua; evacuación de aguas residuales, gestión de desechos y descontaminación") ///
	(4100/4390= 6 "Construcción") ///
	(4510/4799= 7 "Comercio al por mayor y al por menor; reparación de vehículos automotores y motocicletas") ///
	(4911/5320= 8 "Transporte y almacenamiento") ///
	(5510/5630= 9 "Actividades de alojamiento y de servicio de comidas") ///
	(5811/6399= 10 "Información y comunicaciones") ///
	(6411/6630= 11 "Actividades financieras y de seguros") ///
	(6810/6820= 12 "Actividades inmobiliarias") ///
	(6910/7500= 13 "Actividades profesionales, científicas y técnicas") ///
	(7710/8299= 14 "Actividades de servicios administrativos y de apoyo") ///
	(8411/8430= 15 "Administración pública y defensa; planes de seguridad social de afiliación obligatoria") ///
	(8510/8550= 16 "Enseñanza") ///
	(8610/8890= 17 "Actividades de atención de la salud humana y de asistencia social") ///
	(9000/9329= 18 "Actividades artísticas, de entretenimiento y recreativas") ///
	(9411/9609= 19 "Otras actividades de servicios") ///
	(9700/9820= 20 "Actividades de los hogares como empleadores; actividades no diferenciadas de los hogares como productores de bienes y servicios para uso propio") ///
	(9900= 21 "Actividades de organizaciones y órganos extraterritoriales"), gen(act_sec)
label var act_sec "Actividades Sectoriales"

 
* Por sectores primarios, secundarios y terciarios
recode act_sec (1/2=1 "Sector Primario") (3/6=2 "Sector Secundario") (7/21=3 "Sector Terciario"), gen(sector)
label variable sector "Sector"


* Grupo Ocupacional
* https://www.inei.gob.pe/media/Clasificador_Nacional_de_Ocupaciones_9_de_febrero.pdf
gen ciuo=int(p505r4)
recode ciuo (1111/1499=1 "Miembros del Poder Ejecutivo, Legislativo, Judicial y personal directivo de la administración pública y privada") ///
			(2111/2656=2 "Profesionales científicos e intelectuales") ///
			(3111/3523=3 "Profesionales técnicos") ///
			(4110/4419=4 "Jefes y empleados administrativos") ///
			(5111/5419=5 "Trabajadores de los servicios y vendedores de comercios y mercados") ///
			(6111/6340=6 "Agricultores y trabajadores calificados agropecuarios, forestales y pesqueros") ///
			(7111/7519=7 "Trabajadores de la construcción, edificación, productos artesanales, electricidad y las telecomunicaciones") ///
			(8111/8352=8 "Operadores de maquinaria industrial, ensambladores y conductores de transporte") ///
			(9111/9629=9 "Ocupaciones elementales") ///
			(111/131 211/231 311/331=0 "Ocupaciones militares y policiales"), gen(gruocu)
label variable gruocu "Grupo Ocupacional"


* Habilidad Ocupacional
* https://www.ilo.org/ilostat-files/Documents/description_OCU_EN.pdf
recode gruocu (1/3=1 "High Skill Occupation") (4/8=2 "Medium Skill Occupation") (9=3 "Low Skill Occupation") (0=0 "Ocupaciones Fuerzas Armadas"), gen(skill_ocu)
label variable skill_ocu "Skill Occupation"


* Ingreso Mensual
egen ing_ocu_pri=rowtotal(i524a1 d529t i530a d536)						
egen ing_ocu_sec=rowtotal(i538a1 d540t i541a d543)						
rename d544t ing_extra
egen ing_total = rowtotal(ing_ocu_pri ing_ocu_sec ing_extra) 
gen ingreso=ing_total/12
label var ingreso "Ingreso Total Mensual"


* Logaritmo Ingreso Mensual
gen lnwage=ln(ingreso)
label var lnwage "Logaritmo Ingreso Mensual"


* Sistema de Pensiones
recode p558a5 (5=0 "No afiliado") (0=1 "Afiliado"), gen(sis_pension)
label var sis_pension "Afiliado a un Sistema de Pensiones"


* Empleo informal:
recode ocupinf (1=1 "Informal") (2=0 "Formal"), gen(informal)
label var informal "Empleo Informal"


* Tamaño de Empresa
gen lntamaño=ln(p512b)
label var lntamaño "Tamaño Empresa"


* Permanencia en el trabajo
rename p513a1 tenure
label var tenure "Permanencia en el trabajo"


*=======================
* Variables Geográficas
*=======================

* Pais
gen pais="Perú"
label var pais "País"


* Departamento
gen dpto=substr(ubigeo,1,2)
destring dpto, replace
label var dpto "Departamento"
label define lab_dpto 1 "Amazonas" 2 "Ancash" 3 "Apurímac" 4 "Arequipa" ///
		5 "Ayacucho" 6 "Cajamarca" 7 "Callao" 8 "Cusco" 9 "Huancavelica" 10 "Huánuco" ///
		11 "Ica" 12 "Junín" 13 "La Libertad" 14 "Lambayeque" 15 "Lima" 	16 "Loreto" ///
		17 "Madre de Dios" 18 "Moquegua" 19 "Pasco" 20 "Piura" 21 "Puno" 22 "San Martín" ///
		23 "Tacna" 24 "Tumbes" 25 "Ucayali"
label values dpto lab_dpto


* Area
recode estrato (1/5=1 "Urbano") (6/8=0 "Rural"), gen(urban) 
label var urban "Área Geográfica"


* Zona
recode dominio (1/3=1 "Costa") (4/6=2 "Sierra") (7=3 "Selva") (8=4 "Lima Metropolitana"), gen(zona)
label var zona "Zona Geográfica"


keep aÑo mes conglome-codperso pais dpto urban zona edad mujer civil educ indigena jefe residente pea peao act_sec sector gruocu skill_ocu ingreso lnwage sis_pension informal lntamaño tenure fac500a

order pais aÑo mes dpto zona urban conglome-codperso mujer edad civil educ jefe residente indigena
order fac500a, last 

save "$works/enaho_laboral.dta", replace



use "$works/enaho_laboral.dta", clear
merge 1:1 conglome vivienda hogar codperso using "$works/enaho_escolaridad.dta", keep(3) nogen

* Experiencia potencial
gen exper=edad-sch-6
label var exper "Experiencia potencial"

destring aÑo mes conglome, replace

save "$works/enaho_cleaning_2021.dta", replace


use "$works/enaho_cleaning_2021.dta", clear

* Filtros
*---------

* Solo miembros del hogar (Establecer a los residentes habituales)
keep if residente==1

* Se va ocupaciones de fuerzas armadas
drop if skill_ocu==0 

* Edad 
keep if edad>=14 & edad<=65

* Pea ocupada
keep if peao==1



* Regresión
*------------
reg lnwage sch
reg lnwage sch mujer

* Paso 1: estimar todo el modelo completo
reg lnwage sch mujer mes conglome


* Paso 2: Hallar el predicho
predict double yhat2 if e(sample), xb
predict double uhat if e(sample), residuals

* Paso 3: Borrar los missing del predicho (no es lo mismo que borrar missing de
* la dependiente e independientes)
drop if yhat2==.
drop yhat2 uhat

save "$works/enaho_2021.dta", replace


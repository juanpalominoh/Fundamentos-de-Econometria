
clear all
set more off
global main			"/Users/juanpalomino/Google Drive/Cursos/Fundamentos de Econometria/7. Multicolinealidad"
global dta			"$main/Data"
global works		"$main/Trabajadas"

*=========
* REC84DV
*=========

import spss "$dta/REC84DV_2019.SAV", case(lower) clear  // 33,310

* case id
split caseid
order caseid caseid1 caseid2, a(id1)
drop caseid
rename (caseid1 caseid2) (hhid hvidx)
destring hvidx, replace
duplicates list hhid hvidx

* Año
rename id1 año

label list labels0 labels1 labels2 labels3 labels4 labels5
label def ipv_yesno_dontknow 0 "No" 1 "Sí" 8 "No sabe"
foreach y in d101 {
	foreach z in a b c d e f  {
			label value `y'`z' ipv_yesno
	}
}

label list labels10 labels11 labels12 labels13
label def ipv_yesno 0 "No" 1 "Frecuentemente" 2 "Algunas veces" 3 "Nunca"
foreach y in d103 {
	foreach z in a b d  {
			label value `y'`z' ipv_yesno
	}
}

label list labels17 labels18 labels19 labels20 labels21 labels22 labels23 labels24 labels25 labels26
foreach y in d105 {
	foreach z in a b c d e f g h i j k {
			label value `y'`z' ipv_yesno
	}
}  
  
keep hhid hvidx año d101a-d101f d103a d103b d103d d105a-d105k
order año hhid hvidx

save "$works/modulosrec84dv_2019.dta", replace // 33,310


*==========
* RE516171
*==========

import spss "$dta/RE516171_2019.SAV", case(lower) clear  // 33,311

* case id
split caseid
order caseid caseid1 caseid2, a(id1)
drop caseid
rename (caseid1 caseid2) (hhid hvidx)
destring hvidx, replace
duplicates list hhid hvidx

* Año
rename id1 año

keep hhid hvidx año v502 

label copy labels1  lab_casada
label values v502 lab_casada

save "$works/modulosrec516171_2019.dta", replace  // 33,311



*=========
* REC0111
*=========

import spss "$dta/REC0111_2019.SAV", case(lower) clear // 38,335

* case id
split caseid
order hhid caseid caseid1 caseid2, a(id1)
drop hhid caseid
rename (caseid1 caseid2) (hhid hvidx)
destring hvidx, replace
duplicates list hhid hvidx

* Año
rename id1 año

* Encuestas completas
keep if v015==1   // 36,922

* Factor de peso:
format v005 %16.0f
gen peso2=v005/1000000 

* Lugar de residencia
recode v025 (1=1 "Urbano") (2=0 "Rural"), gen (area)

keep año hhid hvidx v012 v044 v101 v133 v135 area peso2

order peso2, last

label copy labels13 lab_modviol
label copy labels15 lab_dpto
label copy labels38 lab_residente
label values v044 lab_modviol
label values v101 lab_dpto
label values v135 lab_residente

label drop labels36

save "$works/modulosrec111_2019.dta", replace  // 36,922


*==========
* RE223132
*==========

import spss "$dta/RE223132_2019.SAV", case(lower) clear  // 36,922

* case id
split caseid
order caseid caseid1 caseid2, a(id1)
drop caseid
rename (caseid1 caseid2) (hhid hvidx)
destring hvidx, replace
duplicates list hhid hvidx

* Año
rename id1 año

* Etiqueta embarazada
label copy labels0 lab_act_emb 
label val v213 lab_act_emb 

keep hhid hvidx año v213 
order año hhid hvidx

save "$works/modulosrec223132_2019.dta", replace // 36,922


*==========
* REC41
*==========

import spss "$dta/REC41.sav", case(lower) clear // 21,154

split caseid
order caseid caseid1 caseid2, a(id1)
drop caseid
rename (caseid1 caseid2) (hhid hvidx)
destring hvidx, replace
duplicates list hhid hvidx

* Año
rename id1 año


keep hhid hvidx midx m19
rename midx hwidx

* Peso al nacer
sum
label list labels47
gen pesoalnacer=m19
replace pesoalnacer=. if pesoalnacer==9996 | pesoalnacer==9998
replace pesoalnacer=pesoalnacer/1000
drop m19 

sum

save "$works/modulosrec41_2019.dta", replace   // 21,154



use "$works/modulosrec111_2019.dta", clear
merge 1:1 hhid hvidx using "$works/modulosrec223132_2019.dta", nogen 
merge 1:1 hhid hvidx using "$works/modulosrec516171_2019.dta", nogen
merge 1:1 hhid hvidx using "$works/modulosrec84dv_2019.dta", nogen
merge 1:m hhid hvidx using "$works/modulosrec41_2019.dta"
sort hhid hvidx v012

* VIOLENCIA FISICA EJERCIDA POR EL ESPOSO O COMPAÑERO
*=====================================================

* Empujo, sacudio o tiro algo
gen       dv_prtnr_push = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_push = 1 if d105a>0 & d105a<=3
label val dv_prtnr_push yesno
label var dv_prtnr_push		"Empujo, sacudio o tiro algo"
	
* Abofeteo
gen       dv_prtnr_slap = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_slap = 1 if d105b>0 & d105b<=3
label val dv_prtnr_slap yesno
label var dv_prtnr_slap		"Abofeteo"

* Golpeo con el puño o algo que pudo dahnarla
gen       dv_prtnr_punch = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_punch = 1 if d105c>0 & d105c<=3
label val dv_prtnr_punch yesno
label var dv_prtnr_punch	"Golpeo con el puhno o algo que pudo dahnarla"

* Pateo o arrastro
gen       dv_prtnr_kick = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_kick = 1 if d105d>0 & d105d<=3
label val dv_prtnr_kick yesno
label var dv_prtnr_kick		"Pateo o arrastro"
		
* Trato de estrangularla o quemarla 
gen       dv_prtnr_choke = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_choke = 1 if d105e>0 & d105e<=3
label val dv_prtnr_choke yesno
label var dv_prtnr_choke	"Trato de estrangularla o quemarla"

* Amenazo con cuchillo, pistola u otra arma
gen       dv_prtnr_weapon1 = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_weapon1 = 1 if d105f>0 & d105f<=3
label val dv_prtnr_weapon1 yesno
label var dv_prtnr_weapon1	"Amenazo con cuchillo, pistola u otra arma"

* Ataco, agredio con cuchillo, pistola u otra arma
gen       dv_prtnr_weapon2 = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_weapon2 = 1 if d105g>0 & d105g<=3
label val dv_prtnr_weapon2 yesno
label var dv_prtnr_weapon2	"Ataco, agredio con cuchillo, pistola u otra arma"

* Retorcio el brazo
gen       dv_prtnr_twist = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_twist = 1 if d105j>0 & d105j<=3
label val dv_prtnr_twist yesno
label var dv_prtnr_twist	"Retorcio el brazo"

* Total
gen dv_prtnr_phy = 0 if v044==1 & (v502>0 & v502<5)
foreach x in a b c d e f g j {
	replace dv_prtnr_phy = 1 if d105`x'>0 & d105`x'<=3	
}
label val dv_prtnr_phy yesno
label var dv_prtnr_phy	"Violencia Fisica"
tab dv_prtnr_phy
tab dv_prtnr_phy [iweight=peso2]


* VIOLENCIA SEXUAL EJERCIDA POR EL ESPOSO O COMPAÑERO
*=====================================================

* Esposo alguna vez la forzo a tener relaciones sexuales aunque no queria
gen       dv_prtnr_force = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_force = 1 if d105h>0 & d105h<=3
label val dv_prtnr_force yesno
label var dv_prtnr_force	"forzo a tener relaciones sexuales aunque no queria"
		
* Esposo alguna vez la obligo a realizar otros actos sexuales cuando no queria
gen       dv_prtnr_force_act = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_force_act = 1 if d105i>0 & d105i<=3
label val dv_prtnr_force_act yesno
label var dv_prtnr_force_act "obligo a realizar otros actos sexuales cuando no queria"

	
* Total
gen dv_prtnr_sex = 0 if v044==1 & (v502>0 & v502<5)
foreach x in h i k {
	replace dv_prtnr_sex = 1 if d105`x'>0  & d105`x'<=3
}
label val dv_prtnr_sex yesno
label var dv_prtnr_sex	"Violencia Sexual"
tab dv_prtnr_sex
tab dv_prtnr_sex [iweight=peso2]


* VIOLENCIA PSICOLOGICA Y/O VERBAL EJERCIDA POR EL ESPOSO O COMPAÑERO
*====================================================================

* Situaciones humillantes
gen       dv_prtnr_humil = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_humil = 1 if d103a>0 & d103a<=3
label val dv_prtnr_humil yesno
label var dv_prtnr_humil "Situaciones humillantes"

* Situaciones de control
// Es celoso o molesto
gen       dv_prtnr_jeals = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_jeals = 1 if d101a==1
label val dv_prtnr_jeals yesno
label var dv_prtnr_jeals "Es celoso o molesto"

// Acusa de ser infiel
gen       dv_prtnr_accus = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_accus = 1 if d101b==1
label val dv_prtnr_accus yesno
label var dv_prtnr_accus "Acusa de ser infiel"

// Impide que visite o la visiten sus amistades/familiares
gen       dv_prtnr_friends = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_friends = 1 if d101c==1
replace   dv_prtnr_friends = 1 if d101d==1
label val dv_prtnr_friends yesno
label var dv_prtnr_friends	"Impide que visite o la visiten sus amistades/familiares"

// Insiste en saber donde va
gen       dv_prtnr_where = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_where = 1 if d101e==1
label val dv_prtnr_where yesno
label var dv_prtnr_where "Insiste en saber donde va"

// Desconfia con el dinero
gen       dv_prtnr_money = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_money = 1 if d101f==1
label val dv_prtnr_money yesno
label var dv_prtnr_money "Desconfia con el dinero"

// Algún control
egen         dv_prtnr_cntrl = rowtotal(dv_prtnr_jeals dv_prtnr_accus dv_prtnr_where dv_prtnr_money dv_prtnr_friends) if v044==1 & v502>0
recode       dv_prtnr_cntrl  (1/6=1)
label val    dv_prtnr_cntrl  yesno 
label var    dv_prtnr_cntrl "Algun control"


* Amenazas
// Amenaza con hacerle dahno
gen       dv_prtnr_ame1 = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_ame1 = 1 if d103b>0 & d103b<=3
label val dv_prtnr_ame1 yesno
label var dv_prtnr_ame1	"Amenaza con hacerle dahno"

// Amenaza con irse de casa, quitarle hijos, detener ayuda economica 
gen       dv_prtnr_ame2 = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_ame2 = 1 if d103d>0 & d103d<=3
label val dv_prtnr_ame2 yesno
label var dv_prtnr_ame2	"Amenaza con irse de casa, quitarle hijos, detener ayuda economica"


* Total Violencia psico-logica y/o verbal
gen       dv_prtnr_psi = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_psi =1 if dv_prtnr_humil == 1 | dv_prtnr_cntrl == 1 | dv_prtnr_ame1 ==1 |  dv_prtnr_ame2 == 1
label val dv_prtnr_psi yesno
label var dv_prtnr_psi "Violencia psicologica"
tab  dv_prtnr_psi
tab  dv_prtnr_psi [iweight=peso2]


* VIOLENCIA TOTAL (FISICA, SEXUAL & PSICOLOGICA)
*=================================================

gen       dv_prtnr_vt = 0 if v044==1 & (v502>0 & v502<5)
replace   dv_prtnr_vt = 1 if dv_prtnr_phy==1 | dv_prtnr_sex==1 | dv_prtnr_psi ==1
label val dv_prtnr_vt yesno
label var dv_prtnr_vt "Violencia total"
tab       dv_prtnr_vt
tab       dv_prtnr_vt [iweight=peso2]

keep año-v502 hwidx pesoalnacer dv_prtnr_phy dv_prtnr_sex dv_prtnr_psi dv_prtnr_vt
order año hhid hvidx hwidx

* Peso al nacer
gen lnpeso=ln(pesoalnacer)

* Violencia
gen violencia=1 if dv_prtnr_sex==1
replace violencia=2 if dv_prtnr_phy==1 & violencia==.
replace violencia=3 if dv_prtnr_psi==1 & violencia==.
label define lab_viol 1 "Violencia sexual" 2 "Violencia Física" 3 "Violencia Psicológica"
label values violencia lab_viol

* Grupo de Edades
rename v012 edad
recode edad (15/22=0 "15-22 años") (23/49=1 "23-49 años"), gen(gru_edad)

* Educacion (años)
rename v133 escolaridad
gen ln_sch=ln(escolaridad+1)

* Region 
rename v101 region

* Embarazada
rename v213 embarazada 

* Residente
rename v135 residente

* Estatus casada
rename v502 casada

* Factor de expansión
rename peso2 factor

* Filtros
duplicates drop hhid hvidx, force
keep if dv_prtnr_vt==1 
drop if pesoalnacer==.

* Eliminar variables
drop dv_prtnr_phy dv_prtnr_sex dv_prtnr_psi dv_prtnr_vt v044

* Generar dummies de violencia
tab violencia, gen(viol)
rename (viol1 viol2 viol3) (viol_sex viol_fis viol_psico)

* Ordenar
sort hhid hvidx hwidx
order region area edad gru_edad escolaridad ln_sch, a(hwidx)
order factor, last

save "$works/endes_violencia_2019.dta", replace

drop viol_*
export excel "$works/endes_violencia_2019.xlsx", firstrow(variable) replace

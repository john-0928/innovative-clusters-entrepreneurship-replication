



***Calculate the changes in entrepreneurial vitality between pilot and non pilot cities of innovative industrial clusters
clear all
set more off
use "C:\Users\biaol\Desktop\Submit the paper with data and code\Master data.dta",clear
collapse (mean) entreact, by(year treat)
rename entreact ent_mean
sort treat year

use "C:\Users\biaol\Desktop\Submit the paper with data and code\Master data.dta",clear
***benchmark regression
global var gdp fin stru wage gov human pubservice

reghdfe  entreact did ,noabsorb 
eststo n1

reghdfe  entreact did $var,noabsorb 
eststo n2

reghdfe  entreact did $var,abs(city year)cluster(city)
eststo n3

esttab n1 n2 n3 using "Benchmark regression results.rtf",  b(%6.3f) ci(%6.3f)  star( * 0.1 ** 0.05 *** 0.01) replace nogap  scalars(N r2_a) sfmt(%20.0f %6.3f )	


***Parallel trend test
gen policy = year - gvar
tab policy 
replace policy = -5 if policy < -5
replace policy = 5 if policy > 5

forvalues i = 5(-1)1{ 
 gen pre`i' = ( policy == -`i'  ) 
 }
gen current = (policy== 0 )
 forvalues j = 1(1)5{ 
 gen post`j' = ( policy == `j'  )
 }

reghdfe entreact $var pre5 pre4 pre3 pre2 current post1 post2 post3 post4 post5,absorb(city year)cluster(city)
eststo n1

esttab n1  using "Parallel trend test.rtf",  b(%6.3f) ci(%6.3f) star( * 0.1 ** 0.05 *** 0.01) replace nogap  scalars(N r2_a) sfmt(%20.0f %6.3f )	


** Sensitivity test: Different standard errors
* robust
reghdfe entreact $var pre5 pre4 pre3 pre2 current post1 post2 post3 post4 post5, absorb(city year) vce(robust)
est store se_robust
test pre5 pre4 pre3 pre2

* city cluster
reghdfe entreact $var pre5 pre4 pre3 pre2 current post1 post2 post3 post4 post5, absorb(city year) vce(cluster city)
est store se_city
test pre5 pre4 pre3 pre2

* year cluster
reghdfe entreact $var pre5 pre4 pre3 pre2 current post1 post2 post3 post4 post5, absorb(city year) vce(cluster year)
est store se_year
test pre5 pre4 pre3 pre2

* two-way cluster
reghdfe entreact $var pre5 pre4 pre3 pre2 current post1 post2 post3 post4 post5, absorb(city year) vce(cluster city year)
est store se_cityyear
test pre5 pre4 pre3 pre2

esttab se_robust se_city se_year se_cityyear using "Sensitivity analysis.rtf",  b(%6.3f) ci(%6.3f) star( * 0.1 ** 0.05 *** 0.01) replace nogap  scalars(N r2_a) sfmt(%20.0f %6.3f )	

	
***Endogeneity test
**placebo test
mat b=J(1000,1,0)  
mat se=J(1000,1,0)  
mat p=J(1000,1,0)  

forvalues i = 1/1000{ 
 use "C:\Users\biaol\Desktop\Submit the paper with data and code\placebo test.dta", clear
 xtset city year
 keep if year==2009
 sample 78, count 
 keep city 
 save match_city.dta,replace 
 merge 1:m city using "C:\Users\biaol\Desktop\Submit the paper with data and code\placebo test.dta"
 gen ntreat=(_merge==3)  
 gen ntreat_post=ntreat*post
 reghdfe entreact ntreat post ntreat_post $var,absorb(city year)cluster(city)
 
 mat b[`i' ,1] = _b[ntreat_post]
 mat se[`i' ,1] = _se[ntreat_post]
 scalar df_r = e(N) - e(df_m) - 1
 mat p[`i',1] = 2*ttail(df_r,abs(_b[ntreat_post]/_se[ntreat_post]))
 }

 svmat b, names(coef)
 svmat se, names(se)
 svmat p, names(pvalue)
 
 drop if pvalue1 == .
 label var pvalue1 p值
 label var coef1 估计系数
 keep coef1 se1 pvalue1
 save placebo.dta,replace 
  
twoway (scatter pvalue1 coef1, msymbol(circle) mcolor(ebblue%50) mlwidth(none) msize(small)) (kdensity coef1, yaxis(2) lcolor(cranberry) lwidth(medthick) lp(solid)), xlabel(-0.5(0.1)0.5, labsize(small)) ylabel(0(0.2)1.0, format(%7.1f) angle(0) axis(1) labsize(small) nogrid) ylabel(0(0.5)2.5, angle(0) axis(2) labsize(small) nogrid) xtitle("Estimated coefficients", size(small)) ytitle("P value", axis(1) size(small)) ytitle("Density", axis(2) size(small)) xline(0.0, lcolor(gs8) lwidth(thin) lp(solid)) yline(0.1, lcolor(gs8) lwidth(thin) lp(shortdash)) xline(0.294, lcolor(black) lwidth(medthin) lp(dash)) text(0.9 0.294 "0.294", placement(w) size(small) color(black)) legend(order(1 "P value" 2 "Density") size(small) position(6) ring(1) cols(2) region(lstyle(none) fcolor(none))) plotregion(style(none) margin(zero)) graphregion(color(white)) 
 
 	   
**PSM-DID inspection
global var gdp fin stru wage gov human pubservice

set seed 10101 
gen tmp = runiform()
sort tmp 

psmatch2 treat $var, caliper(0.05) outcome(entreact) neighbor(4)  common ai(1) ties ate
pstest $var, both graph 
psgraph 
reghdfe entreact did $var if _support==1,abs(city year)cluster(city)
est store n1

psmatch2 treat $var, radius caliper(.01)  outcome(entreact) logit common ai(1) ties ate
pstest  $var, both graph 
psgraph 
reghdfe entreact did $var if _support==1,abs(city year)cluster(city)
est store n2
  
psmatch2 treat $var, outcome(entreact) kernel logit common ties ate
pstest $var, both graph 
psgraph 
reghdfe entreact did $var if _support==1,abs(city year)cluster(city)
est store n3

esttab  n1 n2 n3 using "PSM-DID inspection.rtf", b(%6.3f) ci(%6.3f) star( * 0.1 ** 0.05 *** 0.01) replace nogap  scalars(N r2_a) sfmt(%20.0f %6.3f )	 


**Instrumental Variables Method
global var gdp fin stru wage gov human pubservice

reg did iv_hl $var, robust
eststo n1

ivreg2 entreact $var (did = iv_hl), robust
eststo n2

reg did iv_sy $var, robust
eststo n3

ivreg2 entreact $var (did = iv_sy), robust
eststo n4

esttab n1 n2 n3 n4 using "Estimation results of instrumental variable method.rtf", replace b(%6.3f) ci(%6.3f) star(* 0.10 ** 0.05 *** 0.01) nogap mtitles("(1) Phase One" "(2) Phase Two" "(3) Phase One" "(4) Phase Two") mlabels("IV=iv_hl" "IV=iv_hl" "IV=iv_sy" "IV=iv_sy") scalars(N r2) sfmt(%12.0f)


***Other robustness tests
global var gdp fin stru wage gov human pubservice

reghdfe y did $var,abs(city year)cluster(city)
est store n1

reghdfe entreact did $var if Excludespecialsamples==1,abs(city year)cluster(city)
est store n2

reghdfe entreact did $var if time==1,abs(city year)cluster(city)
est store n3

reghdfe entreact did $var,abs(city year city#c.year)cluster(city)
est store n4

reghdfe entreact did $var,abs(city year province#year)cluster(city)
est store n5

reghdfe entreact did did1 did2 did3 $var ,abs(city year)cluster(city)
est store n6

reghdfe  entreact did $var,abs(city year)cluster(city year)
est store n7

reghdfe entreact did pop internet $var ,abs(city year)cluster(city)
est store n8

esttab n1 n2 n3 n4 n5 n6 n7 n8 using "Other robustness tests.rtf", b(%6.3f) ci(%6.3f) star( * 0.1 ** 0.05 *** 0.01) replace nogap  scalars(N r2_a) sfmt(%20.0f %6.3f )


**Analysis of Heterogeneity Treatment Effect
*1.Goodman Beacon decomposition
global var gdp fin stru wage gov human pubservice

xtset city year
reghdfe  entreact did $var,abs(city year)vce(cluster city)
bacondecomp entreact did $var

*2.Heterogeneity Robust Estimation Test (CSDID)
xtset city year
csdid entreact,ivar(city) time(year) gvar(gvar) notyet

estat simple,estore(simpleatt)

estat group,estore(groupatt)

estat calendar,estore(timeatt)

estat event,estore(eventatt)

esttab simpleatt groupatt timeatt eventatt using "Heterogeneity robust estimator test (CSDID).rtf",replace b(%6.3f) ci(%6.3f) star(* 0.10 ** 0.05 *** 0.01) mtitles("Simple ATT" "Group ATT" "Calendar ATT" "Event ATT")


***mechanism test
global var gdp fin stru wage gov human pubservice

reghdfe  talents did $var,abs(city year)cluster(city)
est store n1

reghdfe technology did $var,abs(city year)cluster(city)
est store n2

reghdfe venture did $var,abs(city year)cluster(city)
est store n3

reghdfe digital_finance did $var,abs(city year)cluster(city)
est store n4

reghdfe domestic_demand did $var,abs(city year)cluster(city)
est store n5

reghdfe foreign_demand did $var,abs(city year)cluster(city)
est store n6

esttab n1 n2 n3 n4 n5 n6 using "Mechanism testing regression results.rtf", b(%6.3f) ci(%6.3f) star( * 0.1 ** 0.05 *** 0.01) replace nogap  scalars(N r2_a) sfmt(%20.0f %6.3f )


***Heterogeneity Analysis
global var gdp fin stru wage gov human pubservice

reghdfe entreact did $var if area==1 ,abs(city year)cluster(city)
est store n1

reghdfe entreact did $var if area==0 ,abs(city year)cluster(city)
est store n2

reghdfe entreact did $var if level ==1 ,abs(city year)cluster(city)
est store n3

reghdfe entreact did $var if level ==0 ,abs(city year)cluster(city)
est store n4

esttab n1 n2 n3 n4  using "Analysis results of heterogeneity of urban characteristics.rtf", b(%6.3f) ci(%6.3f) star( * 0.1 ** 0.05 *** 0.01) replace nogap  scalars(N r2_a) sfmt(%20.0f %6.3f )

reghdfe entreact did $var if resource_city ==1 ,abs(city year)cluster(city)
est store n1

reghdfe entreact did $var if resource_city ==0 ,abs(city year)cluster(city)
est store n2

reghdfe entreact did $var if market ==1 ,abs(city year)cluster(city)
est store n3

reghdfe entreact did $var if market ==0 ,abs(city year)cluster(city)
est store n4

esttab n1 n2 n3 n4 using "Analysis results of market environment heterogeneity.rtf", b(%6.3f) ci(%6.3f) star( * 0.1 ** 0.05 *** 0.01) replace nogap  scalars(N r2_a) sfmt(%20.0f %6.3f )

reghdfe manufacturing did $var,abs(city year)cluster(city)
est store n1

reghdfe service did $var,abs(city year)cluster(city)
est store n2

reghdfe produserv did $var,abs(city year)cluster(city)
est store n3

reghdfe consumserv did $var,abs(city year)cluster(city)
est store n4

esttab  n1 n2 n3 n4 using "Analysis results of heterogeneity in industry distribution.rtf", b(%6.3f) ci(%6.3f) star( * 0.1 ** 0.05 *** 0.01) replace nogap  scalars(N r2_a) sfmt(%20.0f %6.3f )


**Analysis of Spatial Spillover Effect
**Generate three types of spatial weight matrices
**adjacency matrix
cd "C:\Users\biaol\Desktop\Submit the paper with data and code"
use "C:\Users\biaol\Desktop\Submit the paper with data and code\w1.dta"",clear

egen rowsum = rowtotal(a*)
foreach v of varlist a* {
    replace `v' = `v' / rowsum if rowsum != 0
}
drop rowsum
unab vars : a*
mkmat `vars', matrix(w11)
matrix list w11

preserve
clear
svmat w11, names(col)
save "C:\Users\biaol\Desktop\Submit the paper with data and code\w11.dta", replace
restore

clear all
set more off

**Geographic distance matrix
cd "C:\Users\biaol\Desktop\Submit the paper with data and code"
use "C:\Users\biaol\Desktop\Submit the paper with data and code\w2.dta",clear

tempfile base left
save `base'
rename id id1
rename lon lon1
rename lat lat1
save `left'
use `base', clear
rename id id2
rename lon lon2
rename lat lat2
cross using `left'
geodist lat1 lon1 lat2 lon2, gen(dist_km)
gen w = 1/dist_km if dist_km > 0
replace w = 0 if id1 == id2
keep id1 id2 w
sort id1 id2
reshape wide w , i(id1) j(id2)

egen rowsum = rowtotal(w*)
foreach v of varlist w* {
    replace `v' = `v' / rowsum if rowsum != 0
}
drop rowsum
unab vars : w*
mkmat `vars', matrix(w22)
matrix list w22

preserve
clear
svmat w22, names(col)
save "C:\Users\biaol\Desktop\Submit the paper with data and code\w22.dta", replace
restore

clear all
set more off

**Economic Geography Nested Matrix
cd "C:\Users\biaol\Desktop\Submit the paper with data and code"
use "C:\Users\biaol\Desktop\Submit the paper with data and code\w3.dta",clear

collapse (mean) lon lat pgdp, by(id)
keep id lon lat pgdp
duplicates drop id, force
tempfile base left
save `base'

rename id   id1
rename lon  lon1
rename lat  lat1
rename pgdp pgdp1
save `left'

use `base', clear
rename id   id2
rename lon  lon2
rename lat  lat2
rename pgdp pgdp2

cross using `left'
geodist lat1 lon1 lat2 lon2, gen(dist_km)
gen wg = 1/dist_km if id1 != id2
replace wg = 0 if id1 == id2
gen ediff = abs(pgdp1 - pgdp2)
gen we = 1/ediff if id1 != id2 & ediff != 0
replace we = 0 if id1 == id2
replace we = 0 if missing(we)
gen w_geoeco = wg * we
replace w_geoeco = 0 if missing(w_geoeco)
keep id1 id2 w_geoeco
sort id1 id2
reshape wide w_geoeco, i(id1) j(id2)

egen rowsum = rowtotal(w_geoeco*)
foreach v of varlist w_geoeco* {
    replace `v' = `v' / rowsum if rowsum != 0
}
drop rowsum
unab vars : w_geoeco*
mkmat `vars', matrix(w33)
matrix list w33

preserve
clear
svmat w33, names(col)
save "C:\Users\biaol\Desktop\Submit the paper with data and code\w33.dta", replace
restore

clear all
set more off


**Global Moran Index (Adjacent Matrix)
cd "C:\Users\biaol\Desktop\Submit the paper with data and code"
use "C:\Users\biaol\Desktop\Submit the paper with data and code\Spatial effect master data.dta",clear

spatwmat using w11.dta, n(w11) standardize
matrix list w11

preserve
keep if year == 2009
spatgsa entreact, weights(w11) moran geary twotail
return list
matrix list r(Moran)
restore

tempname memhold
tempfile moran_result

postfile `memhold' int year double moranI E_I sd_I z_I p_I using `moran_result', replace

forvalues i = 2009/2024 {
    preserve
    keep if year == `i'
    
    count
    if r(N) > 0 {
        spatgsa entreact, weights(w11) moran twotail
        
        matrix M = r(Moran)
     
        post `memhold' (`i') (M[1,1]) (M[1,2]) (M[1,3]) (M[1,4]) (M[1,5])
    }
    else {
        post `memhold' (`i') (.) (.) (.) (.) (.)
    }
    
    restore
}

postclose `memhold'

use `moran_result', clear
sort year
list, sep(0)

save "Moran_result_w11.dta", replace

**Global Moran Index (Geographic Distance Matrix)
cd "C:\Users\biaol\Desktop\Submit the paper with data and code"
use "C:\Users\biaol\Desktop\Submit the paper with data and code\Spatial effect master data.dta",clear

spatwmat using w22.dta, n(w22) standardize
matrix list w22

preserve
keep if year == 2009
spatgsa entreact, weights(w22) moran geary twotail
return list
matrix list r(Moran)
restore

tempname memhold
tempfile moran_result

postfile `memhold' int year double moranI E_I sd_I z_I p_I using `moran_result', replace

forvalues i = 2009/2024 {
    preserve
    keep if year == `i'
    
    count
    if r(N) > 0 {
        spatgsa entreact, weights(w22) moran twotail
        
        matrix M = r(Moran)
     
        post `memhold' (`i') (M[1,1]) (M[1,2]) (M[1,3]) (M[1,4]) (M[1,5])
    }
    else {
        post `memhold' (`i') (.) (.) (.) (.) (.)
    }
    
    restore
}
postclose `memhold'

use `moran_result', clear
sort year
list, sep(0)

save "Moran_result_w22.dta", replace


**Global Moran Index (Economic Geography Nested Matrix)
cd "C:\Users\biaol\Desktop\Submit the paper with data and code"
use "C:\Users\biaol\Desktop\Submit the paper with data and code\Spatial effect master data.dta",clear

spatwmat using w33.dta, n(w33) standardize
matrix list w33

preserve
keep if year == 2009
spatgsa entreact, weights(w33) moran geary twotail
return list
matrix list r(Moran)
restore

tempname memhold
tempfile moran_result

postfile `memhold' int year double moranI E_I sd_I z_I p_I using `moran_result', replace

forvalues i = 2009/2024 {
    preserve
    keep if year == `i'
    
    count
    if r(N) > 0 {
        spatgsa entreact, weights(w33) moran twotail
        
        matrix M = r(Moran)
     
        post `memhold' (`i') (M[1,1]) (M[1,2]) (M[1,3]) (M[1,4]) (M[1,5])
    }
    else {
        post `memhold' (`i') (.) (.) (.) (.) (.)
    }
    
    restore
}
postclose `memhold'

use `moran_result', clear
sort year
list, sep(0)

save "Moran_result_w33.dta", replace

**SDM analysis under three spatial weight matrices
clear all
set more off
cd "C:\Users\biaol\Desktop\Submit the paper with data and code"
use "C:\Users\biaol\Desktop\Submit the paper with data and code\Spatial effect master data.dta",clear

xtset id year
global y entreact
global x did gdp fin stru wage gov human pubservice

xtreg $y $x i.year, fe 
est store FE

xtreg $y $x i.year, re
est store RE

hausman FE RE, sigmamore

xtreg $y $x i.year, fe vce(robust)
est store FE

spatwmat using w11.dta, n(w11) standardize
matrix list w11

xsmle $y $x, wmat(w11) model(sar) fe type(both) effects nolog
est store sar_w11

xsmle $y $x, ematrix(w11) model(sem) fe type(both) effects nolog
est store sem_w11

xsmle $y $x, wmat(w11) model(sdm) durbin($x) fe type(both) effects nolog
est store sdm_w11

lrtest sar_w11 sdm_w11

lrtest sem_w11 sdm_w11

test ([Wx]did=0) ([Wx]gdp=0) ([Wx]fin=0) ([Wx]stru=0) ([Wx]wage=0) ([Wx]gov=0) ([Wx]human=0) ([Wx]pubservice=0)

testnl ([Wx]did + [Spatial]rho*[Main]did = 0) ([Wx]gdp + [Spatial]rho*[Main]gdp = 0) ([Wx]fin + [Spatial]rho*[Main]fin = 0) ([Wx]stru + [Spatial]rho*[Main]stru = 0) ([Wx]wage + [Spatial]rho*[Main]wage = 0) ([Wx]gov + [Spatial]rho*[Main]gov = 0) ([Wx]human + [Spatial]rho*[Main]human = 0) ( [Wx]pubservice + [Spatial]rho*[Main]pubservice = 0)

spatwmat using w22.dta, n(w22) standardize
matrix list w22

xsmle $y $x, wmat(w22) model(sar) fe type(both) effects nolog
est store sar_w22

xsmle $y $x, ematrix(w22) model(sem) fe type(both) effects nolog
est store sem_w22

xsmle $y $x, wmat(w22) model(sdm) durbin($x) fe type(both) effects nolog
est store sdm_w22

lrtest sar_w22 sdm_w22

lrtest sem_w22 sdm_w22

test ([Wx]did=0) ([Wx]gdp=0) ([Wx]fin=0) ([Wx]stru=0) ([Wx]wage=0) ([Wx]gov=0) ([Wx]human=0) ([Wx]pubservice=0)

testnl ([Wx]did + [Spatial]rho*[Main]did = 0) ([Wx]gdp + [Spatial]rho*[Main]gdp = 0) ([Wx]fin + [Spatial]rho*[Main]fin = 0) ([Wx]stru + [Spatial]rho*[Main]stru = 0) ([Wx]wage + [Spatial]rho*[Main]wage = 0) ([Wx]gov + [Spatial]rho*[Main]gov = 0) ([Wx]human + [Spatial]rho*[Main]human = 0) ( [Wx]pubservice + [Spatial]rho*[Main]pubservice = 0)

spatwmat using w33.dta, n(w33) standardize
matrix list w33

xsmle $y $x, wmat(w33) model(sar) fe type(both) effects nolog
est store sar_w33

xsmle $y $x, ematrix(w33) model(sem) fe type(both) effects nolog
est store sem_w33

xsmle $y $x, wmat(w33) model(sdm) durbin($x) fe type(both) effects nolog
est store sdm_w33

lrtest sar_w33 sdm_w33

lrtest sem_w33 sdm_w33

test ([Wx]did=0) ([Wx]gdp=0) ([Wx]fin=0) ([Wx]stru=0) ([Wx]wage=0) ([Wx]gov=0) ([Wx]human=0) ([Wx]pubservice=0)

testnl ([Wx]did + [Spatial]rho*[Main]did = 0) ([Wx]gdp + [Spatial]rho*[Main]gdp = 0) ([Wx]fin + [Spatial]rho*[Main]fin = 0) ([Wx]stru + [Spatial]rho*[Main]stru = 0) ([Wx]wage + [Spatial]rho*[Main]wage = 0) ([Wx]gov + [Spatial]rho*[Main]gov = 0) ([Wx]human + [Spatial]rho*[Main]human = 0) ( [Wx]pubservice + [Spatial]rho*[Main]pubservice = 0)

esttab sdm_w11 sdm_w22 sdm_w33 using "Results of Spatial Spillover Effect Test.rtf", replace  b(%6.3f) ci(%6.3f)  star(* 0.10 ** 0.05 *** 0.01)  keep(did Wx:did LR_Direct:did LR_Indirect:did LR_Total:did) nogap scalars(N r2) sfmt(%20.0f %6.3f ) mtitles("w11-SDM" "w22-SDM" "w33-SDM")

**Spatial overflow boundary test
clear all
set more off
cd "C:\Users\biaol\Desktop\Submit the paper with data and code"
use "C:\Users\biaol\Desktop\Submit the paper with data and code\Spatial effect master data.dta",clear

xtset id year
keep id year entreact did pilot gdp fin stru wage gov human pubservice
tempfile panelbase
save `panelbase'

keep id year pilot
rename id toid
tempfile pilotinfo
save `pilotinfo'

use "C:\Users\biaol\Desktop\Submit the paper with data and code\Traffic distance data.dta", clear
tempfile distbase
save `distbase'

clear
set obs 16
gen year = 2009 + _n - 1
tempfile years
save `years'

use `distbase', clear
cross using `years'

merge m:1 toid year using `pilotinfo', nogen
replace pilot = 0 if missing(pilot)

drop if fromid == toid
gen ring100 = (dist>0 & dist<=100 & pilot==1)
gen ring200 = (dist>100 & dist<=200 & pilot==1)
gen ring300 = (dist>200 & dist<=300 & pilot==1)
gen ring400 = (dist>300 & dist<=400 & pilot==1)
gen ring500 = (dist>400 & dist<=500 & pilot==1)

bysort fromid year: egen N100 = max(ring100)
bysort fromid year: egen N200 = max(ring200)
bysort fromid year: egen N300 = max(ring300)
bysort fromid year: egen N400 = max(ring400)
bysort fromid year: egen N500 = max(ring500)

keep fromid year N100 N200 N300 N400 N500 
duplicates drop
rename fromid id
tempfile spillring
save `spillring'

use `panelbase', clear
merge 1:1 id year using `spillring', nogen

replace N100 = 0 if missing(N100)
replace N200 = 0 if missing(N200)
replace N300 = 0 if missing(N300)
replace N400 = 0 if missing(N400)
replace N500 = 0 if missing(N500)

xtset id year
reghdfe entreact did N100 N200 N300 N400 N500 gdp fin stru wage gov human pubservice, absorb(id year) vce(cluster id)
est store m

esttab m using "Results of Spatial Overflow Boundary Inspection.rtf", replace  b(%6.3f) ci(%6.3f)  star(* 0.10 ** 0.05 *** 0.01) nogap scalars(N r2) sfmt(%20.0f %6.3f )





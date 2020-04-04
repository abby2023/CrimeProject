
use dna_stats

** Note: SDIS stats are per 10,000 residents. Change to per 100,000
replace sdis = sdis*10
replace ndis= ndis*10

gen post1999 = year>=1999
gen sex_f_cX1999 = sex_f_c*post1999
gen violent_f_cX1999 = violent_f_c*post1999
gen burglary_cX1999 = burglary_c*post1999
gen all_f_cX1999 = all_f_c*post1999

gen sex_f_iX1999 = sex_f_i*post1999
gen violent_f_iX1999 = violent_f_i*post1999
gen burglary_iX1999 = burglary_i*post1999
gen all_f_iX1999 = all_f_i*post1999


** Note: start year = 9999 if given category of offenders had not yet been added in that state
gen sex1999_duration = 0
replace sex1999_duration = year - sex_f_c_start if year>=1999
replace sex1999_duration = 0 if sex1999_duration<0
replace sex1999_duration = . if sex_f_cX1999==.

gen violent1999_duration = 0
replace violent1999_duration = year - violent_f_c_start if year>=1999
replace violent1999_duration = 0 if violent1999_duration<0

gen burglary1999_duration = 0
replace burglary1999_duration = year - burglary_c_start if year>=1999
replace burglary1999_duration = 0 if burglary1999_duration<0

gen all1999_duration = 0
replace all1999_duration = year - all_f_c_start if year>=1999
replace all1999_duration = 0 if all1999_duration<0


* Calculate relevant start date for "releasee" instrument below (lagged by expected time served)
	** Data on mean time served comes from the 1999 National Corrections Reporting Program: http://www.bjs.gov/index.cfm?ty=pbdetail&iid=2045
		* Rape: 69 months = 5.75 years
		* Murder: 87 months = 7.25 years
		* Robbery: 44 months = 3.67 years
		* Assault: 30 months = 2.5 years
			* Mean violent offense: (430*87 + 3312*44 + 1602*30)/(430+3312+1602) = 231,198/5344 = 43.3 months
		* Burglary: 29 months = 2.42 years
		* Larceny: 21 months = 1.75 years
		* V theft: 21 months = 1.75 years		
			* Mean other offense = (1572*21 + 514+21)/(1572+514) = 21 months


gen sex1999_duration_released = 0
replace sex1999_duration_released = year - sex_f_c_start + 5.75 if year>=1999
replace sex1999_duration_released = 0 if sex1999_duration_released<0
replace sex1999_duration_released = . if sex_f_cX1999==.

gen violent1999_duration_released = 0
replace violent1999_duration_released = year - violent_f_c_start + 3.6 if year>=1999
replace violent1999_duration_released = 0 if violent1999_duration_released<0

gen burglary1999_duration_released = 0
replace burglary1999_duration_released = year - burglary_c_start + 2.42 if year>=1999
replace burglary1999_duration_released = 0 if burglary1999_duration_released<0

gen all1999_duration_released = 0
replace all1999_duration_released = year - all_f_c_start +1.75 if year>=1999
replace all1999_duration_released = 0 if all1999_duration_released<0

replace ndis = 0 if sex_f_c==0
replace sdis = 0 if sex_f_c==0

** Use number of profiles uploaded to NDIS to impute number in SDIS, if latter is unavailable
reg sdis ndis if year>=2000
gen sdis1 = 168.0779+.9971228*ndis
replace sdis1 = sdis if sdis!=.

gen fips_st = 	.	
replace fips_st = 	1 if state ==	"Alabama"
replace fips_st =  	2 if state ==	"Alaska"
replace fips_st =  	4 if state ==	"Arizona"
replace fips_st = 	5 if state ==	"Arkansas"
replace fips_st = 	6 if state ==	"California"
replace fips_st = 	8 if state ==	"Colorado"
replace fips_st = 	9 if state ==	"Connecticut"
replace fips_st = 	10 if state ==	"Delaware"
replace fips_st = 	11 if state ==	"DC"
replace fips_st = 	12 if state ==	"Florida"
replace fips_st = 	13 if state ==	"Georgia"
replace fips_st = 	15 if state ==	"Hawaii"
replace fips_st = 	16 if state ==	"Idaho"
replace fips_st = 	17 if state ==	"Illinois"
replace fips_st = 	18 if state ==	"Indiana"
replace fips_st = 	19 if state ==	"Iowa"
replace fips_st = 	20 if state ==	"Kansas"
replace fips_st = 	21 if state ==	"Kentucky"
replace fips_st = 	22 if state ==	"Louisiana"
replace fips_st = 	23 if state ==	"Maine"
replace fips_st = 	24 if state ==	"Maryland"
replace fips_st = 	25 if state ==	"Massachusetts"
replace fips_st = 	26 if state ==	"Michigan"
replace fips_st = 	27 if state ==	"Minnesota"
replace fips_st = 	28 if state ==	"Mississippi"
replace fips_st = 	29 if state ==	"Missouri"
replace fips_st = 	30 if state ==	"Montana"
replace fips_st = 	31 if state ==	"Nebraska"
replace fips_st = 	32 if state ==	"Nevada"
replace fips_st = 	33 if state ==	"New Hampshire"
replace fips_st = 	34 if state ==	"New Jersey"
replace fips_st = 	35 if state ==	"New Mexico"
replace fips_st = 	36 if state ==	"New York"
replace fips_st = 	37 if state ==	"North Carolina"
replace fips_st = 	38 if state ==	"North Dakota"
replace fips_st = 	39 if state ==	"Ohio"
replace fips_st = 	40 if state ==	"Oklahoma"
replace fips_st = 	41 if state ==	"Oregon"
replace fips_st = 	42 if state ==	"Pennsylvania"
replace fips_st = 	44 if state ==	"Rhode Island"
replace fips_st = 	45 if state ==	"South Carolina"
replace fips_st = 	46 if state ==	"South Dakota"
replace fips_st = 	47 if state ==	"Tennessee"
replace fips_st = 	48 if state ==	"Texas"
replace fips_st = 	49 if state ==	"Utah"
replace fips_st = 	50 if state ==	"Vermont"
replace fips_st = 	51 if state ==	"Virginia"
replace fips_st = 	53 if state ==	"Washington"
replace fips_st = 	54 if state ==	"West Virginia"
replace fips_st = 	55 if state ==	"Wisconsin"
replace fips_st = 	56 if state ==	"Wyoming"


sort fips_st year
drop ndis sdis

merge fips_st year using crime_stats
drop _merge

sort fips_st
merge fips_st using crime1999
drop _merge

sort fips_st
merge fips_st  using prison99
drop _merge

sort fips_st
merge fips_st  using prison99_natl
drop _merge


** Estimate number of qualifying offenders of each type, based on each instrument definition
gen sdis_sim_cXdur_sex = qualsex_rate1999*sex1999_duration
gen sdis_sim_cXdur_viol = qualviolent_rate1999*violent1999_duration
gen sdis_sim_cXdur_burg = qualburg_rate1999*burglary1999_duration
gen sdis_sim_cXdur_all = qualall_rate1999*all1999_duration

gen sdis_sim_c_clearedXdur_sex = qualsex_cleared_rate1999*sex1999_duration
gen sdis_sim_c_clearedXdur_viol = qualviolent_cleared_rate1999*violent1999_duration
gen sdis_sim_c_clearedXdur_burg = qualburg_cleared_rate1999*burglary1999_duration
gen sdis_sim_c_clearedXdur_all = qualall_cleared_rate1999*all1999_duration

gen sdis_sim_c_convictXdur_sex = qualsex_convict_rate1999*sex1999_duration
gen sdis_sim_c_convictXdur_viol = qualviolent_convict_rate1999*violent1999_duration
gen sdis_sim_c_convictXdur_burg = qualburg_convict_rate1999*burglary1999_duration
gen sdis_sim_c_convictXdur_all = qualall_convict_rate1999*all1999_duration

gen sdis_sim_c_releasedXdur_sex = qualsex_convict_rate1999*sex1999_duration_released
gen sdis_sim_c_releasedXdur_viol = qualviolent_convict_rate1999*violent1999_duration_released
gen sdis_sim_c_releasedXdur_burg = qualburg_convict_rate1999*burglary1999_duration_released
gen sdis_sim_c_releasedXdur_all = qualall_convict_rate1999*all1999_duration_released

gen sdis_sim_c_clearedXdur_sex40 = qualsex_cleared40_rate1999*sex1999_duration
gen sdis_sim_c_clearedXdur_viol40 = qualviolent_cleared40_rate1999*violent1999_duration
gen sdis_sim_c_clearedXdur_burg40 = qualburg_cleared40_rate1999*burglary1999_duration
gen sdis_sim_c_clearedXdur_all40 = qualall_cleared40_rate1999*all1999_duration

gen sdis_sim_c_convictXdur_sex40 = qualsex_convict40_rate1999*sex1999_duration
gen sdis_sim_c_convictXdur_viol40 = qualviolent_convict40_rate1999*violent1999_duration
gen sdis_sim_c_convictXdur_burg40 = qualburg_convict40_rate1999*burglary1999_duration
gen sdis_sim_c_convictXdur_all40 = qualall_convict40_rate1999*all1999_duration

gen sdis_sim_c_releasedXdur_sex40 = qualsex_convict40_rate1999*sex1999_duration_released
gen sdis_sim_c_releasedXdur_viol40 = qualviolent_convict40_rate1999*violent1999_duration_released
gen sdis_sim_c_releasedXdur_burg40 = qualburg_convict40_rate1999*burglary1999_duration_released
gen sdis_sim_c_releasedXdur_all40 = qualall_convict40_rate1999*all1999_duration_released
		
gen sdis_sim_i_sex = 0
replace sdis_sim_i_sex = prison_rape_m+prison_rape_f+prison_othsex_m+prison_othsex_f if sex_f_iX1999==1
gen sdis_sim_i_viol = 0
replace sdis_sim_i_viol = prison_murder_m+prison_murder_f+prison_assault_m+prison_assault_f+prison_robbery_m+prison_robbery_f+prison_othviol_m+prison_othviol_f if violent_f_iX1999==1
gen sdis_sim_i_burg = 0
replace sdis_sim_i_burg = prison_burglary_m + prison_burglary_f if burglary_iX1999==1
gen sdis_sim_i_all = 0
replace sdis_sim_i_all = prison_larceny_m + prison_larceny_f + prison_vtheft_m + prison_vtheft_f + prison_fraud_m + prison_fraud_f + prison_othprop_m + prison_othprop_f + prison_drug_m + prison_drug_f + prison_oth_m + prison_oth_f if all_f_iX1999==1

** Take into account age profiles of offenders

	* Based on data from the 2000 State Court Processing Statistics
		* Murder: 86.72% of arrestees and 86.84% of convicts are under age 40
		* Rape: 79.01% of arrestees and 79.10% of convicts are under age 40
		* Assault: 79.30% of arrestees and 79.88% of convicts are under age 40
		* Robbery: 90.32% of arrestees and 94.14% of convicts are under age 40
			* Mean violent offense: 82.50% of arrestees and 84.31% of convicts are under age 40
		* Burglary: 83.69% of arrestees and 83.09% of convicts are under age 40
		* Larceny: 75.91% of arrestees and 73.06% of convicts are under age 40
		* Vtheft: 89.57% of arrestees and 92.02% of convicts are under age 40
			* Mean other offense = 79.55% of arrestees and 78.00% of convicts are under 40

gen sdis_sim_i_sex40 = 0
replace sdis_sim_i_sex40 = prison_rape_m*0.7910 +prison_rape_f*0.7910 +prison_othsex_m*0.7910 +prison_othsex_f*0.7910 if sex_f_iX1999==1
gen sdis_sim_i_viol40 = 0
replace sdis_sim_i_viol40 = prison_murder_m*0.8684 +prison_murder_f*0.8684 +prison_assault_m*0.7988 +prison_assault_f*0.7988+prison_robbery_m*0.9414 +prison_robbery_f*0.9414 +prison_othviol_m*0.8431 +prison_othviol_f*0.8431 if violent_f_iX1999==1
gen sdis_sim_i_burg40 = 0
replace sdis_sim_i_burg40 = prison_burglary_m*0.8309 + prison_burglary_f*0.8309 if burglary_iX1999==1
gen sdis_sim_i_all40 = 0
replace sdis_sim_i_all40 = prison_larceny_m*0.7306 + prison_larceny_f*0.7306 + prison_vtheft_m*0.9202 + prison_vtheft_f*0.9202 + prison_fraud_m*0.7800 + prison_fraud_f*0.7800 + prison_othprop_m*0.7800 + prison_othprop_f*0.7800 + prison_drug_m*0.7800 + prison_drug_f*0.7800 + prison_oth_m*0.7800 + prison_oth_f*0.7800 if all_f_iX1999==1


** Police officers per capita

merge 1:1 fips_st year using police
drop _merge

gen officers_percap = (officers_male + officers_female)*100000/population
// Data not reported from WV in 2008; use 2007 values instead
sort fips_st year 
replace officers_percap = officers_percap[_n-1] if fips_st==54 & year==2008 & officers_percap==. 



* Create simulated instrument = estimated number of qualifying offenders
gen total_sim_profiles = sdis_sim_cXdur_sex + sdis_sim_cXdur_viol +  sdis_sim_cXdur_burg +  sdis_sim_cXdur_all +  sdis_sim_i_sex + sdis_sim_i_viol + sdis_sim_i_burg  + sdis_sim_i_all
gen total_sim_profiles_cleared = sdis_sim_c_clearedXdur_sex + sdis_sim_c_clearedXdur_viol +  sdis_sim_c_clearedXdur_burg +  sdis_sim_c_clearedXdur_all +  sdis_sim_i_sex + sdis_sim_i_viol + sdis_sim_i_burg  + sdis_sim_i_all
gen total_sim_profiles_convict = sdis_sim_c_convictXdur_sex + sdis_sim_c_convictXdur_viol +  sdis_sim_c_convictXdur_burg +  sdis_sim_c_convictXdur_all +  sdis_sim_i_sex + sdis_sim_i_viol + sdis_sim_i_burg  + sdis_sim_i_all
gen total_sim_profiles_cleared40 = sdis_sim_c_clearedXdur_sex40 + sdis_sim_c_clearedXdur_viol40 +  sdis_sim_c_clearedXdur_burg40 +  sdis_sim_c_clearedXdur_all40 +  sdis_sim_i_sex40 + sdis_sim_i_viol40 + sdis_sim_i_burg40  + sdis_sim_i_all40
gen total_sim_profiles_convict40 = sdis_sim_c_convictXdur_sex40 + sdis_sim_c_convictXdur_viol40 +  sdis_sim_c_convictXdur_burg40 +  sdis_sim_c_convictXdur_all40 +  sdis_sim_i_sex40 + sdis_sim_i_viol40 + sdis_sim_i_burg40  + sdis_sim_i_all40



* Calculate number of qualifying offenders who are released at each date (lagged by expected time served)
	** Data on mean time served comes from the 1999 National Corrections Reporting Program: http://www.bjs.gov/index.cfm?ty=pbdetail&iid=2045
		* Rape: 69 months = 5.75 years
		* Murder: 87 months = 7.25 years
		* Robbery: 44 months = 3.67 years
		* Assault: 30 months = 2.5 years
			* Mean violent offense: (430*87 + 3312*44 + 1602*30)/(430+3312+1602) = 231,198/5344 = 43.3 months = 3.6 years
		* Burglary: 29 months = 2.42 years
		* Larceny: 21 months = 1.75 years
		* V theft: 21 months = 1.75 years		
			* Mean other offense = (1572*21 + 514+21)/(1572+514) = 21 months = 1.75 years
			
* for incarcerated offenders, change start date to 2000 if < 2000
	replace sex_f_i_start = 2000 if sex_f_i_start<2000
	replace violent_f_i_start = 2000 if violent_f_i_start<2000
	replace burglary_i_start = 2000 if burglary_i_start<2000
	replace all_f_i_start = 2000 if all_f_i_start<2000

gen total_sim_profiles_released = sdis_sim_c_releasedXdur_sex + sdis_sim_c_releasedXdur_viol +  sdis_sim_c_releasedXdur_burg +  sdis_sim_c_releasedXdur_all 
replace total_sim_profiles_released = total_sim_profiles_released + sdis_sim_i_sex/5.75 if (year - sex_f_i_start)<=5 & sex_f_i_start!=9999
replace total_sim_profiles_released = total_sim_profiles_released + sdis_sim_i_sex*(1-5/5.75) if (year - sex_f_i_start)==6 & sex_f_i_start!=9999
replace total_sim_profiles_released = total_sim_profiles_released + sdis_sim_i_viol/3.6 if (year - violent_f_i_start)<=3 & violent_f_i_start!=9999
replace total_sim_profiles_released = total_sim_profiles_released + sdis_sim_i_viol*(1-3/3.6) if (year - violent_f_i_start)==4 & violent_f_i_start!=9999
replace total_sim_profiles_released = total_sim_profiles_released + sdis_sim_i_burg/2.42 if (year - burglary_i_start)<=2 & burglary_i_start!=9999
replace total_sim_profiles_released = total_sim_profiles_released + sdis_sim_i_burg*(1-2/2.42) if (year - burglary_i_start)==3 & burglary_i_start!=9999
replace total_sim_profiles_released = total_sim_profiles_released + sdis_sim_i_all/1.75 if (year - all_f_i_start)<=1 & all_f_i_start!=9999
replace total_sim_profiles_released = total_sim_profiles_released + sdis_sim_i_all*(1-1/1.75) if (year - all_f_i_start)==2 & all_f_i_start!=9999


gen total_sim_profiles_released40 = sdis_sim_c_releasedXdur_sex40 + sdis_sim_c_releasedXdur_viol40 +  sdis_sim_c_releasedXdur_burg40 +  sdis_sim_c_releasedXdur_all40 
replace total_sim_profiles_released40 = total_sim_profiles_released40 + sdis_sim_i_sex40/5.75 if (year - sex_f_i_start)<=5 & sex_f_i_start!=9999
replace total_sim_profiles_released40 = total_sim_profiles_released40 + sdis_sim_i_sex40*(1-5/5.75) if (year - sex_f_i_start)==6 & sex_f_i_start!=9999
replace total_sim_profiles_released40 = total_sim_profiles_released40 + sdis_sim_i_viol40/3.6 if (year - violent_f_i_start)<=3 & violent_f_i_start!=9999
replace total_sim_profiles_released40 = total_sim_profiles_released40 + sdis_sim_i_viol40*(1-3/3.6) if (year - violent_f_i_start)==4 & violent_f_i_start!=9999
replace total_sim_profiles_released40 = total_sim_profiles_released40 + sdis_sim_i_burg40/2.42 if (year - burglary_i_start)<=2 & burglary_i_start!=9999
replace total_sim_profiles_released40 = total_sim_profiles_released40 + sdis_sim_i_burg40*(1-2/2.42) if (year - burglary_i_start)==3 & burglary_i_start!=9999
replace total_sim_profiles_released40 = total_sim_profiles_released40 + sdis_sim_i_all40/1.75 if (year - all_f_i_start)<=1 & all_f_i_start!=9999
replace total_sim_profiles_released40 = total_sim_profiles_released40 + sdis_sim_i_all40*(1-1/1.75) if (year - all_f_i_start)==2 & all_f_i_start!=9999


gen totalcrime_rate = murder_rate + rape_rate + assault_rate + robbery_rate + burglary_rate + larceny_rate + vtheft_rate
gen violcrime_rate = murder_rate + rape_rate + assault_rate + robbery_rate 
gen propcrime_rate =  burglary_rate + larceny_rate + vtheft_rate


** Break into Census regions for region-specific year FEs
gen region1 = state=="Maine" | state=="Vermont" | state=="New Hampshire" | state=="Massachusetts" | state=="Rhode Island" | state=="Connecticut" | state=="New Jersey" | state=="Pennsylvania" | state=="New York" 
gen region2 = state=="Ohio" | state=="Michigan" | state=="Indiana" | state=="Wisconsin" | state=="Illinois" | state=="Missouri" | state=="Iowa" | state=="Minnesota" | state=="Kansas" | state=="Nebraska" | state=="South Dakota" | state=="North Dakota"
gen region3 = state=="Texas" | state=="Oklahoma" | state=="Arkansas" | state=="Louisiana" | state=="Mississippi" | state=="Alabama" | state=="Georgia" | state=="Florida" | state=="Tennessee"| state=="Kentucky"| state=="West Virginia"| state=="Delaware" | state=="Maryland" | state=="Virginia"| state=="DC"| state=="North Carolina"| state=="South Carolina" 
gen region4 = state=="Washington" | state=="Montana" | state=="Wyoming" | state=="Idaho" | state=="Oregon" | state=="California" | state=="Nevada" | state=="Utah" | state=="Arizona"  | state=="New Mexico"  | state=="Alaska" | state=="Hawaii"  
gen yearXreg1 = year*region1
gen yearXreg2 = year*region2
gen yearXreg3 = year*region3
gen yearXreg4 = year*region4


** TABLE 7

sum violcrime_rate propcrime_rate murder_rate rape_rate assault_rate robbery_rate burglary_rate larceny_rate vtheft_rate  if year>=2000 & total_sim_profiles!=. & sdis1!=.
sum sex_f_c_start if sex_f_c_start<2011 & year>=2000 &total_sim_profiles!=. & sdis1!=.
sum violent_f_c_start if violent_f_c_start<2011 & year>=2000 &total_sim_profiles!=. & sdis1!=.
sum burglary_c_start if burglary_c_start<2011 & year>=2000 &total_sim_profiles!=. & sdis1!=.
sum all_f_c_start if all_f_c_start<2011 & year>=2000 &total_sim_profiles!=. & sdis1!=.
sum sex_f_i_start  if sex_f_i_start<2011 & year>=2000 &total_sim_profiles!=. & sdis1!=.
sum violent_f_i_start  if violent_f_i_start<2011 & year>=2000 &total_sim_profiles!=. & sdis1!=.
sum burglary_i_start  if burglary_i_start<2011 & year>=2000 &total_sim_profiles!=. & sdis1!=.
sum all_f_i_start if all_f_i_start<2011 & year>=2000 &total_sim_profiles!=. & sdis1!=.
sum sdis1 if year==2000 & total_sim_profiles!=.
sum sdis1 if year==2001 & total_sim_profiles!=.
sum sdis1 if year==2002 & total_sim_profiles!=.
sum sdis1 if year==2003 & total_sim_profiles!=.
sum sdis1 if year==2004 & total_sim_profiles!=.
sum sdis1 if year==2005 & total_sim_profiles!=.
sum sdis1 if year==2006 & total_sim_profiles!=.
sum sdis1 if year==2007 & total_sim_profiles!=.
sum sdis1 if year==2008 & total_sim_profiles!=.
sum sdis1 if year==2009 & total_sim_profiles!=.
sum sdis1 if year==2010 & total_sim_profiles!=.
sum sdis1 if year>=2000 & total_sim_profiles!=.
sum total_sim_profiles total_sim_profiles_cleared total_sim_profiles_cleared40 total_sim_profiles_convict total_sim_profiles_convict40 total_sim_profiles_released total_sim_profiles_released40 if  year>=2000 &total_sim_profiles!=. & sdis1!=.
sum officers_percap if year>=2000 &total_sim_profiles!=. & sdis1!=.




** FIGURE 6

gen eventyear_viol_c = 0 if violent_f_c_start==year 
sort state year
forvalues i = 1/30 {
by state: replace eventyear_viol_c = `i' if eventyear_viol_c[_n-1]==`i'-1
}

forvalues i = 1/30 {
by state: replace eventyear_viol_c = -`i' if eventyear_viol_c[_n+1]==-`i'+1
}

foreach i in viol prop {
foreach j in viol   {
egen `i'crime_rate_`j'c_neg5 = mean(`i'crime_rate) if state!="" & total_sim_profiles_convict!=. & eventyear_`j'_c==-5
egen `i'crime_rate_`j'c_neg4 = mean(`i'crime_rate) if state!="" & total_sim_profiles_convict!=. & eventyear_`j'_c==-4
egen `i'crime_rate_`j'c_neg3 = mean(`i'crime_rate) if state!="" & total_sim_profiles_convict!=. & eventyear_`j'_c==-3
egen `i'crime_rate_`j'c_neg2 = mean(`i'crime_rate) if state!="" & total_sim_profiles_convict!=. & eventyear_`j'_c==-2
egen `i'crime_rate_`j'c_neg1 = mean(`i'crime_rate) if state!="" & total_sim_profiles_convict!=. & eventyear_`j'_c==-1
egen `i'crime_rate_`j'c_zero = mean(`i'crime_rate) if state!="" & total_sim_profiles_convict!=. & eventyear_`j'_c==0
egen `i'crime_rate_`j'c_pos1 = mean(`i'crime_rate) if state!="" & total_sim_profiles_convict!=. & eventyear_`j'_c==1
egen `i'crime_rate_`j'c_pos2 = mean(`i'crime_rate) if state!="" & total_sim_profiles_convict!=. & eventyear_`j'_c==2
egen `i'crime_rate_`j'c_pos3 = mean(`i'crime_rate) if state!="" & total_sim_profiles_convict!=. & eventyear_`j'_c==3
egen `i'crime_rate_`j'c_pos4 = mean(`i'crime_rate) if state!="" & total_sim_profiles_convict!=. & eventyear_`j'_c==4
egen `i'crime_rate_`j'c_pos5 = mean(`i'crime_rate) if state!="" & total_sim_profiles_convict!=. & eventyear_`j'_c==5

gen `i'crime_rate_`j'c = `i'crime_rate_`j'c_neg5 if eventyear_`j'_c==-5
replace `i'crime_rate_`j'c = `i'crime_rate_`j'c_neg4 if eventyear_`j'_c==-4
replace `i'crime_rate_`j'c = `i'crime_rate_`j'c_neg3 if eventyear_`j'_c==-3
replace `i'crime_rate_`j'c = `i'crime_rate_`j'c_neg2 if eventyear_`j'_c==-2
replace `i'crime_rate_`j'c = `i'crime_rate_`j'c_neg1 if eventyear_`j'_c==-1
replace `i'crime_rate_`j'c = `i'crime_rate_`j'c_zero if eventyear_`j'_c==0
replace `i'crime_rate_`j'c = `i'crime_rate_`j'c_pos1 if eventyear_`j'_c==1
replace `i'crime_rate_`j'c = `i'crime_rate_`j'c_pos2 if eventyear_`j'_c==2
replace `i'crime_rate_`j'c = `i'crime_rate_`j'c_pos3 if eventyear_`j'_c==3
replace `i'crime_rate_`j'c = `i'crime_rate_`j'c_pos4 if eventyear_`j'_c==4
replace `i'crime_rate_`j'c = `i'crime_rate_`j'c_pos5 if eventyear_`j'_c==5
}
}

twoway (lpoly violcrime_rate eventyear_viol_c if state!="" & total_sim_profiles_convict!=. & eventyear_viol_c>=-5 & eventyear_viol_c<=0, xtitle("Year relative to expansion") ytitle("Crime Rate") title("Violent Crime")) (lpoly violcrime_rate eventyear_viol_c if state!="" & total_sim_profiles_convict!=. & eventyear_viol_c>=0 & eventyear_viol_c<=5) (scatter violcrime_rate_violc eventyear_viol_c if state!="" & total_sim_profiles_convict!=. & eventyear_viol_c>=-5 & eventyear_viol_c<=5), legend(off)
twoway (lpoly propcrime_rate eventyear_viol_c if state!="" & total_sim_profiles_convict!=. & eventyear_viol_c>=-5 & eventyear_viol_c<=0, xtitle("Year relative to expansion") ytitle("Crime Rate") title("Property Crime")) (lpoly propcrime_rate eventyear_viol_c if state!="" & total_sim_profiles_convict!=. & eventyear_viol_c>=0 & eventyear_viol_c<=5) (scatter propcrime_rate_violc eventyear_viol_c if state!="" & total_sim_profiles_convict!=. & eventyear_viol_c>=-5 & eventyear_viol_c<=5), legend(off)


** TABLE 8
ivregress 2sls violcrime_rate i.yearXreg1 i.yearXreg2 i.yearXreg3 i.yearXreg4 i.fips_st officers_percap (sdis1 =  total_sim_profiles_convict) if year>=2000,  cluster(fips_st)
estat firststage, all
reg sdis1 total_sim_profiles_convict  i.yearXreg1 i.yearXreg2 i.yearXreg3 i.yearXreg4 i.fips_st officers_percap  if year>=2000,  cluster(fips_st)

** TABLE 9

fvset base 13 fips_st
fvset base 2003 year

foreach i in violcrime propcrime murder rape assault robbery burglary larceny vtheft  {

eststo: quietly reg  `i'_rate sdis1 officers_percap i.fips_st i.yearXreg1 i.yearXreg2 i.yearXreg3 i.yearXreg4 if year>=2000 & total_sim_profiles_cleared!=., cluster(fips_st)

eststo: quietly ivregress 2sls `i'_rate i.yearXreg1 i.yearXreg2 i.yearXreg3 i.yearXreg4 i.fips_st officers_percap (sdis1 =  total_sim_profiles) if year>=2000,  cluster(fips_st)

eststo: quietly ivregress 2sls `i'_rate i.yearXreg1 i.yearXreg2 i.yearXreg3 i.yearXreg4 i.fips_st officers_percap (sdis1 =  total_sim_profiles_cleared) if year>=2000,  cluster(fips_st)
eststo: quietly ivregress 2sls `i'_rate i.yearXreg1 i.yearXreg2 i.yearXreg3 i.yearXreg4 i.fips_st officers_percap (sdis1 =  total_sim_profiles_cleared40) if year>=2000,  cluster(fips_st)

eststo: quietly ivregress 2sls `i'_rate i.yearXreg1 i.yearXreg2 i.yearXreg3 i.yearXreg4 i.fips_st officers_percap (sdis1 =  total_sim_profiles_convict) if year>=2000,  cluster(fips_st)
eststo: quietly ivregress 2sls `i'_rate i.yearXreg1 i.yearXreg2 i.yearXreg3 i.yearXreg4 i.fips_st officers_percap (sdis1 =  total_sim_profiles_convict40) if year>=2000,  cluster(fips_st)

eststo: quietly ivregress 2sls `i'_rate i.yearXreg1 i.yearXreg2 i.yearXreg3 i.yearXreg4 i.fips_st officers_percap (sdis1 =  total_sim_profiles_released) if year>=2000 & total_sim_profiles_convict!=.,  cluster(fips_st)
eststo: quietly ivregress 2sls `i'_rate i.yearXreg1 i.yearXreg2 i.yearXreg3 i.yearXreg4 i.fips_st officers_percap (sdis1 =  total_sim_profiles_released40) if year>=2000 & total_sim_profiles_convict!=.,  cluster(fips_st)

esttab using `i'_sim.tex, title(`i' per Capita) label star(* .10 ** .05 *** .01) keep(sdis1) cells(b(fmt(4) star) se(fmt(4) par))  replace r2 se 
eststo clear
}

** TABLE 10
	* Manual calculations


clear

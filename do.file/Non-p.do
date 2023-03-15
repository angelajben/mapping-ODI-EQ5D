*** Non-parametric approach for mapping ODI to EQ-5D-3L STATA CODE *************
*** Based on the Van Hout crosswalk, 2012 
								   
/* ODI Non-p steps:
   1)Generate a list of possible EQ5D3L heath states from the ODI item's responses
   2)Generate a list of transition probabilities (ODI_hs -> EQ5D3L_hs)
   3)Calculate the EQ5D3L index (i.e.,utility) of each correspondend EQ5D3L_hs
   4)Multiply each of the EQ5D3L index by the correspondent transition probability
   5)Summ all obtained indexes to get the crosswalked ODI index
   6)Generate a variable in the dataset which contains the crosswalked ODI index for each observation

Example:
ODI_hs        -> EQ5D3L_hs  == tpODI->3L* EQ5D3Lindex 
224356        -> 11111      == 0.00144  * 1            = 0.00144 +
			  -> 11112      == 0.00554  * 0.805        = 0.00446 +
			  -> 11121      == 0.00581  * 0.843        = 0.00490 +
			  -> 11122      == 0.02230  * 0.719        = 0.01603 +
			  -> 11211      == 0.00585  * 0.897		   = 0.00524 +
			  -> 11212		== 0.02245	* 0.773        = 0.01735 +
			  -> 11221		== 0.02355	* 0.811        = 0.01910 +
			  -> 11222		== 0.09043	* 0.687        = 0.06212 +
			  -> 21111      == 0.00669  * 0.893        = 0.00597 +
			  -> 21112      == 0.02568  * 0.769        = 0.01975 +
			  -> 21121      == 0.02694  * 0.807        = 0.02174 +
			  -> 21122      == 0.10344  * 0.683        = 0.07065 +
			  -> 21211		== 0.02711	* 0.861        = 0.02335 +
			  -> 21212		== 0.10412	* 0.737        = 0.07674 +
			  -> 21221		== 0.10923	* 0.775        = 0.08465 +
			  -> 21222		== 0.41945	* 0.651        = 0.17594
			  
												   = 0.707 -> crosswalked ODI index
*/	 											   
************ NL ****************************************************************
set more off
cd "C:\Mapping-ODI-EQ5D\data"
use "mapp_valid.dta"

* Recode levels of ODI response from 0,1,2,3,4,5 to 1,2,3,4,5,6
replace ODI4=6 if ODI4==5
replace ODI4=5 if ODI4==4
replace ODI4=4 if ODI4==3
replace ODI4=3 if ODI4==2
replace ODI4=2 if ODI4==1
replace ODI4=1 if ODI4==0

replace ODI2=6 if ODI2==5
replace ODI2=5 if ODI2==4
replace ODI2=4 if ODI2==3
replace ODI2=3 if ODI2==2
replace ODI2=2 if ODI2==1
replace ODI2=1 if ODI2==0

replace ODI5=6 if ODI5==5
replace ODI5=5 if ODI5==4
replace ODI5=4 if ODI5==3
replace ODI5=3 if ODI5==2
replace ODI5=2 if ODI5==1
replace ODI5=1 if ODI5==0

replace ODI1=6 if ODI1==5
replace ODI1=5 if ODI1==4
replace ODI1=4 if ODI1==3
replace ODI1=3 if ODI1==2
replace ODI1=2 if ODI1==1
replace ODI1=1 if ODI1==0

replace ODI9=6 if ODI9==5
replace ODI9=5 if ODI9==4
replace ODI9=4 if ODI9==3
replace ODI9=3 if ODI9==2
replace ODI9=2 if ODI9==1
replace ODI9=1 if ODI9==0


* ODI Non-p NL
matrix mobility=(0.5,0.5,0\ 0.1,0.9,0\ 0.1,0.9,0\ 0,1,0\ 0,0.9,0.1\ 0,0.3,0.7)
matrix selfcare=(0.9,0.1,0\ 0.5,0.5,0\ 0.3,0.7,0\ 0.1,0.9,0\ 0,0.6,0.4\ 0,0.6,0.4)
matrix activity=(0.3,0.7,0\ 0.1,0.8,0.1\ 0.1,0.8,0.1\ 0,0.8,0.2\ 0,0.6,0.4\ 0,0.6,0.4)
matrix pain=(0.4,0.6,0\ 0.1,0.9,0\ 0,0.8,0.2\ 0,0.4,0.6\ 0,0.1,0.9\ 0,0,1)
matrix anxiety=(0.8,0.2,0\ 0.7,0.3,0\ 0.7,0.3,0\ 0.5,0.4,0.1\ 0.3,0.5,0.2\ 0.3,0.4,0.3)
matrix coefficients = (1,-0.071,-0.036,-0.161,-0.082,-0.152,-0.032,-0.057,-0.086,-0.329,-0.124,-0.325,-0.234)

gen ODI_nonp = .

local num_obs = _N
forvalues rownum = 1/`num_obs' {

local a ODI4[`rownum']
local b ODI2[`rownum']
local c ODI5[`rownum']
local d ODI1[`rownum']
local e ODI9[`rownum']
local ODI_ds `a' `b' `c' `d' `e'
display `EQ5D5L_ds' 

if `a' == 1 {
 local x1 1 2 3
 display `x1'
 }
if `a' == 2 {
 local x1 1 2 3
 display `x1'
 }
 else if `a' == 3 {
 local x1 1 2 3
 display `x1'
 }
 else if `a' == 4 {
 local x1 1 2 3
 display `x1'
 }
 else if `a' == 5 {
 local x1 1 2 3
 display `x1'
 }
 else if `a' == 6 {
 local x1 1 2 3
 display `x1'
 }
 if `b' == 1 {
 local x2 1 2 3
 display `x2'
 }
if `b' == 2 {
 local x2 1 2 3
 display `x2'
 }
 else if `b' == 3 {
 local x2 1 2 3
 display `x2'
 }
 else if `b' == 4 {
 local x2 1 2 3
 display `x2'
 }
 else if `b' == 5 {
 local x2 1 2 3
 display `x2'
 }
 else if `b' == 6 {
 local x2 1 2 3
 display `x2'
 }
 if `c' == 1 {
 local x3 1 2 3
 display `x3'
 }
 if `c' == 2 {
 local x3 1 2 3
 display `x3'
 }
 else if `c' == 3 {
 local x3 1 2 3
 display `x3'
 }
 else if `c' == 4 {
 local x3 1 2 3
 display `x3'
 }
 else if `c' == 5 {
 local x3 1 2 3
 display `x3'
 }
 else if `c' == 6 {
 local x3 1 2 3
 display `x3'
 }
 if `d' == 1 {
 local x4 1 2 3
 display `x4'
 }
 if `d' == 2 {
 local x4 1 2 3
 display `x4'
 }
 else if `d' == 3 {
 local x4 1 2 3
 display `x4'
 }
 else if `d' == 4 {
 local x4 1 2 3
 display `x4'
 }
 else if `d' == 5 {
 local x4 1 2 3
 display `x4'
 }
 else if `d' == 6 {
 local x4 1 2 3
 display `x4'
 }
 if `e' == 1 {
 local x5 1 2 3
 display `x5'
 }
 if `e' == 2 {
 local x5 1 2 3
 display `x5'
 }
 else if `e' == 3 {
 local x5 1 2 3
 display `x5'
 }
 else if `e' == 4 {
 local x5 1 2 3
 display `x5'
 }
 else if `e' == 5 {
 local x5 1 2 3
 display `x5'
 }
 else if `e' == 6 {
   local x5 1 2 3
   display `x5'
 }
 local ODI_cw_final = 0
 foreach y1 of local x1 {
   foreach y2 of local x2 {
     foreach y3 of local x3 {
       foreach y4 of local x4 {
         foreach y5 of local x5 {
           local EQ5D3L_ds `y1' `y2' `y3' `y4' `y5'
	       display "EQ5D3L_ds: `EQ5D3L_ds'"
	       local mult_tp  = mobility[`a',`y1'] * selfcare[`b',`y2'] * activity[`c',`y3'] * pain[`d',`y4'] * anxiety[`e',`y5']
	       display "Probability of EQ5D3L descriptive system from ODI: `mult_tp'"
		   
		   local EQ5D3L_index = 1
		   
		   if `y1' > 1 {
		     local constant coefficients[1,2]
		     local EQ5D3L_index =`EQ5D3L_index' + `constant'
           }
		   else if `y2' > 1 {
		     local constant coefficients[1,2]
		     local EQ5D3L_index =`EQ5D3L_index' + `constant'
           }
		   else if `y3' > 1 {
		     local constant coefficients[1,2]
		     local EQ5D3L_index =`EQ5D3L_index' + `constant'
           }
		   else if `y4' > 1 {
		     local constant coefficients[1,2]
		     local EQ5D3L_index =`EQ5D3L_index' + `constant'
           }
		   else if `y5' > 1 {
		     local constant coefficients[1,2]
		     local EQ5D3L_index =`EQ5D3L_index' + `constant'
           }
		   if `y1' == 2 { 
			 local coef coefficients[1,3]
		     local EQ5D3L_index =`EQ5D3L_index' + `coef'
           }
		   else if `y1' == 3 {
			 local coef coefficients[1,4]
		     local EQ5D3L_index =`EQ5D3L_index' + `coef'
		   }
		   if `y2' == 2 { 
			 local coef coefficients[1,5]
		     local EQ5D3L_index =`EQ5D3L_index' + `coef'
           }
		   else if `y2' == 3 {
			 local coef coefficients[1,6]
		     local EQ5D3L_index =`EQ5D3L_index' + `coef'
		   }
		   if `y3' == 2 { 
			 local coef coefficients[1,7]
		     local EQ5D3L_index =`EQ5D3L_index' + `coef'
           }
		   else if `y3' == 3 {
			 local coef coefficients[1,8]
		     local EQ5D3L_index =`EQ5D3L_index' + `coef'
		   }
		   if `y4' == 2 { 
			 local coef coefficients[1,9]
		     local EQ5D3L_index =`EQ5D3L_index' + `coef'
           }
		   else if `y4' == 3 {
			 local coef coefficients[1,10]
		     local EQ5D3L_index =`EQ5D3L_index' + `coef'
		   }
		   if `y5' == 2 { 
			 local coef coefficients[1,11]
		     local EQ5D3L_index =`EQ5D3L_index' + `coef'
           }
		   else if `y5' == 3 {
			 local coef coefficients[1,12]
		     local EQ5D3L_index =`EQ5D3L_index' + `coef'
		   }
		   if `y1' == 3 {
		     local at_least3 coefficients[1,13]
		     local EQ5D3L_index =`EQ5D3L_index' + `at_least3'
           }
		   else if `y2' == 3 {
		     local at_least3 coefficients[1,13]
		     local EQ5D3L_index =`EQ5D3L_index' + `at_least3'
           }
		   else if `y3' == 3 {
		     local at_least3 coefficients[1,13]
		     local EQ5D3L_index =`EQ5D3L_index' + `at_least3'
           }
		   else if `y4' == 3 {
		     local at_least3 coefficients[1,13]
		     local EQ5D3L_index =`EQ5D3L_index' + `at_least3'
           }
		   else if `y5' == 3 {
		     local at_least3 coefficients[1,13]
		     local EQ5D3L_index =`EQ5D3L_index' + `at_least3'
           }
		   display "EQ5D3L_index: `EQ5D3L_index'"
		   
		   local EQ5D3L_cw = `mult_tp' * `EQ5D3L_index'
		   display "EQ5D-3L crosswalk index: `EQ5D3L_cw'"
		   
		   local ODI_cw_final = `ODI_cw_final' + `EQ5D3L_cw'
		   display "ODI crosswalk final: `ODI_cw_final'"
		   }
         }
       }
     }
   }
   qui replace ODI_nonp = `ODI_cw_final' in `rownum'
   display `ODI_cw_final'
 }
 **************************** 3L NL *********************************************
gen EQ5D3L_utility = 1
replace EQ5D3L_utility =. if MO == . | SC == . | UA == . | PD == . | AD == .
replace EQ5D3L_utility = EQ5D3L_utility - .071 if MO > 1 | SC > 1 | UA > 1 | PD > 1 | AD > 1
replace EQ5D3L_utility = EQ5D3L_utility - .036 if MO == 2
replace EQ5D3L_utility = EQ5D3L_utility - .161 if MO == 3
replace EQ5D3L_utility = EQ5D3L_utility - .082 if SC == 2
replace EQ5D3L_utility = EQ5D3L_utility - .152 if SC == 3
replace EQ5D3L_utility = EQ5D3L_utility - .032 if UA == 2
replace EQ5D3L_utility = EQ5D3L_utility - .057 if UA == 3
replace EQ5D3L_utility = EQ5D3L_utility - .086 if PD == 2
replace EQ5D3L_utility = EQ5D3L_utility - .329 if PD == 3
replace EQ5D3L_utility = EQ5D3L_utility - .124 if AD == 2
replace EQ5D3L_utility = EQ5D3L_utility - .325 if AD == 3
replace EQ5D3L_utility = EQ5D3L_utility - .234 if MO > 2 | SC > 2 | UA > 2 | PD > 2 | AD > 2

save "mapp_valid_nonp"

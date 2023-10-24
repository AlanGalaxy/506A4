import sas using "C:\Users\sunjiaqi\Downloads\table.sas7bdat"

* d
describe

codebook


* e
generate binary_B3 = 0
replace binary_B3 = 1 if B3 >=3


* f
svyset CaseID [pw=weight_pop]

logistic binary_B3 i.ND2 i.GH1 i.ppeducat i.race_5cat
logit binary_B3 i.ND2 i.GH1 i.ppeducat i.race_5cat


* g
save "C:\Users\sunjiaqi\Downloads\stata_data"





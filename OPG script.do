#Arrange the data in the following order and rename. 
#SNP: T950C; Study: author+year; 
#caseww: Number of wild homozygotes in case group
#contww: Number of wild homozygotes in control group
#casewt: Number of heterozygote in case group
#contwt: Number of heterozygote in control group
#casett: Number of mutation homozygotes in case group
#casett: Number of mutation homozygotes in control group

rename var1 snp
rename var2 study
rename var3 caseww
rename var4 contww
rename var5 casewt
rename var6 contwt
rename var7 casett
rename var8 conttt

#Data processing
gen caseallew=caseww*2+casewt
gen caseallet=casett*2+casewt
gen contallew=contww*2+contwt
gen contallet=conttt*2+contwt

gen casewwwt=caseww+casewt
gen casewttt=casewt+casett
gen contwwwt=contww+contwt
gen contwttt=contwt+conttt

#Allele model (alleT vs alleW) and sensitivity analysis
metan caseallet contallet caseallew contallew , or random second(fixed) counts nograph 
metaninf caseallet contallet caseallew contallew, or fixed label(namevar=study)

#Heterozygote model (wt vs ww) and sensitivity analysis
metan casewt contwt caseww contww, or random second(fixed) nograph 
metaninf caseallet contallet caseallew contallew, or fixed label(namevar=study)

#Homozygous model (tt vs ww) and sensitivity analysis
metan casett conttt caseww contww, or random second(fixed) nograph
metaninf casett conttt caseww contww, or fixed label(namevar=study)

#Dominant model (wttt vs ww) and sensitivity analysis
metan casewttt contwttt caseww contww, or random second(fixed) nograph
metaninf casewttt contwttt caseww contww, or fixed label(namevar=study)

#Recessive model (tt vs wwwt) and sensitivity analysis
metan casett conttt casewwwt contwwwt, or random second(fixed) nograph 
metaninf casett conttt casewwwt contwwwt, or fixed label(namevar=study)

#Draw figures
#Figure 2
metan9 casett conttt casewwwt contwwwt, or fixed by(subgroup) label(namevar = study)

#Figure 3
metan9 casewttt contwttt caseww contww, or fixed by(subgroup) label(namevar = study)

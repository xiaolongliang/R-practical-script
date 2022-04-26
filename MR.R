#MR exampel
# reference website: https://mrcieu.github.io/TwoSampleMR/articles/index.html
# library(devtools)
# devtools::install_github("MRCIEU/TwoSampleMR")
library(TwoSampleMR)

#list avaliable GWASs
ao <- available_outcomes()

#get instruments
exposure_dat <- extract_instruments("ieu-a-2")

#get effects of instruments on outcome
outcome_dat <- extract_outcome_data(snps = exposure_dat$SNP,outcomes = 'ieu-a-7')

#Harmonise the exposure and outcome data
dat <- harmonise_data(exposure_dat,outcome_dat)

#perform MR
res <- mr(dat)

# plot
##scatter plot
p1 <- mr_scatter_plot(res,dat)
p1

##Forest_plot
res_single <- mr_singlesnp(dat)
p2 <- mr_forest_plot(res_single)
p2

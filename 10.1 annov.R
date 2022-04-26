# R 多因素方差分析
# 李东来 
# https://www.math.pku.edu.cn/teachers/lidf/docs/Rbook/html/_Rbook/stat-aov.html?msclkid=673f7f03c4fd11ec99903515c8ece525
# 考虑维生素C对豚鼠的成牙质细胞生长的影响
# 因变量：牙齿长度 len； 自变量：两种不同的维生素C类型（ QJ和VC），三种剂量（0.5，1，2）
# 二元方差分析的问题是分别检验两个因素的主效应是否显著（不等于零）， 交互作用效应是否存在（不等于零）。

library(tidyverse)
data("ToothGrowth",package = "datasets")
d.tooth <- ToothGrowth |> mutate(supp = factor(supp,levels=c("OJ","VC")),       # |> 新管道符
                                 dose = factor(dose,levels = c(0.5,1.0,2.0)))

d.tooth |> count(supp,dose)
#   supp dose  n
# 1   OJ  0.5 10
# 2   OJ    1 10
# 3   OJ    2 10
# 4   VC  0.5 10
# 5   VC    1 10
# 6   VC    2 10

# 二元方差分析
aov.to1 <- aov(len~dose + supp + dose:supp,data = d.tooth)
summary(aov.to1)

#                Df Sum Sq Mean Sq F value   Pr(>F)    
#   dose         2 2426.4  1213.2  92.000  < 2e-16 ***
#   supp         1  205.4   205.4  15.572 0.000231 ***
#   dose:supp    2  108.3    54.2   4.107 0.021860 *  
#   Residuals   54  712.1    13.2                     
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# 在0.05水平下， 两个主效应和交互作用效应都显著。

# 交互作用作图
with(d.tooth,interaction.plot(dose,supp,len))

# 图形结果提示有交互作用效应











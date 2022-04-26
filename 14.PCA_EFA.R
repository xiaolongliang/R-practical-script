
#一、PCA分析

#install.packages("psych")
library(psych)
library(ggplot2)

#1.判断主成分的个数
fa.parallel(USJudgeRatings[,-1],fa="pc",n.iter = 100,show.legend = FALSE,main = "Scree plot with parallele analysis") #碎石图
##只保留一个主成分即可！

fa.parallel(Harman23.cor$cov,n.obs = 302,fa="pc",n.iter=100,show.legend = FALSE,main="scree plot with parallel analysis") #n.obs:包含多少观察值
##保留两个主成分

#2. 提取主成分
pc <- principal(USJudgeRatings[,-1],nfactors = 1) #nfactors:设定主成分数
pc

pc2 <- principal(Harman23.cor$cov,nfactors = 2,rotate = "none")
pc2

#3. 主成分旋转
rc <- principal(Harman23.cor$cov,nfactors = 2,rotate = "varimax") #"varimax":方差极大旋转（正交旋转）
rc

#4. 获取主成分得分
pc <- principal(USJudgeRatings[,-1],nfactors = 1,scores = TRUE) #每个观测在该主成分上的得分
head(pc$scores)

cor(USJudgeRatings$CONT,pc$scores)

##基于相关系数矩阵分析主成分时：可得到主成分得分的系数
rc <- principal(Harman23.cor$cov,nfactors = 2,rotate = "varimax")
round(unclass(rc$weights),2) #unclass():消除对象的类
##计算主成分得分


#二、探索性因子分析（EFA）
options(digits = 2)
covariances <- ability.cov$cov
correlations <- cov2cor(covariances) #将协方差矩阵转变成相关系数矩阵

#1.判断需提取的公共因子数
fa.parallel(correlations,n.obs = 112,fa="both",n.iter = 100,main = "Scree plots with parallel analysis")
##提取两个因子

#2.提取公共因子
fa<- fa(correlations,nfactors = 2,rotate="none",fm="pa") #fm:设定因子化方法，pa：主轴迭代法
fa

#3.因子旋转
fa.varimax <- fa(correlations,nfactors=2,rotate="varimax",fm="pa") #正交旋转
fa.varimax


#install.packages("GPArotation")
library(GPArotation)
fa.promax <- fa(correlations,nfactors=2,rotate="promax",fm="pa")  #斜交旋转提取因子
fa.promax


#可视化
factor.plot(fa.promax,labels = rownames(fa.promax$loadings))
fa.diagram(fa.promax,simple = FALSE)




















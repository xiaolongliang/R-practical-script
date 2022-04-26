#1. 描述性统计分析

#summary()
myvars <- c("mpg","hp","wt")
head(mtcars[myvars])
summary(mtcars[myvars])

#sapply()函数：
#sapply(x,FUN,options) x为数据框/矩阵
mystats <- function(x,na.omit=FALSE){
  if (na.omit)
    x <- x[!is.na(x)]
  m <- mean(x)
  n <- length(x)
  s <- sd(x)
  skew <- sum((x-m)^3/s^3)/n
  kurt <- sum((x-m)^4/s^4)/n-1
  return(c(n=n,mean=m,stdev=s,skew=skew,kurtosis=kurt))
}

sapply(mtcars[myvars], mystats)

#分组计算描述性统计量

#aggregate函数
aggregate(mtcars[myvars],by=list(am=mtcars$am),mean) #am=mtcars$am:给分组列赋予列名
aggregate(mtcars[myvars],by=list(am=mtcars$am),sd)

#by()
#by(data,INDICES,FUN): data：数据框或矩阵；INDICES：一个因子或因子组成的列表，定义了分组。
dstats <- function(x)sapply(x, mystats)
by(mtcars[myvars],mtcars$am,dstats)

#doBy包中的summaryBy()函数
smmaryBy(formula,data=dataframe,FUN)
#formature格式：
#var1+var2+var3+...+varN ~ groupvar1+groupvar2+...+groupvarN:~左边的变量是需要分析的数值型变量，右边的是类别型的分组变量
#install.packages("doBy")
library(doBy)
summaryBy(mpg+hp+wt~am,data = mtcars,FUN = mystats)

#psych包中的describeBy()函数

#2. 频数表和列联表
library(vcd)
head(Arthritis)

#一维列联表
mytable <- with(Arthritis,table(Improved)) #table()函数生成简单的频数统计表  
#table(Arthritis$Improved)
mytable
prop.table(mytable) #将频数转化成比例值
prop.table(mytable)*100 #转化为百分比

#二维列联表
##table()
mytable <- table(Arthritis$Treatment,Arthritis$Improved)

##xtabs()函数
##xtabs(~ A+B,data = mydata) : mydata为矩阵或数据框；要交叉分类的变量出现在~的右侧
mytable <- xtabs(~ Treatment+Improved,data = Arthritis)
#使用margin.table()函数和prop.table()函数分别生成边际频数和比例
#行与行比例
margin.table(mytable,1) #Treatment变量的一维列联表
prop.table(mytable,1)
#列与列比例
margin.table(mytable,2)
prop.table(mytable,2)















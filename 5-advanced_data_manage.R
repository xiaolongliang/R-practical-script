
#重复和循环
##1. for循环
for (i in 1:10) print("hello")

##2. while循环
i <- 10
while (i >0) {print("hello"); i<- i-1}

#条件执行
##1. if-else结构
if (is.character(grade)) grade <- as.factor(grade)
if (!is.character(grade)) grade <- as.factor(grade) else print("grade already is a factor")

##2. ifelse结构
#ifelse(cond,statement1,statement2) 若cond为TRUE，则执行第一个语句；若为FALSE，则执行第二个语句
ifelse(score > 0.5, print("passed"),print("failed"))
outcome <- ifelse(score > 0.5,"passed","failed")

##3. switch结构
#switch根据一个表达式的值选择语句执行
feeling <- c("sad","afraid")
for (i in feeling)
  print(
    switch (i,
      happy = "i am glad you are happy",
      afraid = "there is nothing to fear",
      sad = "cheer up",
      angry="calm down now"
    )
  )


#用户自定义函数
#function_name<-function(arg,arg,...){expr}
#function_name为函数名；arg为形参；expr为函数体

##1. 
mystats <- function(x,parametric=TRUE,print=FALSE) {
  if (parametric) {
    center <- mean(x);spread <- sd(x)
  } else {
    cemter <- median(x);spread <- mad(x)
  }
  if (print & parametric) {
    cat("mean=",center,"\n","sd=",spread,"\n")
  } else if (print & !parametric) {
    cat("media=",center,"\n","mad=",spread,"\n")
  }
  result <- list(center=center,spread=spread)
  return(result)
}

set.seed(1234)
x <- rnorm(500)
y <- mystats(x)
y <- mystats(x,parametric = FALSE,print = TRUE)

##2. 编制一个函数计算1^3+2^3+3^3+...+n^3
func <- function(n){
  s <- 0
  for (i in 1:n) s <- s + i^3
  s #最后一行的值为输出值
  }
s <- func(100)

#整合（aggregate）和重塑（reshape）

##1). 转置：t()
cars <- mtcars[1:5,1:4]
t(cars)

##2). 整合数据 
##aggregate(x,by,FUN):x为待折叠的数据对象，by是一个变量名组成的列表（即使只有一个变量也要放在列表中），这些变量将被去掉以形成新的观测
##FUN则是用来计算描述性统计量的标量函数，它将被用来计算新观测中的值。

options(digits = 3)
attach(mtcars) #attach,detach和with函数
aggdata <- aggregate(mtcars,by=list(cyl,gear),FUN = mean,na.rm=TRUE)
aggdata
#Group.1 Group.2  mpg cyl disp  hp drat   wt qsec  vs   am gear carb
#1       4       3 21.5   4  120  97 3.70 2.46 20.0 1.0 0.00    3 1.00
#当cy1为4，gear为3时各统计量的平均值

aggdata1 <- aggregate(mtcars$mpg,by=list(cyl),FUN=mean)

#  Group.1        x
#1       4 26.66364  #当cy1为4时，mpg的均值！
#2       6 19.74286
#3       8 15.10000


##3）reshape2包：重构和整合数据集额绝妙的万能工具
#install.packages("reshape2")
library(reshape2)

ID <- c(1,1,2,2)
Time <- c(1,2,1,2)
X1 <- c(5,3,6,2)
X2 <-c(6,5,1,4)
mydata <- data.frame(ID,Time,X1,X2)

#融合数据（melt）
md <- melt(mydata,id=c("ID","Time"),measure=c("X1","X2"))

#展开数据 dcast()
##展开colvar:标识变量~variable
dcast(md,ID+Time~variable)

##对观测变量进行聚合运算
dcast(md,ID~variable,mean)

##添加总计列
dcast(md,ID~variable,mean,margins = c("ID","variable"))





#class(mtcars) #查看数据结构
#dim(mtcars) #查看数据维度
#table(mtcars$cyl)













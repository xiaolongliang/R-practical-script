# 一.函数的定义
#函数名 <- function(形式参数表) 函数体


#例1
f <- function(){
  x <- seq(0,2*pi,length=50)
  y1 <- sin(x)
  y2 <- cos(x)
  plot(x,y1,type = "l",lwd=2,col="red",xlab = "x",ylab = "y")
  lines(x,y2,lwd=2,col="blue")
  abline(h=0,col="gray")
}

f()


#例2
f <- function(x) 1/sqrt(1+x^2)
f(0)
f(c(-1,0,1,2))   #R函数参数是一个向量

#函数实参是向量时， 函数体中也可以计算对向量元素进行汇总统计
#例3
skewness <- function(x){
  n <- length(x)
  xbar <- mean(x)
  S <- sd(x)
  n/(n-1)/(n-2)*sum((x-xbar)^3) / S^3  #函数体的最后一个表达式是函数返回值
}


#x, y是形式参数,其中y指定了缺省值为0,有缺省值的形式参数在调用时可以省略对应的实参,省略时取缺省值
fsub <- function(x,y=0){
  cat("x=",x,"y=",y,"\n")
  x-y
}

fsub(1)

#函数三要素
body(fsub)
environment(fsub)
formals(fsub)


# 二. 函数的调用

##函数的复合调用
sin(sqrt(x))

x %>%
  sqrt() %>%
  sin()


sum(sqrt(seq(a, b)))

a %>%
  seq(to=b) %>%
  sqrt() %>%
  sum()


#递归调用： 在函数内调用自己叫做递归调用

fib1 <- function(n){
  if(n==0) return(0)
  else if(n==1) return(1)
  else if(n>=2){
    Recall(n-1) + Recall(n-2)
  }
}

for (i in 0:10) cat("i=",i,"x[i]=",fib1(i),"\n")

# 三. 向量化  Vectorize()

g <- function(x){
  if(abs(x) <= 1){
    y <- x^2
  } else {
    y <- 1
  }
  
  return(y)
}

gv <- Vectorize(g) ##!
gv(c(-2, -0.5, 0, 0.5, 1, 1.5))




gv <- function(x){
  ifelse(abs(x) <= 1,x^2,1)
}


gv <- function(x){
  y <- numeric(length(x))
  for (i in seq(along=x)) {
    if(abs(x[i]) <= 1){
      y[i] <- x[i]^2
    } else {
      y[i] <- 1
    }
  }
  
  y
}

gv(c(-2, -0.5, 0, 0.5, 1, 1.5))


# 四.无名函数
vapply(iris[,1:4], function(x) max(x) - min(x), 0.0)

d <- scale(Filter(function(x) is.numeric(x),iris))  #Filter删选出iris数据框中的数值型列（即前4列）， 然后对这些列进行标准化（减去列均值、除以列标准差）， 保存到变量d中
integrate(function(x) sin(x)^2,0,pi)



# 五. 全局变量和局部变量
#在命令行定义了全局变量xv, xl, 然后作为函数f()的自变量值（实参）输入到函数中， 函数中对两个形式参数作了修改， 函数结束后实参变量xv, xl并未被修改，形参变量也消失了

xv <- c(1,2,3)
xl <- list(a=11:15,b="James")
if(exists('x')) rm(x)
f <- function(x,y){
  cat("输入的 x=",x,"\n")
  x[2] <- -1
  cat("函数中修改后的x=",x,"\n")
  cat("输入的y为:\n");print(y)
  y[[2]] <- "Mary"
  cat("函数中修改过的y为:\n");print(y)
}

f(xv,xl)

cat("函数运行完毕后原来变量xv不变:",xv,"\n")
cat("函数运行完毕后原来变量xl不变:\n");print(xl)
cat("函数运行完后形式参数x不存在:\n");print(x)


#修改自变量
#为了修改某个自变量， 在函数内修改其值并将其作为函数返回值， 赋值给原变量。
f <- function(x,inc=1){
  x <- x + inc
  x
}

x <- 100
cat("原始 x= ",x,"\n")

x <- f(x)
cat("修改后 x=",x,"\n")


#函数内的局部变量
#在函数内部用赋值定义的变量都是局部变量，即使在工作空间中有同名的变量，此变量在函数内部被赋值时就变成了局部变量，原来的全局变量不能被修改。这种规则称为掩藏(masking)
#局部变量在函数运行结束后就会消失。


if("x" %in% ls()) rm(x)  #ls()查看工作空间内所有变量
f  <- function(){
  x <- 123
  cat("函数内:x=",x,"\n")
}
f()
cat("函数运行完后:x=",x,"\n")

#在函数内部访问全局变量
#函数内部可以读取全局变量的值，但一般不能修改全局变量的值

#在命令行定义了全局变量x.g， 在函数f()读取了全局变量的值， 但是在函数内给这样的变量赋值， 结果得到的变量就变成了局部变量， 全局变量本身不被修改
x.g <- 9999
f <- function(x){
  cat("函数内读取：全局变量 x.g=",x.g,"\n")
  x.g <- -1
  cat("函数内对与全局变量同名的变量赋值: x.g=",x.g,"\n")
  }
f()

cat("退出函数后原来的全局变量不变： x.g =", x.g, "\n")



#在函数内部如果要修改全局变量的值，用 <<-代替<-进行赋值

x.g <- 9999
f <- function(x){
  cat("函数内读取：全局变量 x.g=",x.g,"\n")
  x.g <<- -1
  cat("函数内用"<<-"对全局变量变量赋值: x.g=",x.g,"\n")
} 
f()

cat("退出函数后原来的全局变量被修改了： x.g =", x.g, "\n")










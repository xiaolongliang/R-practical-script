
# 1. 复合表达式
{
  x <- 15
  x
}


# 2. 分支结构
'''
if(条件)表达式1
if(条件)表达式1 else 表达式2
其中的“条件”为一个标量的真或假值, 不允许取缺失值， 表达式可以是用大括号包围的复合表达式
'''

#example 1:
if(is.na(lambda)) lambda <- 0.5

#example 2:
if(x>1){
  y <- 2.5
} else{
  y <- -y
}

#example 3:
x <- c(0.05, 0.6, 0.3, 0.9)
for(i in seq(along=x)){
  if(x[i] <= 0.2){
    cat("Small\n")
  } else if(x[i] <= 0.8){
    cat("Medium\n")
  } else {
    cat("Large\n")
  }
}

# 2.1 用逻辑下标代替分支结构
#x为一个向量，要定义y与x等长， 且y的每一个元素当且仅当x的对应元素为正数时等于1， 否则等于零
y <- numeric(length(x))
y[x>0] <- 1


# 2.2 ifelse函数

x <- c(-2,0,1)
y <- ifelse(x >=0, 1, 0)

"""
函数ifelse(test, yes, no)中的test是逻辑向量， yes和no是向量， test、yes和no的配合符合向量化原则， 
如果有长度为1的或者长度较短但其倍数等于最长一个的长度的， 短的一个自动从头循环使用
"""

ifelse((1:6) >= 3,1:2,c(-1,-2))



# 3. 循环结构
# 3.1 计数循环
"""
为了对向量每个元素、矩阵每行、矩阵每列循环处理，语法为
for(循环变量 in 序列) 语句
其中的语句一般是复合语句
"""
#example 1:
set.seed(101); x<- rnorm(5)  #rnorm(5)会生成5个标准正态分布随机数
y <- numeric(length(x))      #numeric(n)生成有n个0的数值型向量（基础类型为double）
for (i in seq(5)) {
  if(x[i] >=0) y[i] <- 1 else y[i] <- 0
    
}
print(y)


#在R中应尽量避免for循环： 其速度比向量化版本慢一个数量级以上， 而且写出的程序不够典雅
set.seed(101); x<- rnorm(5) 
y <- ifelse(x >= 0,1,0)
print(y)


#example 2:
x <- 0.0; s <- 0; n <- 5
for (i in 1:n) {
  x <- 2*x + 1
  s <- s + x
}
print(s)


"""
使用for循环的注意事项：

1. 如果对向量每个元素遍历并保存结果， 应在循环之前先将结果变量产生等长的存储， 在循环内为已经分配好存储空间的输出向量的元素赋值。 
为了产生长度为n的数值型向量，用numeric(n)； 为了产生长度为n的列表，用vector("list", n)。
2. 对一个向量元素遍历时如果用下标访问， 需要用seq_along(x)的做法而不是1:length(x)的做法。
3. 如果直接对向量元素遍历， 这有可能会丢失向量的属性（如日期型）， 用下标访问则不存在此问题。
"""
#example 3:
x <- as.POSIXct(c("1981-05-31", "2020-02-22"))
for (xi in x) {print(xi)}

for (i in seq_along(x)) {print(x[i])}


# 3.2 while循环和repeat循环

"""
while(循环继续条件) 语句
进行当型循环。 其中的语句一般是复合语句。 仅当条件成立时才继续循环， 而且如果第一次条件就已经不成立就一次也不执行循环内的语句。

repeat 语句
进行无条件循环（一般在循环体内用if与break退出）。 其中的语句一般是复合语句。 如下的写法可以制作一个直到型循环：

repeat{
  ...
  if(循环退出条件) break
}

直到型循环至少执行一次， 每次先执行...代表的循环体语句， 然后判断是否满足循环退出条件， 满足条件就退出循环。
"""

# 4. R中判断条件
## if语句和while语句中用到条件。 条件必须是标量值， 而且必须为TRUE或FALSE， 不能为NA或零长度


# 5. 管道控制



















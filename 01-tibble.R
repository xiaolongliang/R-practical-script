#http://blog.fens.me/r-tibble/
  
#tidyverse -- tibble
library(tidyverse)

#1.创建
t1 <- tibble(1:10,b=LETTERS[1:10]);t1      #tibble()
d1 <- data.frame(1:10,b=LETTERS[1:10]);d1  #data.frame()

class(t1)
class(d1)
#is.tibble(t1)
is_tibble(t1)
attributes(t1)
str(t1)


tibble(letters)
tibble(data.frame(1:5))
tibble(x=list(diag(1),diag(2)))


# 2.convertion

d1 <- data.frame(1:5,b=LETTERS[1:5]);d1
d2 <- as_tibble(d1);d2  #data.frame to tibble
as.data.frame(d1);d2 #tibble to data.frame

x <- as.tibble(1:5);x
as.vector(x) # 把一个vector转型为tibble类型，但是不能再转回vector了。

df <- as.tibble(list(x=1:500,y=runif(500),z=500:1));df  #runif() 生成均匀分布随机数的函数
as.list(df)
str(as.list(df))

m <- matrix(rnorm(15),ncol = 5)
df <- as_tibble(m);df
as.matrix(df)

# 3.数据查询

#比较glimpse()和str()对于data.frame的数据查看输出
glimpse(mtcars)
str(mtcars)

#比较glimpse()和str()对于tibble的数据查看输出。
df <- tibble(x=rnorm(500),y=rep(LETTERS[1:25],20)) #rep:repeat
glimpse(df)
str(df)









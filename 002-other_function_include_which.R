
### which()函数
#用法 which(test)。
#返回test为真值的位置（指针）

x <- c(1,1,1,0,0,1,1)
which(x!=1)  #返回x中不等于1的变量值得位置
which(x>0)

which(c(T,F,T))  #返回c(T,F,T)中为TURE值的位置。

a = data.frame(x=1:10,y=rnorm(10),z=letters[1:10])
which(a$x >5)
#[1]  6  7  8  9 10
> which(a$y > 0)
[1] 1 4 6 8 9

#df条件选值
1) a[which(a$x > 5),]
2) a[6:10,]
3) subset(a,x>5)
> a[which(a$y > 0),]

4) library(dplyr)
   filter(a,x>5)

   
   
   
###2020-10-16 补充 数据框筛选
## 1. which筛选

iris[which(iris$Sepal.Width == 2),] %>% head()
iris[which(iris$Species == 'setosa'),] %>% head()

iris[order(iris$Sepal.Width),] %>% head()
##which与order格式很像！

## 2. 多条件筛选
iris[which((iris$Species == 'setosa') | (iris$Species == 'virginica')),]
iris[which(iris$Species %in% c('setosa','virginica')),]  #** %in% 操作符，a %in% b 将生成一个与a长度相同的logical序列，依次判断a中的元素是否被包含在b中

## 3. 不用which
iris[iris$Sepal.Width== 2, ]
iris[iris$Sepal.Width> 4, ]
iris[iris$Species== 'setosa', ]
iris[(iris$Species == 'setosa') | (iris$Species == 'virginica'),]
iris[iris$Species %in% c('setosa', 'virginica'),]

## 4. filter() 重点掌握！
library(dplyr)
filter(iris,Sepal.Width == 2)
filter(iris,Sepal.Width > 4)
filter(iris,Species == 'setosa')
filter(iris,Species %in% c('setosa', 'virginica'))

## 5. subset()



###分类汇总
## 1. aggregate()  by:分类依据，必须是list形式
aggregate(x=iris$Sepal.Width, by=list(iris$Species),FUN=mean)

## 2. split()函数和sapply()函数
> a <- split(iris$Sepal.Width,iris$Species)
> sapply(a, mean)

## 3. 




















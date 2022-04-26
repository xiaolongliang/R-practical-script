
# R中用因子代表数据中分类变量, 如性别、省份、职业
# 有序因子代表有序量度，如打分结果，疾病严重程度等

# 用factor()函数把字符型向量转换成因子
x <- c("男", "女", "男", "男",  "女")
sex <- factor(x)

attributes(sex)
levels(sex)

# read.csv()函数的默认操作会把输入文件的字符型列自动转换成因子,
# 在read.csv()调用中经常加选项stringsAsFactors=FALSE选项禁止这样的自动转换

# 用as.numeric()可以把因子转换为纯粹的整数值
as.numeric(sex)

# as.character()可以把因子转换成原来的字符型
as.character(sex)


#为了对因子执行字符型操作(如取子串),保险的做法是先用as.character()函数强制转换为字符型

#factor()函数(重点！)
factor(x, levels = sort(unique(x), na.last = TRUE), 
       labels, exclude = NA, ordered = FALSE)

#合并因子
li1 <- factor(c("man","women"))
li2 <- factor(c("man","man"))
c(li1,li2) #结果不是因子
factor(c(as.character(li1),as.character(li2)))


#table()
#用table()函数统计因子各水平的出现次数（称为频数或频率）。 也可以对一般的向量统计每个不同元素的出现次数
table(sex)

#tapply()
#可以按照因子分组然后每组计算另一变量的概括统计
h <- c(165, 170, 168, 172, 159)
tapply(h, sex, mean)

#这里第一自变量h与与第二自变量sex是等长的， 对应元素分别为同一人的身高和性别， tapply()函数分男女两组计算了身高平均值。


# forcats包的因子函数
#forcats::fct_reorder()可以根据不同因子水平分成的组中另一数值型变量的统计量值排序
library(forcats)

set.seed(1)
fac <- sample(c("red","green","blue"),30,replace = TRUE)
fac <- factor(fac,levels = c("red","green","blue"))
x <- round(100*(10+rt(30,2)))
res1 <- tapply(x, fac, sd);res1
barplot(res1)

#如果希望按照统计量次序对因子排序， 可以用forcats::fct_reorder()函数
fac2 <- fct_reorder(fac,x,sd)
res2 <- tapply(x, fac2, sd)
barplot(res2)















## dplyr包学习
# https://blog.csdn.net/wltom1985/article/details/54973811

"""
R包dplyr可用于处理R内部或者外部的结构化数据，相较于plyr包，dplyr专注接受dataframe对象, 
大幅提高了速度,并且提供了更稳健的数据库接口。同时，dplyr包可用于操作Spark的dataframe。
"""
# 1. 数据集类型转换  tbl_df(data)
## tbl_df()可用于将过长过大的数据集转换为显示更友好的 tbl_df 类型。使用dplyr包处理数据前，建议先将数据集转换为tbl对象。

library(dplyr)
class(mtcars)
ds <- tbl_df(mtcars)    #转换为tbl_df类型
df <- as.data.frame(ds) #转换为data.frame类型

# 2. 筛选
'''
filter() 和slice()函数可以按给定的逻辑条件筛选出符合要求的子数据集, 类似于 base::subset() 函数，
但代码更加简洁, 同时也支持对同一对象的任意个条件组合（表示AND时要使用&或者直接使用逗号），
返回与.data相同类型的对象。原数据集行名称会被过滤掉。
'''

filter(mtcars,cyl==8) #过滤出cyl == 8的行
filter(mtcars,cyl<6)
filter(mtcars,cyl<6 & vs==1) #过滤出cyl < 6 并且 vs == 1的行
filter(mtcars,cyl<6,vs==1)   #同上
filter(mtcars,cyl<6 | vs==1) #过滤出cyl < 6 或 vs == 1的行
filter(mtcars,cyl %in% c(4,6))  #过滤出cyl 为4或6的行
## 与subset()函数基本一致！  

#slice() 函数通过行号选取数据。
slice(mtcars,1L)      #选取第一行数据
filter(mtcars,row_number() == 1L) #同上
slice(mtcars,n())     #选取最后一行数据
filter(mtcars,row_number() == n()) #同上
slice(mtcars,5:n())   #选取第5行到最后一行所有数据
filter(mtcars,between(row_number(),5,n())) #同上


# 3. 排列 arrange
"""
arrange()按给定的列名依次对行进行排序，类似于base::order()函数。默认是按照升序排序，
对列名加 desc() 可实现倒序排序。原数据集行名称会被过滤掉。
"""

arrange(mtcars,cyl,disp) #以cyl和disp联合升序排序
##mtcars[order(mtcars$cyl,mtcars$disp),]
arrange(mtcars,desc(disp)) #以disp降序排序   #arrange(mtcars,-disp)
##mtcars[order(-mtcars$disp),]

# 4. 选择 select
"""
select()用列名作参数来选择子数据集。dplyr包中提供了些特殊功能的函数与select函数结合使用， 
用于筛选变量，包括starts_with，ends_with，contains，matches，one_of，num_range和everything等。
用于重命名时，select()只保留参数中给定的列，rename()保留所有的列，只对给定的列重新命名。原数据集行名称会被过滤掉。
"""

iris <- tbl_df(iris)

select(iris,starts_with("Petal")) #选取变量名前缀包含Petal的列
select(iris,-starts_with("Petal")) #选取变量名前缀不包含Petal的列
select(iris,ends_with("Width")) #选取变量名后缀包含Width的列
select(iris,-ends_with("Width")) #选取变量名后缀不包含Width的列
select(iris,contains("etal")) #选取变量名中包含etal的列
select(iris,-contains("etal")) #选取变量名中不包含etal的列
select(iris,matches(".t."))  #正则表达式匹配，返回变量名中包含t的列
select(iris,-matches(".t.")) #正则表达式匹配，返回变量名中不包含t的列
select(iris,Petal.Length,Petal.Width) #直接选取列
select(iris,-Petal.Length,-Petal.Width) #返回除Petal.Length和Petal.Width之外的所有列
select(iris,Sepal.Length:Petal.Width) #使用冒号连接列名，选择多个列

#选择字符向量中的列，select中不能直接使用字符向量筛选，需要使用one_of函数
vars <- c("Petal.Length", "Petal.Width")
select(iris,one_of(vars))
select(iris,-one_of(vars)) #返回指定字符向量之外的列

select(iris,everything()) #返回所有列，一般调整数据集中变量顺序时使用
select(iris,Species,everything()) #调整列顺序，把Species列放到最前面


df <- as.data.frame(matrix(runif(100),nrow = 10)) #runif() 生成均匀分布随机数的函数
df <- tbl_df(df[c(3, 4, 7, 1, 9, 8, 5, 2, 6, 10)])
#选择V4，V5，V6三列
select(df,V4:V6)
select(df,num_range("V",4:6)) 


#重命名列Petal.Length，返回子数据集只包含重命名的列
select(iris,petal_length=Petal.Length)
#重命名所有以Petal为前缀的列，返回子数据集只包含重命名的列
select(iris,petal=starts_with("Petal"))
#重命名列Petal.Length，返回全部列
rename(iris,petal_length=Petal.Length)


# 5. 变形 mutate
'''
mutate()和transmute()函数对已有列进行数据运算并添加为新列，类似于base::transform() 函数, 
不同的是可以在同一语句中对刚增添加的列进行操作。mutate()返回的结果集会保留原有变量，transmute()只返回扩展的新变量。
原数据集行名称会被过滤掉。
'''

#添加新列wt_kg和wt_t,在同一语句中可以使用刚添加的列
mutate(mtcars,wt_kg = wt*453.592,wt_t = wt_kg /1000)
#计算新列wt_kg和wt_t，返回对象中只包含新列
transmute(mtcars,wt_kg = wt*453.592,wt_t = wt_kg /1000)

# 6. 去重 distinct
"""
distinct()用于对输入的tbl进行去重，返回无重复的行，类似于 base::unique() 函数，但是处理速度更快。原数据集行名称会被过滤掉。
"""
df <- data.frame(
  x = sample(10,100,rep = TRUE),
  y = sample(10,100,rep = TRUE)
)
## sample: 从1-10中随机可重复抽样100次

#以全部两个变量去重，返回去重后的行数
nrow(distinct(df))
nrow(distinct(df,x,y)) #同上

#以变量x去重，只返回去重后的x值
distinct(df,x)

#以变量y去重，只返回去重后的y值
distinct(df, y)

#以变量x去重，返回所有变量
distinct(df, x, .keep_all = TRUE)

#以变量y去重，返回所有变量
distinct(df, y, .keep_all = TRUE)

#对变量运算后的结果去重
distinct(df, diff = abs(x - y))

# 7. 概括 summarise
##对数据框调用函数进行汇总操作, 返回一维的结果。返回多维结果时会报如下错误：
##Error: expecting result of length one, got : 2

#返回数据框中变量disp的均值
summarise(mtcars, mean(disp))
#返回数据框中变量disp的标准差
summarise(mtcars, sd(disp))
#返回数据框中变量disp的最大值及最小值
summarise(mtcars, max(disp), min(disp))
#返回数据框mtcars的行数
summarise(mtcars, n())
#返回unique的gear数
summarise(mtcars, n_distinct(gear))
#返回disp的第一个值
summarise(mtcars, first(disp))
#返回disp的最后个值
summarise(mtcars, last(disp))

# 8. 分组 group
##group_by()用于对数据集按照给定变量分组，返回分组后的数据集。对返回后的数据集使用以上介绍的函数时，会自动的对分组数据操作。
by_cyl <- group_by(mtcars,cyl) #使用变量cyl对mtcars分组，返回分组后数据集
filter(by_cyl,disp==max(disp)) #返回每个分组中最大disp所在的行
select(by_cyl,contains("d"))   #返回每个分组中变量名包含d的列，始终返回分组列cyl
arrange(by_cyl,mpg) #使用mpg对每个分组排序
sample_n(by_cyl,2)  #对每个分组无重复的取2行记录

summarise(by_cyl,n()) #返回每个分组的记录数
summarise(by_cyl,mean(disp),mean(hp)) #求每个分组中disp和hp的均值
summarise(by_cyl,n_distinct(gear)) #返回每个分组中唯一的gear的值
summarise(by_cyl,first(disp)) #返回每个分组第一个和最后一个disp值
summarise(by_cyl,last(disp))
summarise(by_cyl,min(disp)) #返回每个分组中最小的disp值
summarise(arrange(by_cyl,disp),min(disp))
summarise(by_cyl,nth(disp,2)) #返回每个分组中disp第二个值

groups(by_cyl) #获取分组数据集所使用的分组变量
groups(ungroup(by_cyl)) #ungroup从数据框中移除组合信息，因此返回的分组变量为NULL

group_size(by_cyl) #group_size用于返回每个分组的记录数
n_groups(by_cyl)  #n_groups返回分成的组数
table(mtcars$cyl)

group_indices(mtcars,cyl)







#例子1：
delays <- flights %>%
   group_by(dest) %>%
   summarise(count=n(), ##
             dist=mean(distance,na.rm = TRUE),
             delay=mean(arr_delay,na.rm = TRUE)
             ) %>%
   filter(count > 20,dest !="HNL")

#例子2：
# install.packages("Lahman")
library(Lahman)
batting <- as.tibble(Batting)
batters <- batting %>%
  group_by(playerID) %>%
  summarise(ba=sum(H,na.rm = TRUE) / sum(AB,na.rm = TRUE),
            ab = sum(AB,na.rm = TRUE))

batters %>%
  filter(ab > 100) %>%
  ggplot(mapping = aes(x=ab,y=ba)) + 
  geom_point() + 
  geom_smooth(se=FALSE)







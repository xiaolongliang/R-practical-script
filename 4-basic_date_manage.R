#第四章——基本数据管理

manager <- c(1,2,3,4,5)
date <- c("10/24/08","10/28/08","10/1/08","10/12/08","05/1/09")
country <- c("US","US","UK","UK","UK")
gender <- c("M","F","F","M","F")
age <- c(32,45,25,39,99)
q1 <- c(5,3,3,3,2)
q2 <- c(4,5,5,3,2)
q3 <- c(5,2,5,4,1)
q4 <- c(5,5,5,NA,2)
q5 <- c(5,5,2,NA,1)
leadership <- data.frame(manager,date,country,gender,age,
                         q1,q2,q3,q4,q5,stringsAsFactors = FALSE)
#重编码99为缺失值 NA
leadership$age[leadership$age == 99] <- NA
# 将连续性变量age重编码为类别变量。
leadership$age[leadership$age >75] <- "elder"
leadership$age[leadership$age >= 55 &leadership$age <= 75] <- "middle age"
leadership$age[leadership$age < 55] <- "young"

# 变量的重命名
names(leadership)[2] <- "testDate"
names(leadership)[6:10] <- c("item1","item2","item3","item4","item5")

#plyr包的rename函数用来修改变量名
#install.packages("plyr")
#library(plyr)
#leadership <- rename(leadership,c(manager="managerID",date="testDate"))

#缺失值
is.na(leadership[,6:10])
# NaN:不可能的值，is.nan()
# Inf -Inf:正负无穷 is.infinite()

#在分析中排除缺失值
x <- c(1,2,NA,3)
y <- sum(x,na.rm = TRUE)
#na.omit() 删除所有含有缺失数据的行
newdata <- na.omit(leadership)

#日期 page76
#as.Date(x,"input_format") 
mydata <- as.Date(c("2007-06-22","2004-02-13"))

strDates <- c("01/05/1954","08/16/1935")
dates <- as.Date(strDates,"%m/%d/%y")

myformat <- "%m/%d/%y"
leadership$testDate <- as.Date(leadership$testDate,myformat)

# 类型转换
a <- c(1,2,3)
is.numeric(a)
is.vector(a)
a <- as.character(a)
is.numeric(a)
is.vector(a)
is.character(a)

#数据排序
newdata <- leadership[order(leadership$age),] #升序
newdata <- leadership[order(-leadership$age),] #降序

## 将各行依女性到男性，同样性别中按年龄升序排序
attach(leadership)
newdata1 <- leadership[order(gender,age),]
detach(leadership)

attach(leadership)
newdata2 <- leadership[order(gender,-age),]
detach(leadership)

#newdata1[1:3] #选前三列
#newdata1[1:3,] # 选前三行
#newdata1[1:3,4:5] #选前三行，4-5列

# 数据集的合并
## 横向合并两个数据框
total <- merge(datafameA,dataframeB,by="ID")
total <- merge(datafameA,dataframeB,by=c("ID1","ID2"))
## 纵向合并两个数据框
total <- rbind(dataframeA,dataframeB) #两个数据框必须拥有相同的变量，顺序不一定相同

#数据集取子集
##数据框中列（变量）和行（观测）
##元素访问 dataframe[row,column]

##选入（保留）变量
newdata <- leadership[,c(6:10)] #行下标留空（,）表示默认选择所有的行
#newdata <- leadership[,6:10]

#myvars <- paste("q",1:5,sep = "")  #"q1" "q2" "q3" "q4" "q5"
#newdata <- leadership[myvars]

##剔除（丢弃）变量   page81
##剔除变量q3和q4
myvars <- names(leadership) %in% c("q3","q4")  #names(leadership):生成包含所有变量名的字符型向量，names(leadership) %in% c("q3","q4")：返回一个逻辑型向量，names(leadership)中每个匹配Q3或Q4的元素的值为True
newdata <- leadership[!myvars] # 非（!）将逻辑值翻转
#newdata <- leadership[c(-8,-9)] 在知道q3 q4是第八行和第九行的情况下

leadership$q3 <- leadership$q4 <- NULL #将q3 q4两列设定了未定义（NULL），NULL和NA（缺失）是不同的。


##选入观测（行操作）
newdata <- leadership[1:3,] #选择前三行
newdata <- leadership[leadership$gender=="M" & leadership$age >30,] #选择30岁以上的男性

#attach(leadership)
#newdata <- leadership[gender == "M" & age >30,]
#detach(leadership)

#研究范围限定在2009-01-01到2009-10-31：
leadership$date <- as.Date(leadership$date,"%m/%d/%y")
startdata <- as.Date("2009-01-01")
enddata <- as.Date("2009-10-31")
newdata <- leadership[which(leadership$date >= startdata & leadership$date <= enddata),]

## subset函数：解放生产力
newdata <- subset(leadership,age >= 35 | age < 24, select = c(q1,q2,q3,q4)) #选择所有age大于等于35或age小于24的行，保留了q1到q4
newdata <- subset(leadership,gender=="M" & age > 25, select = gender:q4) #选择所有25岁以上的男性，并保留了gender到q4





#NULL：未定义
#NA：缺失
#NaN:不可能的值（not a number）
#which函数


























#6-基本绘图

#6.1 条形图：展示类别型变量的分布（频数）
#barplot(height):height是一个向量或一个矩阵

##install.packages("vcd")
library(vcd)
counts <- table(Arthritis$Improved) #table:统计频数
counts

#6.1.1 简单的条形图：若height是一个向量
##简单条形图
barplot(counts,
        main = "simple bar plot",
        xlab = "improvement",ylab = "frequency")
##水平条形图
barplot(counts,
        main = "horizontal bar plot",
        xlab = "frequency",ylab = "improvenment",
        horiz = TRUE)
##main:添加图形标题；xlab和ylab分别添加x轴和y轴标签；horiz = TRUE生成水平条形图

#6.1.2 堆砌条形图和分组条形图:若height是一个矩阵而不是一个向量

counts <- table(Arthritis$Improved,Arthritis$Treatment)
counts
## 堆砌条形图
## beside=FALSE(默认)，矩阵中的每一列都生成图中的一个条形，各列中的值将堆砌成子条
barplot(counts,
        main = "stacked bar plot",
        xlab = "treatment",ylab = "frequency",
        col = c("red","yellow","green"),
        legend = rownames(counts))

## 分组条形图
## beside=TRUE，矩阵中的每一列都表示一个分组，各列中的值将并列而不是堆砌
barplot(counts,
        main = "grouped bar plot",
        xlab = "treatment",ylab = "frequency",
        col = c("red","yellow","green"),
        legend = rownames(counts),beside = TRUE)
##legend.txt参数为图例提供了各条形的标签

#6.1.3 均值条形图
states <- data.frame(state.region,state.x77)
head(states)
means <- aggregate(states$Illiteracy,by=list(state.region),FUN=mean) #aggregate:整合数据（5）
means <- means[order(means$x),] #将均值从小到大排序
barplot(means$x,names.arg = means$Group.1) #names.arg = means$Group.1为了展示标签
title("mean Illiteracy rate") #添加标题，与main选项是等价的

#6.1.4 条形图的微调
## par()函数让R德默认图形做出大量修改（第三章）
## cex.names:减小字号，将其指定为小于1的值可以缩小标签的大小
## names.arg允许指定一个字符向量作为条形的标签名

par(mar=c(5,8,4,2)) #增加y边界的大小
par(las=2)          #旋转条形的标签
counts <- table(Arthritis$Improved)
barplot(counts,
        main = "treatment outcome",
        horiz = TRUE,
        cex.names = 0.8, #缩小字体大小，让标签更适合
        names.arg = c("no improvement","some improvemnt","marked improvement")) #修改标签文本

#6.1.5 棘状图：spine()
## 棘状图对堆砌条形图进行了重缩放，每个条形的高度均为1，每一段的高度即表示比例
library(vcd)
attach(Arthritis)
counts <- table(Treatment,Improved)
spine(counts,main = "spinogram example")
detach(Arthritis)

# 6.3 直方图
##freq=FALSE:根据概率密度而不是频数绘制图形
##breads：用于控制组的数量
par(mfrow=c(2,2))
hist(mtcars$mpg)
hist(mtcars$mpg,breaks = 12,col = "red",xlab = "Miles per gallon",main = "colored histogram with 12 bins")

hist(mtcars$mpg,freq=FALSE,breaks = 12,col = "red",xlab = "Miles per gallon",main = "histogram,rug plot,density curve")
rug(jitter(mtcars$mpg))
lines(density(mtcars$mpg),col="blue",lwd=2)

x <- mtcars$mpg
h <- hist(x,
          breaks = 12,
          col = "red",
          xlab = "Miles per gallon",
          main = "histogram with normal curve and box")
xfit <- seq(min(x),max(x),length=40)
yfit <- dnrom(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit * diff(h$mids[1:2]) * length(x)
lines(xfit,yfit,col="blue",lwd=2)
box()


#6.5 箱线图
boxplot(mtcars$mpg,main="box plot",ylab="miles per gallon")

#boxplot(formula,data = dataframe)
#formula: 
#y~A:将为类别型变量A的每个值并列的生成数值型变量y的箱线图
#y~A*B:将为类别型变量A和B所有水平的两两组合生成数值型变量y的箱线图

mtcars
boxplot(mpg ~ cyl,data = mtcars,
        main = "car mileage data",
        xlab = "number of cylinders",
        ylab = "miles per callon")

boxplot(mpg~cyl,data = mtcars,
        notch=TRUE,       #得到含凹槽的箱线图
        varwidth=TRUE,    #使箱线图的宽度与其样本大小成正比
        col="red",
        main="car mileage data",
        xlab = "number of cylinders",
        ylab = "miles per gallon")

##多个分组因子绘制箱线图
mtcars$cyl.f <- factor(mtcars$cyl,levels = c(4,6,8),labels = c("4","6","8"))
mtcars$am.f <- factor(mtcars$am,levels = c(0,1),labels = c("auto","standard"))
boxplot(mpg ~ am.f*cyl.f,
        data = mtcars,
        varwidth=TRUE,
        col = c("gold","darkgreen"),
        main="MPG distribution by aotu type",
        xlab = "auto type",ylab = "miles per gallon")






#table（）函数
z <- c(1,2,2,4,2,7,1,1)
z1 <- table(z)
z1 
summary(z1)






























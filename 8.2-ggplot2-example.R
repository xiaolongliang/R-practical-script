
library(ggplot2)

#example 1
mtcars$am <- factor(mtcars$am,levels = c(0,1),labels = c("Automatic","Manual"))
mtcars$vs <- factor(mtcars$vs,levels = c(0,1),labels = c("V-engine","Straight engine"))
mtcars$cyl <- factor(mtcars$cyl)

p <- ggplot(mtcars,aes(x=hp,y=mpg,shape=cyl,color=cyl))
p + geom_point(size=3) + facet_grid(am~vs) + labs(title="Automobile data by engine type",x="horsepower",y="miles per gallon")

#example 2
data(singer,package="lattice")
ggplot(singer,aes(x=height)) + geom_histogram() #直方图
ggplot(singer,aes(x=voice.part,y=height)) + geom_boxplot() #箱线图

#example 3
#install.packages("car")
library(car)
data("Salaries")
p <- ggplot(Salaries,aes(x=rank,y=salary))
p + geom_boxplot(fill="cornflowerblue",color="black",notch = TRUE) + #notch:方块图是否为缺口（缺口箱线图）
  geom_point(position = "jitter",color="blue",alpha=.5) +  #“jitter”：对于点图来说，减少点重叠
  geom_rug(side = 1,color="black") #geom_rug：地毯图，side=1表示地毯图的安置位置为左部

#example 4
p <- ggplot(singer,aes(x=voice.part,y=height))
p + geom_violin(fill="lightblue") + #小提琴图
  geom_boxplot(fill="lightgreen",width=.2)


#example 5   分组
ggplot(Salaries,aes(x=salary,fill=rank)) + geom_density(alpha=.3)

ggplot(Salaries,aes(x=yrs.since.phd,y=salary,color=rank,shape=sex)) + geom_point()

##三种条形图形式
ggplot(Salaries,aes(x=rank,fill=sex)) + geom_bar(position = "stack") + labs(title='position="stack"')
ggplot(Salaries,aes(x=rank,fill=sex)) + geom_bar(position = "dodge") + labs(title='position="dodge"')
ggplot(Salaries,aes(x=rank,fill=sex)) + geom_bar(position = "fill") + labs(title='position="fill"')


## 变量应该设在aes函数中，分配常量应该在aes函数外
ggplot(Salaries,aes(x=rank,fill=sex)) + geom_bar()
ggplot(Salaries,aes(x=rank)) + geom_bar(fill="red")
ggplot(Salaries,aes(x=rank,fill="red")) + geom_bar()


#example 6 刻面
data(singer,package = "lattice")
ggplot(singer,aes(x=height)) + geom_histogram() + facet_wrap(~voice.part,nrow = 4)

ggplot(Salaries,aes(x=yrs.since.phd,y=salary,color=rank,shape=rank)) + geom_point() + facet_grid(.~sex) #每个sex分组在同一行上
ggplot(Salaries,aes(x=yrs.since.phd,y=salary,color=rank,shape=rank)) + geom_point() + facet_grid(sex~.) #每个sex分组在同一列上

ggplot(singer,aes(x=height,fill=voice.part)) + geom_density() + facet_grid(voice.part~.) #密度曲线


#sample 7 添加光滑曲线
ggplot(Salaries,aes(x=yrs.since.phd,y=salary)) + geom_smooth() + geom_point()

ggplot(Salaries,aes(x=yrs.since.phd,y=salary,linetype=sex,shape=sex,color=sex)) + 
  geom_smooth(method = lm,formula = y~poly(x,2),se=FALSE,size=1) + #se=FALSE:去掉置信区间
  geom_point(size=2)


#sample 8 修改ggplot2图形外观

##8-1 改变坐标轴
p <- ggplot(Salaries,aes(x=rank,y=salary,fill=sex))
p + geom_boxplot() + 
  scale_x_discrete(breaks=c("AsstProf","AssocProf","Prof"),labels=c("Assistant\nProfessor","Associate\nProfessor","Full\nProfessor")) +  #离散变量
  scale_y_continuous(breaks = c(50000,100000,150000,200000),labels = c("$50k","$100k","$150k","$200k")) +       #连续变量
  labs(title = "faculty salary by rank and sex",x="",y="")

p <- ggplot(Salaries,aes(x=rank,y=salary,fill=sex))
p + geom_boxplot() 


##8-2 修改图例的标题及位置

p <- ggplot(Salaries,aes(x=rank,y=salary,fill=sex))
p + geom_boxplot() + 
  scale_x_discrete(breaks=c("AsstProf","AssocProf","Prof"),labels=c("Assistant\nProfessor","Associate\nProfessor","Full\nProfessor")) +  #离散变量
  scale_y_continuous(breaks = c(50000,100000,150000,200000),labels = c("$50k","$100k","$150k","$200k")) +       #连续变量
  labs(title = "faculty salary by rank and sex",x="",y="",fill="Gender") +  #labs(fill="mytitle") 修改图例的标题
  theme(legend.position = c(.1,.8)) #修改图例的位置，left,right,top,bottom,二元素向量等；legend.position = "none"：删除图例

##8-3 标尺
p <- ggplot(mtcars,aes(x=wt,y=mpg,size=disp)) #size=disp生成连续性变量disp的标尺
p + geom_point(shape=21,color="black",fill="cornsilk") + 
  labs(title="bubble chart",size="Engine\nDisplacement") #size=... 改变图例的标题


p <- ggplot(Salaries,aes(x=yrs.since.phd,y=salary,color=rank)) #离散型变量
p + scale_color_manual(values = c("orange","olivedrab","navy")) + #此函数来设定三个学术等级的点的颜色
  geom_point(size=2)

##8-4 修改主题
mytheme <- theme(plot.title = element_text(face = "bold.italic",size="14",color = "brown"), #图的标题为粗斜体的棕色14号字
                 axis.title = element_text(face="bold.italic",size=10,color="brown"), #轴标题
                 axis.text = element_text(face="bold",size=9,color = "darkblue"), #坐标轴标签为加粗的深蓝色9号字
                 panel.background = element_rect(fill="white",colour = "darkblue"), #画图区域有白色的填充和深蓝色的边框
                 panel.grid.major.y = element_line(color = "grey",linetype = 1), #主水平网格线为灰色的实线
                 panel.grid.minor.y = element_line(color = "grey",linetype = 2), #次水平网格线为灰色的虚线
                 panel.grid.minor.x = element_blank(), #垂直网格线不输出
                 legend.position = "top") #图例位置在顶部

ggplot(Salaries,aes(x=rank,y=salary,fill=sex)) + 
  geom_boxplot() + 
  labs(title = "salary by rank and sex",x="rank",y="salary") + 
  mytheme

##8-5 多重图：将多个ggplot2画出的图形放到单个图形中

#install.packages("gridExtra")
library(gridExtra)
p1 <- ggplot(Salaries,aes(x=rank)) + geom_bar()
p2 <- ggplot(Salaries,aes(x=sex)) + geom_bar()
p3 <- ggplot(Salaries,aes(x=yrs.since.phd,y=salary)) + geom_point()
grid.arrange(p1,p2,p3,ncol=3) ##
grid.arrange(p1,p2,p3,nrow=3) ##

##8-6 保存图像
myplot <- ggplot(mtcars,aes(x=mpg)) + geom_histogram()
ggsave(file="mygraph.png",plot = myplot,width = 5,height = 4)

print(myplot)




#install.packages("gcookbook")
install.packages("gapminder")
library(gcookbook)
library(ggplot2)
library(gapminder)


## 1.散点图
# 首先将图形所展现的数据输入到ggplot()函数中，然后调用某个geom_xxx()函数，指定图形类型，如散点图、曲线图、盒形图等。
p <- ggplot(data = gapminder,mapping = aes(x=gdpPercap,y=lifeExp))
p + geom_point()  #散点图
p + geom_smooth() #拟合曲线图
p + geom_point() + geom_smooth()
p + geom_point() + geom_smooth(method = "lm")

p+ geom_point() + geom_smooth(method = "gam") + 
  scale_x_log10()  #p + geom_point() + geom_smooth()

p+ geom_point() + geom_smooth(method = "gam") + 
  scale_x_log10(labels=scales::dollar) #scale_xxx()的labels选项指定如何标出坐标刻度数字


#颜色、符号和线型映射
p <- ggplot(gapminder,aes(x=gdpPercap,y=lifeExp,color=continent))
p + geom_point() + geom_smooth(method = "loess") + 
  scale_x_log10(labels=scales::dollar)


p <- ggplot(gapminder,aes(x=gdpPercap,y=lifeExp,color=continent,fill = continent))
p + geom_point() + geom_smooth(method = "loess") + 
  scale_x_log10(labels=scales::dollar)

#固定颜色
p <- ggplot(data = gapminder,mapping = aes(x=gdpPercap,y=lifeExp))
p + geom_point(color="chartreuse4") + geom_smooth(method = "loess") + 
  scale_x_log10(labels=scales::dollar)

#geom_xxx()函数接受许多关于颜色、透明度、符号、线型的设置参数

p + geom_point(alpha=0.5) + 
  geom_smooth(method = "lm",color="cadetblue1",se=FALSE,size=4,alpha=0.3) +  #se = FALSE关闭了置信区间显示
  scale_x_log10(labels=scales::dollar)

#画线时可以用linetype参数指定线型， 0表示实线， 1到6分别表示不同的虚线线型  
  
#labs()函数给图形加上适当的标题
##labs()规定了上方的标题、小标题， x轴、y轴的标题， 右下方的标注(caption)
p <- ggplot(gapminder,aes(x=gdpPercap,y=lifeExp))
p + geom_point(alpha=0.3) + 
  geom_smooth(method = "gam") + 
  scale_x_log10(labels=scales::dollar) + 
  labs(
    x = "人均GDP",
    y = "期望寿命（年数）",
    title = "economy increase and expected lift",
    subtitle = "数据点为每个国家每年",
    caption = "data souce:gapminder")


#图形保存

ggsave(filename="文件名.pdf", plot=ggout01,height=12, width=8, units="cm")
##在ggsave()中可以用scale =指定放大比例， 用height =指定高度， 用width =指定宽度，用units =指定高度和宽度的单位,单位可以是in, cm, mm。




## 2.折线图
p <- ggplot(gapminder,aes(year,lifeExp)) 
p + geom_line()

#仅绘制Rwanda这个国家的期望寿命时间序列
p <- ggplot(data=filter(gapminder,country == "Rwanda"),aes(year,lifeExp))
p + geom_line()

#画出每个点的散点符号
p + geom_line() + geom_point()

#eom_area()作类似图形，但在折线下方填充颜色
p <- ggplot(data=filter(gapminder,country == "Rwanda"),aes(year,lifeExp))
p + geom_area(fill="darkseagreen1",alpha=0.5)

#x坐标不是数值型变量而是因子或者字符型,则两点之间不会相连
d <- gapminder %>% filter(country == "Rwanda") %>% mutate(year=factor(year,levels = seq(1952,2007,by=5)))
p <- ggplot(d,aes(year,lifeExp))
p + geom_line()

#显式地指定group变量可以解决问题
p <- ggplot(data=d,aes(x=year,y=lifeExp,group=country))
p + geom_line()

#geom_line()函数中用color参数指定颜色，用linetype参数指定线型，用size参数指定以毫米为单位的粗细
p <- ggplot(data=d,aes(x=year,y=lifeExp,group=country))
p + geom_line(color="red",linetype="dotted",size=3)

#小图（facet）
p <- ggplot(data=gapminder,aes(x=year,y=lifeExp,group=country))
p + geom_line() + facet_wrap(~ continent)

#convert int to factor
d <- gapminder %>% filter(country="Rwanda") %>% mutate(year=factor(year,levels = seq(1952,2007,by=5)))

#facet
p <- ggplot(data = gapminder,aes(x=year,y=lifeExp,group=country))
p + geom_line() + facet_wrap(~continent)

p <- ggplot(data = gapminder,aes(x=year,y=lifeExp))
p + geom_line(aes(group=country),color="gray70") + geom_smooth(method = "loess",color="cyan",se=FALSE,size=1.1)+ 
  facet_wrap(~ continent,ncol=2) + 
  labs(x="年份",y="期望寿命",title = "五大洲各国期望寿命变化趋势")

#如果需要按照两个分类变量交叉分组分配小图,可以用facet_grid()函数
library(socviz)
p <- ggplot(data = gss_sm,mapping = aes(x=age,y=childs))
p + geom_point(alpha=0.2)
p + geom_point(alpha=0.2) + facet_grid(sex~race)
p + geom_point(alpha=0.2) + geom_smooth() + facet_grid(sex~race)



# 3. 数据转换与条形图

p <- ggplot(data = gss_sm,aes(x=bigregion))
p + geom_bar()

df1 <- gss_sm %>% select(bigregion) %>% count(bigregion) %>% mutate(ratio=n / sum(n))
p <- ggplot(data = df1,aes(x=bigregion,y=n))
p + geom_col() + labs(y="Count")

p <- ggplot(data = df1,aes(x=bigregion,y=ratio))
p + geom_col() + labs(y="ratio")

df2 <- gss_sm %>% select(religion) %>% count(religion)
p <- ggplot(data = df2,aes(x=religion,y=n,fill=religion))  #填充颜色 
p + geom_col() + labs(y="Count")
p + geom_col() + guides(fill=FALSE) + labs(y="Count") #guides(fill=FALSE)：去掉图注


df3 <- gss_sm %>%
  select(bigregion,religion) %>%
  group_by(bigregion,religion) %>%
  summarise(n=n()) %>%
  mutate(ratio=n/sum(n)) %>%
  ungroup()

p <- ggplot(df3,aes(x=bigregion,y=n,fill=religion))
p + geom_col()

p + geom_col(position = "fill") + labs(y=NULL)

p + geom_col(position = "dodge")

p <- ggplot(df3,aes(x=bigregion,y=ratio,fill=religion))
p + geom_col(position = "dodge")


p <- ggplot(df3,aes(x=religion,y=ratio,fill=religion))
p + geom_col(position = "dodge") +  #geom_col(position = "dodge"):并排条形图
  labs(x=NULL,y="比例") + 
  coord_flip() + 
  facet_grid(~bigregion) +  #小图，facet_wrap;facet_grid
  guides(fill=FALSE) #去掉图例


#titanic数据绘图
p <- ggplot(titanic,aes(x=fate,y=n,fill=sex))
p + geom_col(position = "dodge")

p <- ggplot(titanic,aes(x=sex,y=n,fill=fate))
p + geom_col(position = "dodge")
p + geom_col(position = "dodge") + theme(legend.position = "top") #用theme()函数的legend.position参数可以指定图例的位置
p + geom_col(position = "stack") #p + geom_col() 堆叠形式条形图



titanic2 <- as.data.frame(Titanic) %>% group_by(Class,Sex,Survived) %>% #as.data.frame将其转换为长表格式
  summarise(n=sum(Freq)) %>%
  filter(Class!="Crew") %>%
  mutate(Survived=factor(Survived,levels = c("Yes","No"),labels = c("survived","perished")))
p <- ggplot(titanic2,aes(x=Sex,y=n,fill=Sex))
p + geom_col() + facet_grid(Class~Survived) + guides(fill=FALSE)


# 4. 直方图
p <- ggplot(midwest,aes(x=area))
p + geom_histogram()
p + geom_histogram(bins = 15) #用bins参数控制分组数


midwest_sub <- midwest %>%
  filter(state %in% c("OH","WI"))
p <- ggplot(midwest_sub,aes(x=area,fill=state))
p + geom_histogram(bins=10)

p <- ggplot(midwest,aes(x=area)) #geom_density()可以对连续变量绘制密度估计曲线
p + geom_density()

p <- ggplot(midwest,aes(x=area,color=state,fill=state)) #fill:填充
p + geom_density(alpha=0.3)

p <- ggplot(midwest,aes(x=area,color=state)) #借助于geom_line(stat = "density")改成仅有多条曲线
p + geom_line(stat = "density")

# 将直方图与密度估计画在同一坐标系中
p <- ggplot(midwest,aes(x=area))
p + geom_histogram(aes(y=..density..),alpha=0.6) + geom_density(size=1.1)






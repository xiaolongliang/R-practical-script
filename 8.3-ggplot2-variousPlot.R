
library(tidyverse)
library(socviz)
data(organdata)

organdata %>% select(1:6) %>% sample_n(size = 10)
p <- ggplot(organdata,aes(x=year,y=donors))
p + geom_point()

#geom_line()
p <- ggplot(organdata,aes(x=year,y=donors,color=country))
p + geom_point() + geom_line()

#facet
p <- ggplot(organdata,aes(x=year,y=donors))
p + geom_line() + facet_wrap(~country,ncol = 4)

#geom_boxplot()
p <- ggplot(organdata,aes(y=donors,x=country))
p + geom_boxplot() + coord_flip()

#reorder()
p <- ggplot(organdata,aes(y=donors,x=reorder(country,donors,median,na.rm=TRUE)))
p + geom_boxplot() + coord_flip() + 
  labs(y="捐献率（单位：百万分之一）",x=NULL)

#fill;theme(legend.position="top")
p <- ggplot(organdata,aes(y=donors,x=reorder(country,donors,median,na.rm=TRUE),fill=world))
p + geom_boxplot() + coord_flip() + 
  labs(y="捐献率（单位：百万分之一）",x=NULL) + 
  theme(legend.position = "top")

#geom_point()
p <- ggplot(organdata,aes(y=donors,x=reorder(country,donors,median,na.rm=TRUE)))
p + geom_point(alpha=0.4) + coord_flip() + 
  labs(y="捐献率（单位：百万分之一）",x=NULL)

#alpha参数指定一定的透明度， 重叠越多的点显示的颜色越深。 但是， 如果两个不同颜色的点完全重叠， 半透明不能显示两个不同颜色的效果。
#为了避免重叠的点， 可以将geom_point()改为geom_jitter()
p <- ggplot(organdata,aes(y=donors,x=reorder(country,donors,median,na.rm=TRUE)))
p + geom_jitter(alpha=0.4) + coord_flip() + 
  labs(y="捐献率（单位：百万分之一）",x=NULL)

# 上图的点的扰动过大了， 使得不同国家的区分不明显了。 作扰动的散点图时， 可以用width指定左右扰动范围， 用height指定上下扰动范围， 
# 这里只需要指定左右扰动范围， 因为坐标轴对调所以就变成了上下扰动：
p <- ggplot(organdata,aes(y=donors,x=reorder(country,donors,median,na.rm=TRUE)))
p + geom_jitter(alpha=0.4,width = 0.2,height = 0) + coord_flip() + 
  labs(y="捐献率（单位：百万分之一）",x=NULL)


organdata %>% group_by(country) %>% summarize(donors_n = sum(!is.na(donors)), #计数，donors有几个非缺失的值
                                              donors_mean = mean(donors,na.rm = TRUE),
                                              donors_sd = sd(donors,na.rm = TRUE),
                                              donors_se = donors_sd / sqrt(donors_n)) -> organdata2

#geom_col()
ggplot(organdata2,aes(x=reorder(country,donors_mean),y=donors_mean)) + 
  geom_col() + coord_flip()

ggplot(organdata2,aes(x=donors_mean,y=reorder(country,donors_mean))) + 
  geom_point()


#geom_point   facet: scales = "free_y"
organdata %>% group_by(consent_law,country) %>% summarize(donors_n = sum(!is.na(donors)),
                                                          donors_mean = mean(donors,na.rm = TRUE),
                                                          donors_sd = sd(donors,na.rm = TRUE),
                                                          donors_se = donors_sd / sqrt(donors_n))  %>% ungroup() -> organdata3

ggplot(organdata3,aes(x=donors_mean,y=reorder(country,donors_mean),color=consent_law)) + 
  geom_point(size=3) + theme(legend.position = "top")

ggplot(organdata3,aes(x=donors_mean,y=reorder(country,donors_mean),color=consent_law)) + 
  geom_point(size=3) + theme(legend.position = "top") + facet_wrap(~consent_law,ncol = 1,scales = "free_y")


# 表示平均值的点图上增加一条线， 表示误差大小，所用函数为geom_pointrange()。 这个函数仅支持对y轴加误差线， 
# 所以需要用交换坐标轴的办法将分类变量放在y轴。 比如， 画出近似95%置信区间范围：
p <- ggplot(organdata3,aes(y=donors_mean,x=reorder(country,donors_mean))) 
p + geom_pointrange(aes(ymin=donors_mean - 1.96*donors_se,
                        ymax=donors_mean + 1.96*donors_se)) +
  coord_flip() + facet_wrap(~consent_law,ncol = 1,scales = "free_y") + 
  labs(x = NULL, y = "平均捐赠率(单位: 百万分之一)及95%置信区间")


#坐标系中的文字
library(gapminder)
data("gapminder")
gapminder %>% group_by(continent) %>% summarize(lifeExp = mean(lifeExp,na.rm = T),
                                                 gdpPercap = mean(gdpPercap)) -> gapminder2
p <- ggplot(gapminder2,aes(x=gdpPercap,y=lifeExp,label=continent))
p + geom_text()
p + geom_text() + geom_point(size=2,color="blue")

p <- ggplot(elections_historic,aes(x=popular_pct,y=ec_pct,label=winner_label))
p + geom_text()

library(ggrepel)
p + geom_text_repel()


``` {r,fig.width=20,fig.height=16}
p + geom_hline(yintercept = 0.5,size=1.4,color = "gray80") + #geom_hline(yintercept)添加横线， 
  geom_vline(xintercept = 0.5,size=1.4,color = "gray80") +  #用geom_vline(xintercept)添加竖线
  geom_point() + 
  geom_text_repel() + 
  scale_x_continuous(labels = scales::percent) + #用scale_x_continuous()和scale_y_continuous()将坐标轴的比例值转换成百分数，
  scale_y_continuous(labels = scales::percent) + 
  labs(x = "Winner's share of Popular Vote",
       y = "Winner's share of Electoral College Votes",
       title = "Presidential Elections: Popular & Electoral College Margins",
       subtitle = "1824-2016",  #次标题
       caption = "Data for 2016 are provisional.") #脚注
```

#标出特殊的点
organdata4 <- organdata %>% group_by(country) %>% summarize(donors_mean=mean(donors,na.rm = TRUE),gdp_mean = mean(gdp,na.rm = TRUE))
p <- ggplot(organdata4,aes(x=gdp_mean,y=donors_mean)) 
p + geom_point()

p + geom_point() + 
  geom_text(data = filter(organdata4,gdp_mean > 27500 | donors_mean > 25),
                             aes(label=country)) + 
  labs(
    x="平均GDP",
    y = "平均器官捐赠率(单位：百万分之一)"
  )

# 上面标的文字有超出边界的问题， 可以在geom_text()中加选项hjust = "inward":
library(ggrepel)
p + geom_point() +
  geom_text(data = subset(organdata4, gdp_mean > 27500 | donors_mean > 25),
            mapping = aes(label = country),
            hjust = "inward") +
  labs(x = "平均GDP", 
       y = "平均器官捐赠率(单位：百万分之一)")




















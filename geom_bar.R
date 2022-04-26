
library(tidyverse)
setwd("E:/R_code/work/")
data <- read.csv("deng.csv",header = TRUE)
colname <- paste(2011:2020,"年",sep="")
colnames(data) <- c("X",colname)
data %>% gather(key=attributes,value=value,2:11) -> data1

## 并排条形图
ggplot(data1,aes(x=attributes,y=value,fill=X)) + geom_bar(stat="identity",position="dodge") + #identity意味着把y当做值去输入，如果改成bin，就会计算y出现的频数。dodge意味是各组是左右分布而不是上下重叠
  labs(x="",y="",fill="") + #labs(fill="") 修改图例的标题为无 
  theme(legend.position = "bottom") + #图注位置
  geom_text(aes(label=paste(value)),angle=0,vjust=-0.2,position=position_dodge(0.9),size=5) + #在条形图中显示具体的数值，angle和vjust是调整角度和位置
  theme(axis.text.x = element_text(family = "Times",  size = rel(1.6))) + #修改X轴刻度字体
  theme(axis.text.y = element_text(family = "Times", size = rel(1.6))) + #修改Y轴刻度字体
  theme(legend.text = element_text(size = 16)) + #修改图注刻度字体
  theme(panel.grid.major=element_line(colour=NA)) #去掉网格线

# paste(data1$value):把数字变成字符串
ggsave(filename="plot.tiff",height = 10,width = 13,dpi = 300)


## 堆栈条形图
ggplot(data1,aes(x=attributes,y=value,fill=X,label=value)) + geom_bar(stat = "identity",position = "stack") + 
  labs(x="year",y="money",fill="") + 
  theme(legend.position = c(0.05,0.92)) + 
  geom_text(position=position_stack(vjust=0.5),size=4)+  #堆栈条形图上添加数字
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 1))+  #x轴标签倾斜90度
  theme(axis.text.x = element_text(family = "Times", face = "italic",colour = "darkred", size = rel(1.6))) #X轴标签文字设置
  # x轴标签字体设为叫times的系列，斜体，暗红色，1.6倍字体


## 设置主题
# element_text()：使用element_text()函数设置基于文本的组件，如title,subtitle 和caption等。
# element_line()：使用element_line()设置基于线的组件，如轴线，主网格线和次网格线等。
# element_rect()：使用element_rect()修改基于矩形的组件，如绘图区域和面板区域的背景。
# element_blank()：使用element_blank()关闭显示的主题内容

# vjust，控制标题（或标签）和绘图之间的垂直间距。
# hjust，控制水平间距。将其设置为0.5将标题居中。
# face，设置字体（“plain”，“italic”，“bold”，“bold.italic”）

# 主题：theme_grey()为默认主题，theme_bw()为白色背景主题，theme_classic()为经典主题。

# 删除主，次网格线，边框，轴标题，文本和刻度
# theme(panel.grid.major = element_blank(), #主网格线
#       panel.grid.minor = element_blank(), #次网格线
#       panel.border = element_blank(), #边框
#       axis.title = element_blank(),  #轴标题
#       axis.text = element_blank(), # 文本
#       axis.ticks = element_blank()) 


mytheme <- theme(plot.title = element_text(face = "bold",size="14",color = "brown",hjust = 0.5), #图的标题为粗斜体的棕色14号字,位置处于正中间（hjust）
                 plot.subtitle = element_text(size=13,face = "bold",color = "red",hjust = 0.5), #副标题
                 plot.caption = element_text(size = 10), #caption
                 axis.title = element_text(face="bold.italic",size=13,color="brown"), #轴标题 粗体斜体
                 axis.text = element_text(face="bold",size=9,color = "darkblue"), #坐标轴标签为加粗的深蓝色9号字
                 axis.text.x = element_text(angle = 45,vjust = 0.5), #x轴标签旋转45度，调整位置ajust（调整坐标轴标签上下位置）
                 axis.line.x = element_line(colour = "skyblue",size = 1.5), #X轴线条设置
                 panel.background = element_rect(fill="white",colour = "darkblue"), #画图区域有白色的填充和深蓝色的边框
                 plot.background = element_rect(fill = "#FFFFFF"), #除了画图区域外的其他区域填充为白色
                 plot.margin = unit(c(3,2,1,1),"cm"), #设置绘图区域距离边的据类，上，右，下，左
                 panel.grid.major.y = element_line(color = "grey",linetype = 1), #主水平网格线为灰色的实线
                 panel.grid.minor.y = element_line(color = "grey",linetype = 2), #次水平网格线为灰色的虚线
                 panel.grid.minor.x = element_blank(), #垂直网格线不输出
                 legend.position = "bottom", #图例位置在底部, "None":无图注
                 legend.title = element_text(size=13,color = "blue"), #图注标题
                 legend.text = element_text(size=10)) #图注标签字号
                 
                 
ggplot(data1,aes(x=attributes,y=value,fill=X)) + geom_bar(stat="identity",position="dodge") + mytheme + 
  labs(x="years",y="money (ten thousand)",fill="",title = "My Plot Theme By ggplot2",subtitle = "geom_bar",caption = "2021-02-18")
#labs(fill="") 修改图例的标题为无 

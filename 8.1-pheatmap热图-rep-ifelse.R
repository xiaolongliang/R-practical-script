
##hatmap

##函数一：ifelse()
"""
ifelse:
ifelse(test,yes,no):test为真，输出yes值，否则输出no值

example:
a <- c(1,1,1,0,0,1,1)
ifelse(a!=1,1,0) #若果a的值不等于1，输出1，否则输出0
[1] 0 0 0 1 1 0 0
"""

##函数二：rep()
"""
rep():复制

rep(1,10)   #把1重复10次
 [1] 1 1 1 1 1 1 1 1 1 1

rep(1,times=10) #把1重复10次
 [1] 1 1 1 1 1 1 1 1 1 1
 
rep(1:4,2)  #1:4，4个数字，整体复制2次，长度=8
[1] 1 2 3 4 1 2 3 4

rep(1:4,each=2)  #1:4，4个数字，每个数字重复2次，长度=8
[1] 1 1 2 2 3 3 4 4

rep(1:4, c(2,3,2,3))  #1:4，4个数字，每个数字重复c(2,3,2,3)次,即1重复2次，2重复3次，3重复2次，4重复3次
[1] 1 1 2 2 2 3 3 4 4 4
"""

##三：pheatmap()参数

"""
#display_numbers = TRUE: 将数值显示在热图的格子中
#number_format设置数值的格式，较常用的有"%.2f"（保留小数点后两位），"%.1e"（科学计数法显示，保留小数点后一位）
#number_color设置显示内容的颜色
#cellwidth,cellheigh 设置格子的大小
#main可设置热图的标题
#fontsize设置字体大小
#filename可直接将热图存出，支持格式png, pdf, tiff, bmp, jpeg，并且可以通过width,height设置图片的大小；
angle_col:旋转调整X轴的标注方向，旋转角度为0，45，90，279，315.
"""


#install.packages("pheatmap")
library(pheatmap)

#data process
test <- matrix(rnorm(200),20,10)
test[1:10,seq(1,10,2)] = test[1:10,seq(1,10,2)] + 3
test[11:20,seq(2,10,2)] = test[11:20,seq(2,10,2)] + 2
test[15:20,seq(2,10,2)] = test[15:20,seq(2,10,2)] + 4
colnames(test) <- paste("Test",1:10,sep = "")  #paste函数
rownames(test) <- paste("Gene",1:20,sep = "")

#hapmap
pheatmap(test) #行列均进行聚类
pheatmap(test,cluster_rows = FALSE,cluster_cols = FALSE) #行列不聚类
pheatmap(test,display_numbers = TRUE,number_format = "%.1e")
#display_numbers = TRUE: 将数值显示在热图的格子中
#number_format设置数值的格式，较常用的有"%.2f"（保留小数点后两位），"%.1e"（科学计数法显示，保留小数点后一位）
#number_color设置显示内容的颜色

pheatmap(test,display_numbers = matrix(ifelse(test>5,"*",""),nrow(test)))  #pheatmap(test,display_numbers = ifelse(test>5,"*",""))

pheatmap(test, cellwidth = 15, cellheight = 12, main = "Example heatmap", fontsize = 8, filename = "test.pdf") 
#cellwidth,cellheigh 设置格子的大小
#main可设置热图的标题
#fontsize设置字体大小
#filename可直接将热图存出，支持格式png, pdf, tiff, bmp, jpeg，并且可以通过width,height设置图片的大小；


#pheatmap还可以显示行或列的分组信息，支持多种分组；
annotation_col <- data.frame(CellType = factor(rep(c("CT1","CT2"),5)),Time=1:5)
rownames(annotation_col) <- paste("Test",1:10,sep = "")
annotation_row = data.frame(GeneClass = factor(rep(c("Path1", "Path2", "Path3"), c(10, 4, 6))))
rownames(annotation_row) = paste("Gene", 1:20, sep = "")
pheatmap(test,annotation_row = annotation_row,annotation_col = annotation_col)

##设置各个分组的颜色
ann_colors = list(Time = c("white","firebrick"),
                 CellType = c(CT1 = "#1B9E77", CT2 = "#D95F02"),
                 GeneClass = c(Path1 = "#7570B3", Path2 = "#E7298A", Path3 = "#66A61E"))
pheatmap(test,annotation_row = annotation_row,annotation_col = annotation_col,annotation_colors = ann_colors)

#pheatmap还能够根据特定的条件将热图分隔开；
#cutree_rows, cutree_cols：根据行列的聚类数将热图分隔开；
pheatmap(test,cutree_rows=3,cutree_cols=2)

#还可以利用gaps_row, gaps_col自己设定要分隔开的位置
pheatmap(test, annotation_col = annotation_col, cluster_rows = FALSE, gaps_row = c(10, 14),
         cutree_col = 2)





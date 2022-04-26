#2-input data to R

##从带分隔符的文本文件导入数据  read.table()
grades <- read.table("file.csv",header = TRUE,row.names = "studentID",sep = ",")
#row.names:指定"studentID"这一列作为索引
#col.names: 如果文件的第一行不包括变量名（header=FALSE），col.names指定一个包含变量名的字符向量。
#na.strings:na.straings("-9","?"):把-9和？值在读取数据的时候转换成NA
#stringsAsFactors:字符向量是否需要转化成因子，默认TRUE
#skip：读取数据前跳过的行的数目


str(grades) #显示某个对象的结构

##导入excel数据
library(xlsx)
workbook <- "c:/myworkbook.xlsx"
mydataframe <- read.xlsx(workbook,1) #从位于c盘根目录的工作簿myworkbook.xlsx中导入了第一个工作表，并将其保存为一个数据框。

















mtcars$car <- rownames(mtcars)
colnames(mtcars)
mtcars <- mtcars[,c(12,1:11)]
head(mtcars)

library(tidyr)

# 1.gather  wide 到 long 转换
mtcarsNew <- mtcars %>%
  gather(key=attribute,value=value,-car) #-car:排除列car

mtcarsNew <- mtcars %>%
  gather(key=attribute,value=value,mpg:gear) #将mpg到gear的所有列聚到同一列中

gather(mtcars,attr,value,mpg,wt) 
#gather(mtcars,mpg,wt,key = attr,value = value)

# 2. spread实现long 到wide转换

longformat <- gather(mtcars,attr,value,-car)
spread(longformat,attr,value)
spread(longformat,attr,value,sep = "|") #新列名为attr|name

spread(longformat,car,value) #将car列展开















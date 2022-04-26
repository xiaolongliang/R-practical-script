
## install package that need to excute machine learning
#pkgs <- c("rpart","rpart.plot","party","randomForest","e1071")
#install.packages(pkgs,depend=TRUE)

## install data
loc <- "http://archive.ics.uci.edu/ml/machine-learning-databases/"
ds <- "breast-cancer-wisconsin/breast-cancer-wisconsin.data"
url <- paste(loc,ds,sep = "")
breast <- read.table(url,sep = ",",header = FALSE,na.strings = "?")
names(breast) <- c("ID","clumpThickness","sizeUniformity","shapeUniformity","magnalAdhesion","singlEEpithelialCellSie",

                                      "bareNuclei","blandChromatin","normalNucleoli","mitosis","class")
## data deal
df <- breast[-1]
df$class <- factor(df$class,levels = c(2,4),labels = c("benign","malignant"))
set.seed(1234)
train <- sample(nrow(df),0.7*nrow(df))
df.train <- df[train,]
df.validate <- df[-train,]
table(df.train$class)
table(df.validate$class)

## logistic regression
fit.logit <- glm(class~.,data = df.train,family = binomial()) #class~.:以类别为响应变量，其他变量为预测变量
summary(fit.logit)

prob <- predict(fit.logit,df.validate,type = "response")
logit.pred <- factor(prob > .5, levels = c(FALSE,TRUE),labels = c("benign","malignant"))
logit.pref <- table(df.validate$class,logit.pred,dnn = c("Actual","Predicted")) #交叉表，即混淆矩阵，评估预测准确性
logit.pref

##决策树
library(rpart)
set.seed(1234)
dtree <- rpart(class~.,data=df.train,method="class",parms=list(split="information"))
dtree$cptable
plotcp(dtree)

dtree.pruned <- prune(dtree,cp=.0125)
library(rpart.plot)
prp(dtree.pruned,type=2,extra=104,fallen.leaves=TRUE,main="Decision Tree")
dtree.pred <- predict(dtree.pruned,df.validate,type = "class")
dtree.pref <- table(df.validate$class,dtree.pred,dnn = c("actual","predicted"))
dtree.pref


























#sample()函数
#table()函数









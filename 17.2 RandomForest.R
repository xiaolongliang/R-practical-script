
library(randomForest)
library(ROCR)
library(mlbench) #常用机器学习数据集
# install.packages("GGally")
library(GGally)  #画图表示特征之间相关性

set.seed(1234)
head(iris)
df <- iris[iris$Species != "setosa",]
all_data <- df[,1:(ncol(df)-1)]
all_classes <- factor(df$Species)

#dividing data
n_samples <- nrow(all_data)
n_train <- floor(n_samples * 0.8)
indices <- sample(1:n_samples)
indices <- indices[1:n_train]

train_data <- all_data[indices,]
train_classes <- all_classes[indices]
validation_data <- all_data[-indices,]
validation_classes <- all_classes[-indices]

#train
rf_classifier <- randomForest(train_data,train_classes,trees=100)

# predict on validation set
predicted_classed <- predict(rf_classifier,validation_data)
print(validation_classes)
print(predicted_classed)

#用预测的类别和真实类别可构建一个混淆矩阵（confusion matrix）
position_class <- "versicolor"
#true position count(TP)
TP <- sum((predicted_classed == position_class) & (validation_classes == position_class))
# false positive count (FP)
FP <- sum((predicted_classed == position_class) & (validation_classes != position_class))
# false negative count (FN)
FN <- sum((predicted_classed != position_class) & (validation_classes == position_class))
# true negative count (TN)
TN <- sum((predicted_classed != position_class) & (validation_classes != position_class))

confusion <- matrix(c(TP,FP,FN,TN),nrow = 2,ncol = 2,byrow = TRUE)

colnames(confusion) <- c('TRUE versicolor','TRUE virginica')
rownames(confusion) <- c("predicted versicolor",'predicted virginica')

# 基于混淆矩阵计算accuracy、sensitivity、positive predicted value、specificity等评估指标
cat('accuracy =', (TP + TN)/(TP + TN + FP + FN), '\n')
cat('sensitivity =', TP/(TP + FN), '\n')
cat('positive predicted value =', TP/(TP + FP), '\n')
cat('specificity =', TN/(TN + FP), '\n')

# Plot ROC on validation set
predicted_probs <- predict(rf_classifier,validation_data,type = "prob") #type = 'prob'参数可计算每个类别的概率
head(predicted_probs)

validation_labels <- vector('integer',length(validation_classes)) ##
validation_labels[validation_classes == position_class] <- 1
validation_labels[validation_classes != position_class] <- 0
# 通过prediction函数，使用预测为正样本的概率和真实类别创建一个对象pred
pred <- prediction(predicted_probs[,position_class],validation_labels)

# 以假阳性率（false positive rate, fpr)为X轴, 真阳性率（true positive rate, tpr）为y轴绘制ROC曲线：
roc <- performance(pred,'tpr','fpr')
plot(roc,main='ROC Curve')



GGally::ggpairs(df,columns = 1:4,ggplot2::aes(color=Species))


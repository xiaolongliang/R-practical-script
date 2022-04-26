
# if-else
if(!is.factor(grade)) grade <- as.factor(grade) else print("grade already is a factor")
if(is.factor(grade)) grade <- as.factor(grade)

# ifelse
ifelse(score > 0.5, print("passed"),print("failed"))

# while 
i <- 10
while(i > 0) {print("hello");i=i-1}

# for
for (i in seq(10)) {
  print("hello")
}

# example 1
x <- c(0.05, 0.6, 0.3, 0.9)
for (i in seq(x)) {
  if(x[i] <= 0.2) cat("small\n")
  else if(x[i] <= 0.8) cat("medium\n")
  else cat("large\n")
}


# example 2
mystats <- function(x,parametric=TRUE,print=FALSE){
  if(parametric){
    center <- mean(x);spread <- sd(x)
  } else {
    center <- median(x);spread <- mad(x)
  }
  if(print & parametric) {
    cat("mean=",center,"\n","sd=",spread,"\n")
  } else if (print & !parametric){
    cat("median=",center,"\n","mad=",spread,"\n")
  }
  result <- list(center=center,spread=spread)
  return(result)
}

set.seed(1234)
x <- rnorm(500)
y1 <- mystats(x)
y <- mystats(x,parametric = FALSE,print = TRUE)


# example 3
pvalues <- c(.0867,.0018,.0054,.0183,.5386)

ifelse(pvalues < .05,"significant","Not significant")

result <- vector(mode = "character",length = length(pvalues))
for (i in 1:length(pvalues)) {
  if(pvalues[i] < .05) result[i] <- "significant"
  else result[i] <- "Not significant"
}


# for (i in seq(length(pvalues))) print(i)


# example 4
f <- function(x,y,z=1){
  result <- x + (2*y) + (3*z)
  return(result)
}

f(2,3,4)
f(2,3)
f(x=2,y=3)
f(z=4,y=2,3)

args(f)
 













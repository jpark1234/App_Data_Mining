# HW 4
# Using the apply function and creating functions


# 1. (5) Create a matrix as follows:

m <- matrix(c(1:10, 11:20), nrow = 10, ncol = 2)

# Now find the mean of the rows
apply(m,1,mean)
###[1]  6  7  8  9 10 11 12 13 14 15

# And find the mean of the columns
apply(m,2,mean)
###[1]  5.5 15.5

# Divide all values by 2
apply(m, c(1:2), function(m) m/4)


# Examine the following R code. Briefly explain what it is doing.

> z.sq <- function(z) return(c(z,zˆ2))
> x <- 1:8
> z.sq(x)
[1] 1 2 3 4 5 6 7 8 1 4 9 16 25 36 49 64
> matrix(z.sq(x),ncol=2)
[,1] [,2]
[1,] 1 1
[2,] 2 4
[3,] 3 9
[4,] 4 16
[5,] 5 25
[6,] 6 36
[7,] 7 49
[8,] 8 64

###x is a vector of values 1 through 8. z.sq is a function that returns squared values,
###while preserving the original input value.
###z.sq(x) returns the original vector values of 1 through 8 and the squared values of it.

# How could you simplify this? (Hint: Use sapply). Carry out your simplication 
# in R and show the result 

matrix(sapply(x, function(x) c(x,x^2)), ncol=2)

       
#2. (5) Suppose we have a matrix of 1s and 0s, and we want to create a vector that
# has a 1 or a 0 depending on whether the majority of the first c elements in that 
# row are 1 or 0. Here c will be a parameter which we can vary. Write a short 
# function, perhaps called find.majority, that does this. Then apply it to 
# the following matrix X when c=2 and again when c=3:

> X <- matrix(c(1,1,1,0, 0,1,0,1, 1,1,0,1, 1,1,1,1, 0,0,1,0),nrow=4)

c <- c(1,2,3,4,5)
find.majority <- function(X,c){
  as.numeric(apply(X[ ,1:c], 1, sum) >= c/2)
}


##aggregate 
## sum of the rows is creater than c/2

# 3. (7) There is a famous dataset in R called "iris." It should already be loaded
# in R for you. If you type in ?iris you can see some documentation. Familiarize 
# yourself with this dataset.
IRIS <- as.data.frame(iris)
# Find the mean petal length by species

mean(IRIS$Petal.Length[IRIS$Species=="setosa"]) #[1] 1.462
mean(IRIS$Petal.Length[IRIS$Species=="versicolor"]) #[1] 4.26
mean(IRIS$Petal.Length[IRIS$Species=="virginica"]) #[1] 5.552


# Now obtain the mean of the first 4 variables, by species, but 
# using only one function call.
aggregate(IRIS[,1:4], by=list(Species=IRIS$Species), mean)


# Create a simple scatter plot of Petal Length against Petal
# Width. Title your plot appropriately.
plot(IRIS$Petal.Length ~ IRIS$Petal.Width,
     xlab="Petal Width",
     ylab="Petal Length",
     main="Petal Length by Petal Width")

# Now change the plotting symbol to be different for each species.
?plot
shape <- c(15, 17, 19)
point_shape <- shape[as.numeric(IRIS$Species)]
plot(IRIS$Petal.Length ~ IRIS$Petal.Width,
     xlab="Petal Width",
     ylab="Petal Length",
     main="Petal Length by Petal Width", pch=point_shape)

# Replot the data using the same symbol for all species, but plot 
# each species in a different color, filling the symbol

pCols <- c("pink", "green", "brown")
point_col <- pCols[as.numeric(IRIS$Species)]        

plot(IRIS$Petal.Length ~ IRIS$Petal.Width,
     xlab="Petal Width",
     ylab="Petal Length",
     main="Petal Length by Petal Width", 
     col = point_col,
     pch=point_shape)

# A very useful function in R is "pairs." Use the pairs function to 
# create a plot of the iris data, comparing Petal Length, Petal
# Width, Sepal Length, and Sepal Width. You should have 12 subplots, 
# and 4 labeling plots.
# Use the previous question to code each of the points in a different
# color by species.

pairs(IRIS[1:4],   
      col = point_col,
      pch=point_shape)

# What can you conclude about the data, from inspection of the pairs plot?
###Setosas, compared to the other two species of iris flowers, have smaller petals 
###(in both length and width). But setosas have a wide range in sepal width and length.
###Vericolor and virginica are more or less similar in their sepal and petal dimensions, 
###at least, in comparison to setosas. 

# 4. (5) Create a list with 2 elements as follows:

l <- list(a = 1:10, b = 11:20)

# What is the mean of the values in each element?
lapply(l,mean )

# What is the sum of the values in each element?
lapply(l, sum)

# What type of object is returned if you use lapply? sapply? Show your R code that finds these answers. 
##lapply always returns a list. 
class(lapply(l, sum))
##sapply returns a vector 
class(sapply(l, mean))

# Now create the following list:

l.2 <- list(c = c(21:30), d = c(31:40))

# What is the sum of the corresponding elements of l and l.2, using one function call?
mapply("+", l, l.2)

# Take the log of each element in the list l:
lapply(l,log)

# 5. (5) Write a function that finds the sample covariance, following the commenting 
# in this template. Then try your function out on the iris data.

## This is a funtion to find the sample covariance.
## Input: Dataset mat
## Output: Covariance Matrix
Data.Mat <- IRIS 
samp.cov <- function(Data.Mat) {
{

# find the mean for each column, called sample.mean
sample.mean <- apply(Data.Mat[1:4], 2, mean)

# subtract the sample mean from each observation
sample.mean.sub <- t(apply(Data.Mat[1:4], 1, function(x) x-sample.mean))

# implement matrix multiplication (hint: just leave the following code as it is)
y.multiply <- function(y) return(y %*% t(y))

# now use apply() to carry out matrix multiplication over the rows of Mat
# notice the output will have ncol(Mat)ˆ2 rows, and nrow(Mat) columns
x.matmult <- apply(sample.mean.sub, 1, y.multiply)

# create the covariance matrix by taking the row means of x.matmult
cov.mat <- apply(x.matmult, 1, mean)

# now use the return function and coerce the output to be matrix valued and 
# have the same number of rows and the number of columns as your input matrix 

return(matrix(cov.mat,nrow=ncol(Data.Mat[1:4]),ncol=ncol(Data.Mat[1:4])))}
}

# Load samp.cov into R and give the result when you try your function out on 
# the iris data. Compare to the following output. Do your results differ? If 
# they do, why is that?
###It varies ever so slightly. Perhaps the difference arises from not dividing 
###this by 1 over n-1 as it is done in the covariance formula?
samp.cov(Data.Mat)
#[,1]        [,2]       [,3]       [,4]
#[1,]  0.68112222 -0.04215111  1.2658200  0.5128289
#[2,] -0.04215111  0.18871289 -0.3274587 -0.1208284
#[3,]  1.26582000 -0.32745867  3.0955027  1.2869720
#[4,]  0.51282889 -0.12082844  1.2869720  0.5771329

> cov(Data.Mat[,1:4])
#               Sepal.LengthSepal.Width  Petal.Length Petal.Width
#Sepal.Length    0.6856935  -0.0424340    1.2743154   0.5162707
#Sepal.Width    -0.0424340   0.1899794   -0.3296564  -0.1216394
#Petal.Length    1.2743154  -0.3296564    3.1162779   1.2956094
#Petal.Width     0.5162707  -0.1216394    1.2956094   0.5810063

Bonus: improve on the documentation in samp.cov
             
             
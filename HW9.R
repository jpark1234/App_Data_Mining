#HW9
#Q1
Q1 <- read.table("http://www.stanford.edu/~vcs/StatData/weather.csv", header=TRUE, sep="|")
#a)
X <- as.matrix(Q1)
X <-t(X)
colnames(X) <- Q1[,1] #make dates the column names for the matrix 
X <- X[-1,] #remove the row with dates
dim(X)
#144 3574

#b)
#v will be cyclical becaues it is weather 
#u would be noise around the mean because it is the dates 

#c)
Xn <- apply(X, c(1,2), as.numeric) #turn character matrix to double matrix to run svd on
library(MASS)
X.svd <- svd(Xn)
plot(X.svd$v[,1]) 
plot(X.svd$u[,1]) 

#d)
plot(X.svd$d) 

#e)
mean(Xn) #mean with -99.0 included
#55.77797
Xn2 <- Xn
Xn2[Xn2==-99.0] <- NA #remove -99.0 and label NA
mean(Xn2, na.rm=TRUE) 
#56.55597
Xn2[Xn==-99.0] <- 56.6

#f)
X.svd2 <- svd(Xn2)
plot(X.svd2$v[,1]) 
plot(X.svd2$u[,1]) 
plot(X.svd2$d)



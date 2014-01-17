# HW 5
# Using the bootstrap


# 1. Suppose we have a sample of data from an exponential distribution 
# with parameter lambda

# In this case we can use Maximum Likelihood to estimate the parameter
# lambda, which gives lambda.hat = 1/mean(X). As the number of 
# observations increases, this estimate for lambda becomes normally 
# distributed. We can form a (100 - alpha)*100% confidence interval for
# lambda using an estimate for the variance of lambda, var(lambda) = 
# (lambda.hat)^2 / n.
# This gives an estimate of the confidence interval for lambda.hat as: 
# lambda.hat +/- z(1-alpha/2)*lambda.hat/sqrt(n)

# 1a. (1) Generate 100 observations of test data, with lambda=3. Remember
# to set your seed before carrying out any computations.
set.seed(1)
n=100
samp.100 <-rexp(n, rate=3)

# 1b. (1) What is the mean of your test data?
mean(samp.100)
#[1] 0.3435588

# 1c. (1) What is your estimate lambda.hat?
lambda.hat <- 1/mean(samp.100)
#[1] 2.91071

# 1d. (1) Generate the upper and lower limits of the confidence region 
# using the formula given above. Give your code and the limits it 
# produced below.
lamda.limit <- lambda.hat +/- z(1-alpha/2)*lambda.hat/sqrt(n)
alpha <- 0.05
z<- qnorm(1-alpha/2)
lambda.up <- lambda.hat + z*lambda.hat/sqrt(100)
lambda.down <- lambda.hat - z*lambda.hat/sqrt(100)

# 2. Now suppose we are not using the maximum likelihood estimate for 
# lambda, or we do not want to use the asymptotic distribution to form 
# our confidence intervals as we did above. We could use the bootstrap 
# to estimate the distribution of lambda.hat and create bootstrap 
# confidence intervals for lambda.

# 2a. (1) Form a set of bootstrap estimates of our parameter by generating B
# random samples as you did once in 1a but use lambda.hat since we do not
# know the true lambda in this case (keep n=100). Set B=1000, and again set
# your seed.
set.seed(1)
B <- 1000
bootstrap <- replicate(B, rexp(100, rate=lambda.hat))


# 2b. (1) Get a new estimate for lambda.hat from each of the bootstrap samples
# in 2a. You'll want to create a matrix to receive each value. You should 
# have 1000 estimates for lambda.hat now.
bs.matrix <- matrix(1/(apply(bootstrap, 2, mean)))

# 2c. (2) Now look at the sampling distribution for lambda.hat, using the hist
# function. Remember your graphing techniques to make the plot look professional.
# Does the distribution look normal?
hist(bs.matrix, breaks=20)

# 2d. (1) Find the quantiles of the sampling distribution you created, for a 
# 5% region.
bs.up <- quantile(bs.matrix, probs=(1-alpha/2))
#   97.5% 
#3.544533 
bs.down <- quantile(bs.matrix, probs=(alpha/2))
#   2.5% 
#2.422532 

# 2e. (1) Calculate the bootstrap confidence interval boundaries, lower and upper.
ci.up <- bs.up - mean(bs.matrix)
#    97.5% 
#0.6047545 
ci.down <- mean(bs.matrix) - bs.down
#     2.5% 
#0.5172458 

lambda.hat + ci.up
#    97.5% 
#3.515464 

lambda.hat - ci.down
#    2.5% 
#2.393464

# 2f. (1) Calculate an estimate of the standard error of lambda.hat using your
# collection of bootstrap estimated parameters. What is your confidence interval?
samp.se <- sd(bs.matrix)
# [1] 0.2978665
se.up <- lambda.hat + qnorm(1-alpha/2)*samp.se
se.up
# [1] 3.494517
se.down <- lambda.hat - qnorm(1-alpha/2)*samp.se
se.down
# [1] 2.326902

# 3a. (5) We made some decisions when we used the bootstrap that we can now question. 
# Repeat the above creation of a confidence interval for a range of values of data
# (we had our sample size fixed at 100) and a range of bootstrap values (we had B 
# fixed at 1000). Suppose the sample size varies (100, 200, 300, .... , 1000) and 
# B varies (1000, 2000, ... , 10000). You will likely find it useful to write
# functions to carry out these calculations. Your final output should be 
# upper and lower pairs for the confidence intervals produced using the bootstrap
# method for each value of sample size and B.
set.seed(1)
B <- c(seq(from=1000, to=10000, by=1000))
n <- c(seq(from=100, to=1000, by=100))
ci.high <- matrix(nrow=length(n),ncol=length(B))
ci.low <- matrix(nrow=length(n), ncol=length(B))

for(i in 1:length(n)){
  for(j in 1:length(B)){
    bstrap <- replicate(B[j], rexp(n[i], rate=lambda.hat))
    bstrap.mx <- 1/apply(bstrap, 2, mean)
    bsamp.se <- sd(bstrap.mx)
    ci.high[i, j] <- lambda.hat + qnorm(1-alpha/2)*bsamp.se
    ci.low[i, j] <- lambda.hat - qnorm(1-alpha/2)*bsamp.se
  } 
}

ci.high
ci.low

# 3b. (2) Plot your CI limits to show the effect of changing the sample size and 
# changing the number of bootstrap replications. What do you conclude?
plot(ci.high)
plot(ci.low)
### As the sample size increases, both the low and high limit of the confidence 
### interval start approaching 3. 







	
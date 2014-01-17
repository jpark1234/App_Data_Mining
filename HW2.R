# HW #2

# In this assignment you will manipulate a data frame, by taking subsets and 
# creating new variables, with the goal of creating a plot.
# DO NOT use the subset() function in R when answering these questions.
# The goal is to give you practice with [ ]

# You will work with housing data that have been made available by the San
# Francisco Chronicle. These data contain information about sales in the
# San Francisco Bay Area, including the date of sale, sale price, square
# footage and location of each house sold from April 2003 to May 2006.

# Before beginning with the housing data, you will do some warm up 
# exercises with the small family data set that we have used in class.

#PART 1.  Family Data
# Load the data from the Web into your R session with the following command:
load(url("http://www.stanford.edu/~vcs/StatData/family.rda"))

# In the following exercises try to write your code to be as general as possible
# so that it would still work if the family had 27 members in it or if the 
# variables were in a different order in the data frame.

# (1) Q1. 
# In the past, the NHANES survey (for the family dataset) used different 
# cut-off values for men and women when classifying them as over weight.
# Suppose that a man is classified as over weight if his bmi exceeds 26
# and a woman is classified as over weight if her bmi exceeds 25.

# Write a logical expression that creates a logical vector, called OW_NHANES, where
# an element is TRUE if a member of family is over weight and FALSE otherwise
OW_NHANES = (fgender == "f")& (fbmi>25) | (fgender == "m") & (fbmi >26)


# (4) Q2. 
# Here is an alternative way to create the same vector that introduces 
# some useful functions and ideas.

# We first create a numeric vector called OW_limit that is 26 for each male in
# the family and 25 for each female in the family.  To do this, create a vector 
# of length 2, called OWval, where the first element is 26 and second element is 25.
OWval <- c(26, 25)

# Now, create the OW_limit vector by subsetting OWval by position, where the 
# positions are the numeric values in the gender variable 
# (i.e. use as.numeric to coerce the factor vector to a numeric vector)
# Notice that we can "subset" a vector of length 2 by a much longer vector.
as.numeric(fgender)
OW_limit <- OWval[fgender]

# Finally, use OW_limit and the bmi vector in family to create the desired logical vector, 
# and call it OW_NHANES2.
OW_NHANES2 <- (fbmi > OW_limit)


# (1) Q3.
# Use the vector OW_limit and each persons height to find the weight 
# that he/she would have if their bmi was right at the over weight cut off (26 for men and 
# 25 for women).   Call this weight OW_weight
OW_weight <- ((fheight)*(fheight)*(OW_limit))/703




# Make the following plot of actual weight against the weight at which they would
# be over weight

plot(family$weight, OW_weight)
abline(a=0,b=1)


#PART 2.  San Francisco Housing Data
#
# Load the housing data into R.
load(url("http://www.stanford.edu/~vcs/StatData/SFHousing.rda"))

# (5) Q4.
# What is the name and class of each object you have loaded into your workspace?
### Your code below
class(cities)
class(housing)
### Your answer here
[1] "data.frame"
[1] "data.frame"

# What are the names of the vectors in housing?
### Your code below
names(housing)
### Your answer here
[1] "county"  "city"    "zip"     "street"  "price"   "br"      "lsqft"   "bsqft"  
[9] "year"    "date"    "long"    "lat"     "quality" "match"   "wk"     

# How many observations are in housing?
### Your code below
dim(housing)

### Your answer here
[1] 281506     15
281,506 observations

# Explore the data using the summary function. 
summary(housing$price)
Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
22000   400000   530000   602000   700000 20000000 
summary(cities$medianPrice)
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
324000  477500  605500  711000  800000 2200000 

summary(housing$lsqft)
Min.   1st Qu.    Median      Mean   3rd Qu.      Max.      NA's 
       19      4000      5760     65940      7701 418600000     21687 
summary(housing$bsqft)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
122    1121    1430    1624    1882 1868000     426 
summary(cities$medianSize)
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
861    1322    1460    1565    1672    3140 

# Describe in words two problems that you see with the data.
#### Write your response here
# 1) longitude and laditude data does not seem to add much value to the data frame.
# 2) there is a very large amount of missing data in the housing data frame

# (1) Q5.
# We will work with houses in Albany, Berkeley, Piedmont, and Emeryville only.
# Subset the data frame so that we have only houses in these cities,
# and keep only the variables city, zip, price, br, bsqft, and year.
# Call this new data frame BerkArea. This data frame should have 4059 observations
# and 6 variables. Remove from your workspace the housing and cities objects.
someCities = c("Albany", "Berkeley", "Piedmont", "Emeryville")
BerkArea <- housing[housing$city %in% someCities, c("city", "zip", "price", "br", "bsqft", "year") ]
rm(housing)

# (2) Q6.
# We are interested in studying the relationship between price and size of house, but first
# we will further subset the data frame to remove the unusually large values.
# Use the quantile function to determine the 99th percentile of price and bsqft
# and eliminate all of those houses that are above either of these 99th percentiles
# Call this new data frame BerkArea, as well. It should have 3999 oobservations.
# As in part 1, write your code so that it is very general and does not depend on the 
# actual numeric value for these quantiles.
BerkArea = BerkArea[BerkArea$price < quantile(BerkArea$price, c(.99)) & 
                      BerkArea$bsqft < quantile(BerkArea$bsqft, c(.99), na.rm = TRUE),]


# (1) Q7.
# Create a new vector that is called pricepsqft by dividing the sale price by the square footage
# of the house.  Add this new variable to the data frame.
BerkArea["pricepsqft"] <- (BerkArea$price/BerkArea$bsqft)


# (1) Q8.
# Create a vector called br5 that is the number of bedrooms in the house, except
# if this number is greater than 5, it is set to 5.  That is, if a house has 5 or more
# bedrooms then br5 will be 5. Otherwise it will be the number of bedrooms in the house.
br5 <- pmin(BerkArea$br, 5)



# (1) Q9. 
# Use the rainbow function to create a vector of 5 colors, call this vector rCols.
# When you call this function, set the alpha argument to 0.25 (we will explain what this does later).
# Create a vector called brCols of colors where each element
# color corresponds to the number of bedrooms in the br5.
# For example, if the element in br5 is 3 then the color will be the third color in rCols.
rCols <- rainbow(5, alpha = 0.25)
brCols = rCols[br5]             
                                


# (1) Q10.
# We are now ready to make a plot!
# Try out the following code

plot(pricepsqft ~ bsqft, data = BerkArea,
	 main = "Housing prices in the Berkeley Area",
     xlab = "Size of house (square ft)",
     ylab = "Price per square foot",
     col = brCols, pch = 19, cex = 0.5)
legend(legend = 1:5, fill = rCols, "topright")

####
### What interesting feature do you see that you did not know before making this plot? 
#According to Zach, the TA, this is not plotting the way it should. 
#Therefore, I am a bit cautious about making any observations on it. 
#Instead I will point out what I think the plot should look like. 
# 1) as the square footage of the apartment increases, the marginal price of an additional square footage decreases.
# 2) the majority of houses are between 500 to 2000 square foot in the Berkeley Area


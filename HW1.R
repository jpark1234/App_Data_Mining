# HW 1

# Load the data for this assignment into your R session 
# with the following command:

load(url("http://www.stanford.edu/~vcs/StatData/SFTemps.rda"))

# Check to see that the data were loaded by running:
objects()
[1] "dates"      "dayOfMonth" "month"      "SFTemps"    "temp"       "year"  
# This should show five variables: dates, dayOfMonth, month, temp, and year

# Use the length() function to find out how many observations there are.
### The length is already defined and visible in the workspace. But,
length(dates)
[1] 5534
length(dayofMonth)
[1] 5534
length(month)
[1] 5534
length(temp)
[1] 5534
length(year)
[1] 5534

# 1. Find the average daily temperature
mean(temp, na.rm=TRUE)
[1] 56.95646

# 2. Find the 10% trimmed average daily temperature
mean(temp,trim=0.1,na.rm=TRUE)
[1] 56.88641

# 3. Find the 50% trimmed average daily temperature
mean(temp,trim=0.5,na.rm=TRUE)
[1] 57

# 4. Compute the median daily temperature. How does it compare to 
# the 50% trimmed mean? Explain. Put your explanation in a comment
# that begins with three ###


### Your explanation goes here
median(temp, na.rm=TRUE)
[1] 57
mean(temp,trim=0.5, na.rm=TRUE)
[1] 57
###the median and the 50% trimmed mean are equal. If you trim off 50% of both ends, you get the median. 

# 5. We would like to convert the temperature from Farenheit to Celsius. 
# Below are several attempts to do so that each fail.  
# Try running each expression in R. 
# Record the error message in a comment
# Explain what it means. 
# Be sure to directly relate the wording of the error message with the problem you find in the expression.

(temp -32)
### Error message here: This command does not generate an error response. Rather this is a numeric function that subtracts 32 from every position vector within variable "temp"
### Explanation here: If I run this command, this would subtract 32 from every value (besides NA) in the variable.Therefore, instead of running this precise command, I would do temp_rec <- (temp -32) instead, to preserve the original variable. 

(temp - 32)5/9
### Error message here: Error: unexpected numeric constant in "(temp -32)5"
### Explanation here: "5"has not been assigned a numeric operator. A proper way to calculate (temp - 32) times 5 is (temp -32)*5.

5/9(temp - 32)
### Error message here: Error: attempt to apply non-function
### Explanation here: 5/9 has not been properly encased in parenthesis and defined as a numeric function. A proper way to execute this command would be (((temp - 32)*5)/9).

[temp - 32]5/9
### Error message here: Error: unexpected '[' in "["
### Explanation here: Use of wrong parentheses. Square parenthesis [ ] is used for calling on position vectors. But even when the correct () parenthesis is placed, this function will not run due to the numbers not being assigned proper numeric operators.



# 6. Provide a well-formed expression that correctly performs the 
# calculation that we want. Assign the converted values to tempC
tempC = (((temp -32)*5)/9)

# For the following questions, use one of: head(), summary(),
# class(), min(), max(), hist(), quantile() to answer the questions.

#7. What was the coldest temperature recorded in this time period?
min(temp, na.rm=TRUE)
[1] 38.3

#8. What was the warmest temperature recorded in this time period?
max(temp, na.rm=TRUE) 
[1] 79.6

#9. What does the distribution of temperatures look like, i.e. 
# are there roughly as many warm as cold days, are the temps
# clustered around one value or spread evenly across the range
# of observed temperatures, etc.?
hist(temp)
###the largest number of dates are clustered around 55 and 60 degrees, followed by 50-55, then 60-65. The distribution for temperature draws a rough bell curve. 

#10. Examine the first hew values of dates. These are a special
# type of data. Confirm this with class(). 
head(dates)
[1] "1995-01-01" "1995-01-02" "1995-01-03" "1995-01-04" "1995-01-05" "1995-01-06"
class(dates)
[1] "Date"

#11. Run the following code to make a plot. 
# (don't worry right now about what this code is doing)

plot(temp~dates, col = rainbow(12)[month], type="p", pch=19, cex = 0.3)

# Use the Zoom button in the Plots window to enlarge the plot.
# Resize the plot so that it is long and short.

# Make an interesting observation about temp in the Bay Area
# based on this plot (something that you couldn't see with
# the calculations so far.)

### Your answer goes here: The temperature in the Bay Area, in quick glance overall, follows a consistent pattern of increase and decrease throughout the season every year. hile each year contains some outliars, the genearl trend and the range of that trend remains consisten overtime. However, looking at this in detail, we can find two interesting things. 1) connecting the end of the clustered points of the coldest months (red) and hottest months (dark blue), we can differentiate between the years with narrower and wider annual temperature ranges. For exmaple, 1996, 2000 and 2006 had narrower ranges in annual temparature difference overall. Whereas, 2004 and 2007 had much wider ranges. 2) This graph makes it easier to identify abnormally hot and cold temperature over time. We can also easily identify unseasonably hot or cold temperatures as there are six different colors used for each year.


# What interesting question about the weather in the Bay Area
# would you like to answer with these data, but don't yet know 
# how to do it? 

### Your answer goes here: Using the temperature information, I would like to see if there is a relationship between annual temperature and the occurrence of natural disaster (such as earthquakes or wild fires) in the Bay area. I would look at newspaper articles to obtain records of when natural disasters in the Bay Area occurred between 1995 and 2010. Then code this information into a categorized variable (such as 1=wildfire, 2=earthquake, 3=flood, etc) and check  with the temperature data to find oddities, if any. 


# For the remainder of this assignment we will work with 
# one of the random number generators in R.

# 12. Use the following information about you to generate 
# some random values:  
#a. Use your year of birth for the mean of the normal
#b.  Use the day of the month you were born for the sd of the normal curve.
#c.  Generate either 5 random values.
#d.	Assign the values to a variable matching your first name.
#e.	Provide the values generated.
jeeyoon <- rnorm(5,mean=1986,sd=9)
[1] 1978.768 1992.391 2005.271 1990.894 2000.895
print(jeeyoon)
[1] 1978.768 1992.391 2005.271 1990.894 2000.895

# 13. Generate a vector called "normsamps" containing 
# 1000 random samples from a normal distribution with 
# mean 1 and SD 2.  
normsamps <- rnorm(1000,1,2)

# 14. Calculate the mean and sd of the 1000 values.

### The return values from your computation go here
mean(normsamps)
[1] 1.029636
sd(normsamps)
[1] 2.012568

# 15. Use implicit coercion of logical to numeric to calculate
# the fraction of the values in normsamps that are less than 3.
normsamps_rec <- normsamps <3
table(normsamps_rec)
#or
class(normsamps_rec)
sum(normsamps <3)

# 16. Look up the help for rnorm. 
# You will see a few other functions listed.  
# Use one of them to figure out about what answer you 
# should expect for the previous problem.  
# That is, find the area under the normal(1, 2) curve 
# to the left of 3.  This should be the chance of getting 
# a random value less than 3.  
?rnorm
pnorm(3, mean= 1, sd=2) 
[1] 0.8413447

# 17. In fewer than 500 words, comment on how the 1962 Tukey article might be updated to take computation into account. Tukey was, of course, speaking from a time when computation as we know it did not exist. In one sentence explain the fundamental issue he perceives, the use the remainder of your answer to suggest how this thinking might be adapted and/or updated to a modern perspective.   
### Tukey's main concern and point of view regarding data analysis is that a) the "current" (by 1960s standards) techniques are antiquated and b) the field is overly focused on techniques rather than answering the large question at hand. While Tukey believes that it is time to seek novelty in the field, the "current" methods of education and training statisticians, preoccupied with mathematical proofing and perfecting techniques, hinder such innovation. Tukey is concerned with data analysis becoming an obscure field of its own that fails to make progressed based on judgments and inference. 

### With respect to technological development, Tukey does not believe computers are essentials but he does acknowledge its superiority in limited aspects - such as working with large amounts of missing data. The finer details of Tukey's ideas are not as applicable today, considering that the article is half a century old. However, his core argument that data analysis should not fall into an abyss of technical achievements but be focused on providing reasonable directions to complex questions is important to remember and reinstate in modern research. 
# HW 3
  # Graphics Skills

# The goals of this assignment are to: 
# 1. become familiar with the variety of plotting functions available in R,
# 2. learn which types of plots are appropriate for which types of data
# 3. gain practice in making plots that make the data stand out,
# facilitate comparison, and are information rich
# 4. gain additional experience working with data frames and vectors

# The help for plot.default describes many parameters that are  
# available for many of the plotting functions.
# Also, ?par provides help on many other plotting parameters.
# Some of these can be set in the plot function, while others
# are set in a call to par()

##############################
# PLOT 1. World Record in Men's 200 meter run
# We might be curious about how much faster today's runners 
# are compared to runners 50 years ago. 

# A search on Wikipedia shows us tables of the times for
# male world record holders in 200 meters dating back to 1951.
# The data are available to you at:

http://www.stanford.edu/~vcs/StatData/WR200MeterMen.csv

# Read this data file into R, using commands from class.

Q1 <- read.csv("http://www.stanford.edu/~vcs/StatData/WR200MeterMen.csv", header = TRUE, sep =",")

# Q1a. How many world records does this data frame contain?
dim(Q1)
###[1] 24  5
###24 records

# Q1b. Use R commanRds to find out who currently holds the world
# record in the men's 200 meter.
as.character(Q1$Athlete)
Q1$Athlete[Q1$Year == max(Q1$Year)]
### [1] Usian Bolt

# Let's look at the relationship between date and time.
# Q1c. What type of variable (numeric (continuous or discrete), nominal ordinal)
# are year and times? (no need to use R code to answer this question)

###Q1$Year is a discrete numeric variable in this case. But normally, I would consider year a continuous varaible because the categories are almost unlimited.
###Q1$Time is a continuous numeric. 

# When we are examining a variable to see how it changes in time,
# we typically make a line plot, with time on the x-axes and 
# the (x,y) values connected with line segments.
# In this case, we want our line plot to look like a step function
# to make it easier to see when the record was broken and how long the record stood.

# Q2a. Begin by making a line plot of year by times for these data.
# Don't bother to make it pretty yet; we will get to that later.
Q1 = Q1[order(Q1$Year),]
###I ordered the variable to get rid of the kink in the plot. 
plot(Q1$Year, Q1$Time, type ="l")

# Q2b. Redo the plot using a date that incorporates the month as 
# well as the year. For example, in Sep 1960 the world record 
# was broken by Livio Berruti. Use a date of 1960.75 for this
# date.
levels(Q1$Month)
num_month =c(4, 8,7,6,3,5,11,10,9)
Q1$year_month = Q1$Year + num_month[Q1$Month]/12


# Q3. The current world record was set in 2008. If we want to 
# show that this record still stands in 2013, we could add a 
# horizontal line segment to the plot from 2008 to 2013 at the 
# 2008 record time.  
# To do this: remake the plot and set the xlim parameter 
# so that 2013 is included in the x-axis scale;
# then use the points function with type = "l" to add 
# the additional segment.
###The record was actually set in 2009, so I am using 2009 instead of 2008. 
plot(Q1$year_month, Q1$Time, type ="l", xlim=c(1951,2013))
points(c(2009, 2013), c(Q1$Time[24], Q1$Time[24]), type="l")

# Q4. The 1996 record stood for several years.
# Let's make it easier to see this and include the name of the athlete 
# who set the record. This additional reference information makes
# our plot richer.
# Add a grey vertical lines at 1996.
# Add the runner's name next to the vertical line.
# To do this, you will need the abline() function, the text() function,
# and you might want to consider the cex, col, pos, adj parameters.
# Also, do not type in the athlete's name. Instead, use the Athlete 
# variable to access it.
abline(v=1996, col="grey")
labels = as.character(Q1$Athlete)
text(Q1$Time, Q1$year_month, labels=min(which(Q1$Year==1996)), cex=1, col="black")


# Q5. Now we are ready to add other contextual information.
# Remake the plot adding axis labels and a title.
# THIS IS THE PLOT THAT SHOULD BE PRINTED AND TURNED IN.
plot(Q1$year_month, Q1$Time, type ="l", xlim=c(1951,2013),
     xlab ="Year",
     ylab="Record Breaking Time",
     main="Olympic World Records for Men`s Track")
points(c(2009, 2013), c(Q1$Time[24], Q1$Time[24]), type="l")    
abline(v=1996, col="grey")
labels = as.character(Q1$Athlete)
text(1996, 20, labels=labels[min(which(Q1$Year==1996))])

################################
# PLOT 2
# A lot of medal counting goes on during the Olympics.
# We might wonder about the relationship between number of medals
# a country has and the size of its population and its wealth.
# We collected data from various sources (ManyEyes, Guardian,
# ISO) to create this data frame with GDP, population, and other information
# about each country that participated in the Olympics.

# The data frame SO2012Ctry contains this information.
# It can be loaded into R with

load(url("http://www.stanford.edu/~vcs/StatData/SummerOlympics2012Ctry.rda "))

#Q6 Take a look at the variables in this data frame.
# What kind of variable is GDP and population?
class(SO2012Ctry$GDP)
###[1] "numeric"
class(SO2012Ctry$pop)
###[1] "integer"
# What about Total?
class(SO2012Ctry$Total)
###[1] "integer"
# To examine the relationship between these three variables,
# we could consider making a scatter plot of GDP against pop
# and use plotting symbols that are proportional in size to
# the number of medals. 

# To begin, make a plot of GDP against population. 
# Which of the three principles of good graphics does this
# plot violate and why?
plot(SO2012Ctry$GDP ~ SO2012Ctry$pop)
###I think it violates all three.
###"Data Standout" - the data does not sand out here at all. It is clustered in a corner.
###"Facilitate Comparison" - this poorly constructed graph does not facilitate any kind of comparison.
###"Information Rich" - this is very poor a) use of the graphing area real estate b) labels and c) visually engagement.

#Q7. Let's examine GDP per person (create this new variable your self)
# and population. Use a log scale for both axes. Use the symbols()
# function rather than plot(), and create circles for the plotting
# symbols where the area of the circle is proportional to the 
# total number of medals.
SO2012Ctry$GDP_Prsn <- SO2012Ctry$GDP/SO2012Ctry$pop
symbols(log(SO2012Ctry$GDP_Prsn) ~ log(SO2012Ctry$pop),circles=SO2012Ctry$Total)


# Q8. It appears that the countries with no medals are circles too.
# Remake the plot, this time using only the countries that won
# medals. Then add the non-medal countries to the plot using the "." plotting
# character.
SO2012Ctry$Medals <- SO2012Ctry$Total >0
Medals <- SO2012Ctry[SO2012Ctry$Total > 0,]
symbols(log(Medals$GDP_Prsn) ~ log(Medals$pop),circles=Medals$Total)

NoMedals <-SO2012Ctry[SO2012Ctry$Total == 0,]
symbols(log(NoMedals$GDP_Prsn) ~ log(NoMedals$pop),circles=NoMedals$Total, add=TRUE, inches=FALSE)


# Q9. Make the plot information rich by adding axis labels, 
# title, and label at least 5 of the more interesting points
# with the country name. Use text() to do this.
symbols(log(Medals$GDP_Prsn) ~ log(Medals$pop), circles=sqrt(Medals$Total),
        xlab="Log of Population",
        ylab="Log of GDP per Person",
        main="Medal count by GDP and Population")
symbols(log(NoMedals$GDP_Prsn) ~ log(NoMedals$pop),circles=sqrt(NoMedals$Total), add=TRUE, inches=FALSE)
labels = as.character(Medals$Country)
text(log(Medals$pop[Medals$Country=="SouthKorea"]), log(Medals$GDP_Prsn[Medals$Country=="SouthKorea"]),
     labels="SouthKorea", col="blue") 
text(log(Medals$pop[Medals$Country=="China"]), log(Medals$GDP_Prsn[Medals$Country=="China"]),
     labels="China", col="blue") 
text(log(Medals$pop[Medals$Country=="NorthKorea"]), log(Medals$GDP_Prsn[Medals$Country=="NorthKorea"]),
     labels="NorthKorea", col="blue") 
text(log(Medals$pop[Medals$Country=="Japan"]), log(Medals$GDP_Prsn[Medals$Country=="Japan"]),
     labels="Japan", col="blue") 
text(log(Medals$pop[Medals$Country=="United States"]), log(Medals$GDP_Prsn[Medals$Country=="United States"]),
     labels="United States", col="blue") 

# PRINT A COPY OF THIS PLOT TO TURN IN.

######################################
# PLOT 4.
# Plotting to understand longitudinal relationships
# 
#Q10. Recently there was a controversy about the validation of 
# methods used in a paper published by Reinhart and Rogoff.
# See e.g. http://blog.stodden.net/2013/04/19/what-the-reinhart-rogoff-debacle-really-shows-verifying-empirical-results-needs-to-be-routine/ and http://www.bloomberg.com/news/2013-05-28/krugman-feud-with-reinhart-rogoff-escalates-as-austerity-debated.html
# We examine a subset of their data. Load the following debt/GDP ratio dataset into R:

http://www.stanford.edu/~vcs/StatData/Debt.csv
Q10 <- read.csv("http://www.stanford.edu/~vcs/StatData/Debt.csv", header = TRUE, sep =",")

#Q11. Use the plot function to plot the values of debt/GDP 
# for the four countries to show their relationship over time.
# The China values are short since we don't have as much historical data 
# from the Chinese government
plot(Q10$Year, Q10$UK, type ="l", col="red")
lines(Q10$Year, Q10$Canada, type="l", col="blue")
lines(Q10$Year, Q10$US, type="l", col="yellow")
lines(Q10$Year, Q10$China, type="l", col="green")

#Q12. Use the techniques described in class to improve the plot. 
# Explain each step you choose including why you are making the change. You
# might consider changing color, axes, labeling, legend, and others for example.
# What relationships appear?
###I made the lines thicker, and a different color for each country for easier comparison.
###I added axis ables for both X and Y, and a title for the plot. 
plot(Q10$Year, Q10$UK, type ="l", lwd=3,col="red",
     xlab = "Year",
     ylab ="Debt to GDP Ratio",
     main ="Comparison of Debt/GDP for Four Countries")
lines(Q10$Year, Q10$Canada, type="l", lwd=3, col="blue")
lines(Q10$Year, Q10$US, type="l", lwd=3, col="yellow")
lines(Q10$Year, Q10$China, type="l", lwd=3, col="green")
###I added a legend to on the top left corner. 
legend("topleft", c("UK", "Canada", "US", "China"), fill=c("red","blue","yellow", "green"), cex=0.8) 
###This plot tells us that while there are individual differences, the countries 
###(with the exception of China since we do not have data) move in unison in a large scale. 
###For example, there is a significant jump in the debt/GDP ration at the end of the 1910s, presumably 
###marking the end of WWI. 
###Again, there is a sharp decline and spike in the debt/GDP ratio folloiwng the end of WWII. 

# THIS IS THE PLOT TO PRINT AND TURN IN

##############################################
# PLOT 4

# The csv file called London2012ALL_ATHLETES.csv
# contains information about every athlete who competed 
# in the Olympics.
# Load the following dataset into R:

Q13 <- read.csv("http://www.stanford.edu/~vcs/StatData/London2012ALL_ATHLETES.csv", header= TRUE, sep =",")
                    
# There is one observation for each athlete. 
# (Actually, about 20 atheletes have two records if they
# competed in different sporting events. Let's not worry about that.)

#Q13. We are interested in the relationship between Sport and Gender. 
# What type of data is each of these variables?
class(Q13$Name)
class(Q13$Sex)
class(Q13$Sport)
class(Q13$Country)
class(Q13$MoreThan1Sport)
###They are all factor 
# How many athletes competed in the 2012 Olympics?
length(unique(Q13$Name))
###[1] 10880
# How many women competed?
summary(Q13$Sex)
###F    M 
###4835 6068 
# How many sports were there?
length(unique(Q13$Sport))
###[1] 33


# The table() function might be helpful for answering 
# some of these questions. 

#Q14. Make a barplot of Sport and Sex that emphasizes the 
# important differences. To do this, first make a table of 
# Sex by Sport. This will be the input to barplot(). 
# Make the barplot with the parameter beside = TRUE and 
# and again with beside = FALSE. Use the Brewer color 
# palette to adjust the colors as we have discussed in class.
# Explain which of these barplots provides the easiest comparison.  
Q14 <- table(Q13$Sex, Q13$Sport)
library(RColorBrewer)
barplot(Q14, col=brewer.pal(9, "Spectral"), beside=TRUE)
barplot(Q14, col=brewer.pal(9, "Spectral"), beside=FALSE)
###beside=TRUE is visually easier to draw comparisons between the two genders. 
###Although to make it even easier, I would adjust the color scheme to give "females" one color and "males" another.


#Q15. Remake the barplot above, but this time switch the order 
# of Sport and Sex in the call to table(). Use the value for
# the beside parameter that you decided was best for the 
# plot in Q14. Compare the barplot with (Sex, Sport) vs 
# (Sport, Sex). Which makes a more interesting visual comparison?
Q15 <-table(Q13$Sport, Q13$Sex)
barplot(Q15,col=brewer.pal(9, "Spectral"), beside=TRUE)
###I prefer the result in Q14 because one can compare the gender for each sport right next to each other.

# Q16. Notice that the bars are in alphabetical order by sport.
# To facilitate comparisons, we might want to arrange
# the bars in order of participation in a sport. To do this,
# call order() on the return value from making a table of Sport alone.
# Assign this vector to a variable, say orderSport.
# Then reorder your two-way table of Sport and Sex,
# using the orderSport vector and [ ] to subset the table and rearrange
# the rows/cols. The resulting barplot should show bars in 
# increasing height.
Q16 <- table(Q13$Sport)
OrderSport<- order(Q16)
Q16_2 <- Q14[,OrderSport]
barplot(Q16_2,col=brewer.pal(9, "Spectral"), beside=TRUE)

# Q17. Finally to make the plot more information rich, try turning
# the x-axis labels on their side. To do this, find a parameter
# in par() that will rotate the x-axis tick mark labels. Even though
# you found the parameter in the par() function, this
# parameter can be added in the call to barplot().
# Also find and use a parameter to shrink the text for these labels. 
# Lastly, add a title to the plot.
#THIS IS THE PLOT PRINT AND TO TURN IN
par(ps=10, cex=1, cex.lab=1)
barplot(Q16_2,col=brewer.pal(9, "Spectral"), beside=TRUE, las=2,
        main = "Number of Athletes Participating by Sport")

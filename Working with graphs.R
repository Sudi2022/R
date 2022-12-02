# load ggplot2, a commonly used library
#for building and displaying statistical graphics in R
library(ggplot2)

# access the ChickWeight data from R package
data("ChickWeight")

#if not loaded 
force(ChickWeight)

# analyze how the chickens grew over time based off of different diets
# build the dataframe object with a function that uses the name data frame 
# and two columns that are independent and dependent variables.
# Set up the grid
ggplot(ChickWeight, aes(x=Time, y=weight))
                        
# Scatter plot
# Adding a layer of plotted points to the chart
ggplot(ChickWeight, aes(x=Time, y=weight)) + 
  geom_point() 

# color coding different diets based on weight 
ggplot(ChickWeight, aes(x=Time, y=weight, color = Diet)) + 
  geom_point() 

#distinguish the results of the various diets between the chicks
#and see where they tended to end up weight-wise
ggplot(ChickWeight, aes(x=Time, y=weight, color = Diet)) + 
  geom_jitter() 

# Scatter plot with regression lines
ggplot(ChickWeight, aes(x=Time, y=weight, color = Diet)) + 
  geom_smooth() + geom_point() 

# Scatter plot with linear regression lines for a parsimonious model
ggplot(ChickWeight, aes(x=Time, y=weight, color = Diet)) + 
  geom_point()+geom_smooth(method = "lm") 

# removing point plotting which results in a much useless model
ggplot(ChickWeight, aes(x=Time, y=weight, color = Diet)) + 
  geom_smooth(method = "lm") 

# Scatter plot, linear regression without differentiation
ggplot(ChickWeight, aes(x=Time, y=weight)) + 
  geom_smooth(method = "lm") + geom_point()

# Scatter plot, linear regression without differentiation,
# and a small amount of random variation to the location of each point.
ggplot(ChickWeight, aes(x=Time, y=weight)) + 
 geom_jitter() + geom_smooth(method = "lm") 

# a specific graph for all of the types of feed
ggplot(ChickWeight, aes(x=Time, y=weight)) + 
  geom_jitter() + geom_smooth(method = "lm") + facet_wrap(~ Diet)

# a specific graph for all of the types of feed with color codes
ggplot(ChickWeight, aes(x=Time, y=weight, color=Diet)) + 
  geom_jitter() + geom_smooth(method = "lm") + facet_wrap(~ Diet)


# Histogram
# For questions such as how many chickens ended up with certain levels of weight
#Building a subset
day20 <-subset(ChickWeight, Time ==20)

#Histogram with default bin setting
ggplot(subset(ChickWeight, Time ==20), aes(x=weight)) + stat_bin()

#Histogram with a specified bin setting
ggplot(subset(ChickWeight, Time ==20), aes(x=weight)) + stat_bin(bins = 10)

# Color off the specific data on the edges with the bins filled in gray.
ggplot(day20, aes(x=weight, color=Diet)) + stat_bin(bins = 10)

#Color off the specific data by filling the bins.
ggplot(day20, aes(x=weight, fill=Diet)) + stat_bin(bins = 10)

#labeling the Histogram
ggplot(day20, aes(x=weight,fill=Diet)) + stat_bin(bins = 10) +
  labs(title="Chicken Weight", subtitle = "At the day20",
       caption ="Weight variation of chickens based on diest")

# Specify the tick marks on y axis
ggplot(day20, aes(x=weight,fill=Diet)) + stat_bin(bins = 10) +
labs(title="Chicken Weight", subtitle = "At the day20", caption ="Dietry")+
scale_y_continuous(breaks=c(0,2,4,6,8,10 ))

or 

ggplot(day20, aes(x=weight,fill=Diet)) + stat_bin(bins = 10) +
  labs(title="Chicken Weight", subtitle = "At the day20", caption ="Dietry")+
  scale_y_continuous(breaks=(0:10))

#?
gfx <- ggplot(subset(ChickWeight, Time==20),
            aes(x=weight, fill=Diet))
gfx <- gfx + stat_bin(bins=10)
gfx <- gfx + labs(title="Chicken Weight",
              subtitle="At Day 20",
              caption="Dietary Variation")
gfx <- gfx + scale_y_continuous(breaks=(1:10))

#polar coordination
#theta – a string indicating x or y, indicating what the data is that we're supposed to use
#start – at what point, in radians, the graph should start at
#direction – 1 for clockwise, -1 for counterclockwise

ggplot(day20, aes(y=weight,
                  fill=Diet)) +
  coord_polar(theta = "y", start=0,
              direction=1) +
  geom_histogram(bins=10)

coord_polar(theta = "x", start=0,
            direction=1)


canvas <- ggplot(day20, aes(x=weight, fill=Diet))
histogram <- stat_bin(bins=10)
histolabel <- labs(title="Chicken Weight", subtitle="At Day 20",
                   caption="Dietary variations for chicks")
scale <- scale_y_continuous(breaks=0:10)


#Bar Chart and aggregation
# OnLine Analytical Processing (OLAP), which is a way to interact
#with a data warehouse to perform analytics on company data

# how many chickens had a particular diet
agg<-aggregate(
  #select
  day20$weight,
  #group by
  by=list(day20$Diet),
  #the statistical function
  FUN=mean)

# the result needs to have new names 
names(agg) <- c("Diet", "weight")
# the bar chart
ggplot(agg, aes(x=Diet, weight=weight, fill=Diet)) +
  geom_bar() + ylab("Means weight of chicken per diet")


# box plot
#it is used to examine how skewed the data is


# box plot of ChickWeight data set
ggplot(ChickWeight, aes(x=weight)) + geom_boxplot()

# multiple box plots for each of the diet on the ChickWeight graph
ggplot(ChickWeight, aes(x=weight, y= Diet)) + geom_boxplot()

#split the box plots up by facet on the ChickWeight graph
ggplot(ChickWeight, aes(x=weight)) + geom_boxplot()+ facet_wrap(~Diet)


# Box plots of a subset
#assigning the subset to a variable to cut down on extra code
day20 <- subset(ChickWeight,Time==20)

# box plot of the subset
ggplot(day20, aes(x=weight)) + geom_boxplot()


# multiple box plots for each of the diet on the day20 graph
ggplot(day20, aes(x=weight,y=Diet)) + geom_boxplot()

#split the box plots up by facet on the day20 graph
ggplot(day20, aes(x=weight)) + geom_boxplot()+ facet_wrap(~Diet)
  


#Violin plots

ggplot(day20, aes(x=weight,y=Diet)) + geom_violin()

ggplot(ChickWeight, aes(x=weight,y=Diet)) + geom_violin()

# Graph lines

ChickOne = subset(ChickWeight,Chick==1)

#the line showes the weight progress of chick #1
ggplot(ChickOne, aes(x=Time, y=weight))+ geom_line()


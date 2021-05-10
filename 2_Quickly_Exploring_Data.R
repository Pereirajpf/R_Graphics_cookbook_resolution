# 2. Quickly Exploring Data

## 2.1 Scatter Plot ----
plot(mtcars $wt, mtcars$mtg)

library(ggplot2)

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()

# using vectors (not recomended, use df)
ggplot(data = NULL, aes(x = mtcars$wt, y = mtcars$mpg)) +
  geom_point()


## 2.2 Line Graph ----
plot(pressure$temperature, pressure$pressure, type="l")
points(pressure$temperature, pressure$pressure)

lines(pressure$temperature, pressure$pressure/2, col="red")
points(pressure$temperature, pressure$pressure/2, col="red")

ggplot(pressure, aes(x=temperature, y=pressure)) +
  geom_line() +
  geom_point()


## 2.3 Bar Graph----
BOB <- data.frame(Time=c(1,2,3,4,5,7),
                  demand=c(8.3,10.3,19.0,16.0,15.6,19.8))

barplot(BOB$demand, names.arg = BOB$Time)

#count graph
barplot(table(mtcars$cyl))

ggplot(BOB, aes(x=Time, y=demand)) +
  geom_col()
# so that empty columns dont apear
ggplot(BOB, aes(x=factor(Time), y=demand)) +
  geom_col()

#plot counts
ggplot(mtcars,aes(x = cyl)) +
  geom_bar()

ggplot(mtcars,aes(x = factor(cyl))) +
  geom_bar()
  

# 2.4 Histogram----
hist(mtcars$mpg)
hist(mtcars$mpg, breaks = 10)

ggplot(mtcars, aes(x=mpg)) +
  geom_histogram()
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(binwidth = 4)


# 2.5 Box Plot----
# pass a factor to x and a vector to y
plot(ToothGrowth$supp, ToothGrowth$len)

boxplot(len ~ supp, data=ToothGrowth)
boxplot(len ~ supp + dose, data=ToothGrowth)

ggplot(ToothGrowth, aes(x = supp, y = len)) +
  geom_boxplot()


# 2.6 Function Curve----
curve(x^3 - 5*x, from = -4, to = 4)

# Plot a user-defined function
myfun <- function(xvar) {
  1 / (1 + exp(-xvar + 10))
}
curve(myfun(x), from = 0, to = 20)
# Add a line:
curve(1 - myfun(x), add = TRUE, col = "red")

ggplot(data.frame(x= c(0,20)), aes(x=x)) +
  stat_function(fun = myfun, geom='line')
         
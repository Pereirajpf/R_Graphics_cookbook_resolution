# 4 Line Graphs
library(gcookbook)
library(ggplot2)
library(dplyr)

# 4.1 Making a Basic Line Graph----

ggplot(BOB,aes(x=Time,y=demand)) +
  geom_line()

BOD1 <- BOD  # Make a copy of the data
BOD1$Time <- factor(BOD1$Time)

ggplot(BOD1, aes(x = Time, y = demand, group = 1)) +
  geom_line()

# These have the same result
ggplot(BOD, aes(x = Time, y = demand)) +
  geom_line() +
  ylim(0, max(BOD$demand))

ggplot(BOD, aes(x = Time, y = demand)) +
  geom_line() +
  expand_limits(y = 0)


# 4.2 Adding Points to a Line Graph----
ggplot(BOD, aes(x=Time, y=demand)) +
  geom_line() +
  geom_point()

ggplot(worldpop, aes(x = Year, y = Population)) +
  geom_line() +
  geom_point()

# Same with a log y-axis
ggplot(worldpop, aes(x = Year, y = Population)) +
  geom_line() +
  geom_point() +
  scale_y_log10()

# 4.3 Making a Line Graph with Multiple Lines----
# Map supp to colour
ggplot(tg, aes(x=dose, y=length, colour=supp)) +
  geom_line()
# Map supp to linetype
ggplot(tg, aes(x=dose, y=length, linetype=supp)) +
  geom_line()
# Make dose a factor
ggplot(tg, aes(x = factor(dose), y = length, colour = supp, group = supp)) +
  geom_line()

ggplot(tg, aes(x = dose, y = length)) +
  geom_line()

ggplot(tg, aes(x = dose, y = length, shape = supp)) +
  geom_line() +
  geom_point(size = 4)  # Make the points a little larger

ggplot(tg, aes(x = dose, y = length, fill = supp)) +
  geom_line() +
  geom_point(size = 4, shape = 21)  # Also use a point with a color fill

# dodge points
ggplot(tg, aes(x = dose, y = length, shape = supp)) +
  geom_line(position = position_dodge(0.2)) +           # Dodge lines by 0.2
  geom_point(position = position_dodge(0.2), size = 4)  # Dodge points by 0.2

# 4.4 Changing the Appearance of Lines----
ggplot(BOB, aes(x=Time, y=demand)) +
  geom_line(linetype="dashed", size=1, colour="blue")

ggplot(tg, aes(x = dose, y = length, colour = supp)) +
  geom_line() +
  scale_colour_brewer(palette = "Set1")

# If both lines have the same properties, you need to specify a variable to
# use for grouping
ggplot(tg, aes(x = dose, y = length, group = supp)) +
  geom_line(colour = "darkgreen", size = 1.5)

# Since supp is mapped to colour, it will automatically be used for grouping
ggplot(tg, aes(x = dose, y = length, colour = supp)) +
  geom_line(linetype = "dashed") +
  geom_point(shape = 22, size = 3, fill = "white")


# 4.5 Changing the Apeearance of Points
ggplot(BOB, aes(x=Time, y=demand)) +
  geom_line() +
  geom_point(size=4, shape=22, colour="darkred", fill="pink")

ggplot(BOD, aes(x = Time, y = demand)) +
  geom_line() +
  geom_point(size = 4, shape = 21, fill = "white")

# Save the position_dodge specification because we'll use it multiple times
pd <- position_dodge(0.2)

ggplot(tg, aes(x = dose, y = length, fill = supp)) +
  geom_line(position = pd) +
  geom_point(shape = 21, size = 3, position = pd) +
  scale_fill_manual(values = c("black","white"))


# 4.6 Making a Graph with a Shared Area

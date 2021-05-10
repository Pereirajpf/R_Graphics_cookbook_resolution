# 5 Scatter Plots
library(gcookbook)
library(ggplot2)
library(dplyr)

# 5.1 Making a Basic Scatter Plot----
# Show the head of the two columns we'll use in the plot
heightweight %>%
  select(ageYear, heightIn)

ggplot(heightweight, aes(x=ageYear, y=heightIn)) +
  geom_point()

ggplot(heightweight, aes(x=ageYear, y=heightIn)) +
  geom_point(shape=21)

ggplot(heightweight, aes(x = ageYear, y = heightIn)) +
  geom_point(size = 1.5)


# 5.2 Grouping Points Together using Shapes or Colors----
ggplot(heightweight, aes(x = ageYear, y = heightIn, shape = sex, colour = sex)) +
  geom_point()

ggplot(heightweight, aes(x = ageYear, y = heightIn, shape = sex, colour = sex)) +
  geom_point() +
  scale_shape_manual(values = c(1,2)) +
  scale_colour_brewer(palette = "Set1")


# 5.3 Using Different Point Shapes----
ggplot(heightweight, aes(x=ageYear, y=heightIn)) +
  geom_point(shape=3)

# Use slightly larger points and use custom values for the shape scale
ggplot(heightweight, aes(x = ageYear, y = heightIn, shape = sex)) +
  geom_point(size = 3) +
  scale_shape_manual(values = c(1, 4))

hw <- heightweight %>%
  mutate(weightgroup = ifelse(weightLb < 100, "< 100", ">= 100"))

# Specify shapes with fill and color, and specify fill colors that includes an empty (NA) color
ggplot(hw, aes(x = ageYear, y = heightIn, shape = sex, fill = weightgroup)) +
  geom_point(size = 2.5) +
  scale_shape_manual(values = c(21, 24)) +
  scale_fill_manual(
    values = c(NA, "black"),
    guide = guide_legend(override.aes = list(shape = 21))
  )


# 5.4 Mapping a Continuous Variable to Color or Size----
ggplot(heightweight, aes(x = ageYear, y = heightIn, colour = weightLb)) +
  geom_point()

ggplot(heightweight, aes(x = ageYear, y = heightIn, size = weightLb)) +
  geom_point()

range(heightweight$weightLb)
#> [1]  50.5 171.5
size_range <- range(heightweight$weightLb) / max(heightweight$weightLb) *  6
size_range
#> [1] 1.766764 6.000000

ggplot(heightweight, aes(x = ageYear, y = heightIn, size = weightLb)) +
  geom_point() +
  scale_size_continuous(range = size_range)

ggplot(heightweight, aes(x = ageYear, y = heightIn, size = weightLb)) +
  geom_point() +
  scale_size_area()


# 5.5 Dealing with Overplotting
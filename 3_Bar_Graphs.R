# 3 Bar Graphs
library(gcookbook)
library(ggplot2)
library(dplyr)
# 3.1 Making Basic Bar Graph----
ggplot(pg_mean, aes(x=group, y=weight)) +
  geom_col()

BOB
str(BOB)
ggplot(BOB, aes(x = Time, y = demand)) +
  geom_col()

ggplot(BOB, aes(x = factor(Time), y = demand)) +
  geom_col()

# change colours
ggplot(pg_mean, aes(x = group, y = weight)) +
  geom_col(fill = "lightblue",colour = "black")


# 3.2 Grouping Bars Together----
cabbage_exp

ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_col(position="dodge")
#position dodge makes the bars be side-by-side, if empty they will be staked

#change appearance
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_col(position="dodge", colour="black") +
  scale_fill_brewer(palette="Pastel1")

ce <- cabbage_exp[1:5, ]
ce
ggplot(ce, aes(x = Date, y = Weight, fill = Cultivar)) +
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1")


# 3.3 Making a Bar Graph of Counts----
ggplot(diamonds, aes(x=cut)) +
  geom_bar()

ggplot(diamonds, aes(x=carat)) +
  geom_bar()

ggplot(diamonds, aes(x=carat)) +
  geom_histogram()


# 3.4 Using Colors in a Bar Graph----
upc <- uspopchange %>%
  arrange(desc(Change)) %>%
  slice(1:10)

ggplot(upc, aes(x = Abb, y = Change, fill = Region)) +
  geom_col()

ggplot(upc, aes(x = reorder(Abb,Change), y = Change, fill = Region)) +
  geom_col(colour= "black") +
  scale_fill_manual(values = c("#669933", "#FFCC66")) +
  xlab("State")
# Reorder used to order the bars


# 3.5 Coloring Negative and Positive Bars Differently----
climate_sub <- climate %>%
  filter(Source == "Berkeley" & Year >= 1900) %>%
  mutate(pos = Anomaly10y >= 0)

ggplot(climate_sub, aes(x=Year, y=Anomaly10y, fill=pos)) +
  geom_col(position="identity")

ggplot(climate_sub, aes(x=Year, y=Anomaly10y, fill=pos)) +
  geom_col(position="identity", colour="black", size=0.25) +
  scale_fill_manual(values = c("#CCEEFF", "#FFDDDD"),guide=F)


# 3.6 Adjusting Bar Width and Spacing----
ggplot(pg_mean, aes(x = group, y = weight)) +
  geom_col()

ggplot(pg_mean, aes(x = group, y = weight)) +
  geom_col(width=0.5)

ggplot(pg_mean, aes(x = group, y = weight)) +
  geom_col(width=1)

ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) +
  geom_col(width = 0.5, position = "dodge")

ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) +
  geom_col(width = 0.5, position = position_dodge(0.7))


# 3.7 Making a Stacked Bar Graph----
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_col() 

ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_col(position = position_stack(reverse = T)) +
  guides(fill = guide_legend(reverse = T))

ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) +
  geom_col(colour = "black") +
  scale_fill_brewer(palette = "Pastel1")


# 3.8 Making a Porportional Stacked Bar----
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_col(position = "fill")

ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) +
  geom_col(position = "fill") +
  scale_y_continuous(labels = scales::percent)

ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) +
  geom_col(position = "fill", colour="black") +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_brewer(palette = "Pastel1")

ce <- cabbage_exp %>%
  group_by(Date) %>%
  mutate(percent_weight = Weight / sum(Weight) * 100)

ggplot(ce, aes(x = Date, y = percent_weight, fill = Cultivar)) +
  geom_col()


# 3.9 Adding Labels to a Bar Graph----
# Beloow the top
ggplot(cabbage_exp, aes(x= interaction(Date, Cultivar), y=Weight)) +
  geom_col() +
  geom_text(aes(label=Weight), vjust=1.5, colour="white")
# Above the top
ggplot(cabbage_exp, aes(x = interaction(Date, Cultivar), y = Weight)) +
  geom_col() +
  geom_text(aes(label = Weight), vjust = -0.2)

ggplot(mtcars, aes(x = factor(cyl))) +
  geom_bar() +
  geom_text(aes(label = ..count..), stat = "count", vjust = 1.5, colour = "white")

# Adjust y limits to be a little higher
ggplot(cabbage_exp, aes(x = interaction(Date, Cultivar), y = Weight)) +
  geom_col() +
  geom_text(aes(label = Weight), vjust = -0.2) +
  ylim(0, max(cabbage_exp$Weight) * 1.05)

# Map y positions slightly above bar top - y range of plot will auto-adjust
ggplot(cabbage_exp, aes(x = interaction(Date, Cultivar), y = Weight)) +
  geom_col() +
  geom_text(aes(y = Weight + 0.1, label = Weight))

ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_col(position = "dodge") +
  geom_text(aes(label= Weight),
            colour="white", size=3,
            vjust=1.5, position = position_dodge(0.9))

ce <- cabbage_exp %>% 
  arrange(Date, rev(Cultivar))

ce <- ce %>% 
  group_by(Date) %>% 
  mutate(label_y = cumsum(Weight))

ggplot(ce, aes(x=Date, y=Weight, fill=Cultivar))+
  geom_col() +
  geom_text(aes(y=label_y, label=Weight),
            vjust=1.5,colour="white")


ce <- cabbage_exp %>%
  arrange(Date, rev(Cultivar))

# Calculate y position, placing it in the middle
ce <- ce %>%
  group_by(Date) %>%
  mutate(label_y = cumsum(Weight) - 0.5 * Weight)

ggplot(ce, aes(x = Date, y = Weight, fill = Cultivar)) +
  geom_col() +
  geom_text(aes(y = label_y, label = Weight), colour = "white")

ggplot(ce, aes(x = Date, y = Weight, fill = Cultivar)) +
  geom_col(colour = "black") +
  geom_text(aes(y = label_y, label = paste(format(Weight, nsmall = 2), "kg")), size = 4) +
  scale_fill_brewer(palette = "Pastel1")


# 3.10 Making a Cleveland Dot Plot
tophit <- tophitters2001[1:25, ] # Take the top 25 from the tophitters data set

ggplot(tophit, aes(x=avg, y=name)) +
  geom_point()

ggplot(tophit, aes(x=avg, y=reorder(name, avg))) +
  geom_point(size=3) +
  theme_bw() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_line(colour="grey60", linetype="dashed")
  )

ggplot(tophit, aes(x=reorder(name, avg), y=avg)) +
  geom_point(size=3) +
  theme_bw() +
  theme(
    panel.grid.major.y = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.grid.major.x = element_line(colour="grey60", linetype="dashed"),
    axis.text.x = element_text(angle = 60, hjust = 1)
  )

# Get the names, sorted first by lg, then by avg
nameorder <- tophit$name[order(tophit$lg, tophit$avg)]

# Turn name into a factor, with levels in the order of nameorder
tophit$name <- factor(tophit$name, levels = nameorder)

ggplot(tophit, aes(x=avg, y=name)) +
  geom_segment(aes(yend = name), xend = 0, colour = "grey50") +
  geom_point(size=3, aes(colour=lg)) +
  scale_colour_brewer(palette="Set1", limits=c("NL","AL")) +
  theme_bw() +
  theme(
    panel.grid.major.y = element_blank(),   # No horizontal grid lines
    legend.position = c(1, 0.55),           # Put legend inside plot area
    legend.justification = c(1, 0.5)
  )

ggplot(tophit, aes(x = avg, y = name)) +
  geom_segment(aes(yend = name), xend = 0, colour = "grey50") +
  geom_point(size = 3, aes(colour = lg)) +
  scale_colour_brewer(palette = "Set1", limits = c("NL", "AL"), guide = FALSE) +
  theme_bw() +
  theme(panel.grid.major.y = element_blank()) +
  facet_grid(lg ~ ., scales = "free_y", space = "free_y")

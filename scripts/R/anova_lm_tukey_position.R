library(stats)
library(tidyverse)

# Load the data
bmi <- read.csv("bmi.csv")
players <- read.csv("players.csv")

# Remove the last three rows of the players dataset
players <- players[1:(nrow(players) -3),] 

# join on bmi_id

players_bmi <- players |>
  inner_join(bmi, by = 'bmi_id')

#save players_bmi
write.csv(players_bmi, 'players_bmi.csv', row.names = TRUE)

#Load the players_bmi dataset
players_bmi <- read.csv("players_bmi.csv")

#Plot BMI by Position
players_bmi |>
  ggplot(aes(x=fct_reorder(position, bmi, median), y = bmi)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = 'BMI by Position (median order)',
       x = 'Position',
       y = 'BMI')

#Run ANOVA
anova_position <- aov(bmi ~ position, data = players_bmi)
summary(anova_position)

#Run Tukey's HSD test
tukey_position <- TukeyHSD(anova_position)
print(tukey_position)

#Convert tukey result to df and save
tukey_df <- as.data.frame(tukey_result$position)
write.csv(tukey_df, 'tukey_bmi_position.csv', row.names = TRUE)

#Linear model of bmi by position
lm_position <- lm(bmi ~ position, data = players_bmi)
summary(lm_position)


#Multivariate linear model of bmi by position and age
lm_position_age <- lm(bmi ~ position + age, data = players_bmi)
summary(lm_position_age)



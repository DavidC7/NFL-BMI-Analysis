library(tidyverse)
library(effectsize)

#Load data
units_bmi <- read.csv('raw_bmi_by_units.csv')

#filter offense and defense units
off_def <- subset(units_bmi, unit %in% c('Offense', 'Defense'))

#run t-test
t.test(bmi ~ unit, data = off_def)

#run cohens D
cohens_d(bmi ~ unit, data = off_def)

#Density of Offense and Defense BMI

off_def |>
  ggplot( aes(x = bmi, color = unit, fill = unit )) +
  geom_density(alpha = .5) +
  theme_minimal() +
  labs(title = 'BMI Density of Offensive and Defensive Players',
       x = 'BMI',
       y = 'Density') 


  

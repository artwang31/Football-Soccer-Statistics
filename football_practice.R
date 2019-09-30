library(tidyverse)
library(dplyr)

results <- intl.football.results
results1 <- results[ , c("home_team","away_team","home_score","away_score")]
results10 <- results[1:10, c("home_team","away_team","home_score","away_score")]

results1$who_wins <- with(results1,
                           ifelse(home_score > away_score, results10$home_team,
                                  ifelse(home_score < away_score, results$away_team, 0)))

final <- results1$who_wins
finaldeck <- data.frame(results1)

numberdistinctwinners <- finaldeck %>%         
  summarise(n_unique = n_distinct(who_wins))

finalcsv <- finaldeck %>%
 group_by(who_wins) %>% count('who_wins')
 
write.csv(finalcsv, 'finalfooty.csv')               

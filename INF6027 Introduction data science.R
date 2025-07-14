# Load necessary libraries
library(dplyr)
library(ggplot2)
library(tidyr)

# Load datasets
results <- read.csv("C:/Users/64371/Documents/r/results.csv")
goalscorers <- read.csv("C:/Users/64371/Documents/r/goalscorers.csv")
shootouts <- read.csv("C:/Users/64371/Documents/r/shootouts.csv")

# Inspect data structure and summary
str(results)
summary(results)

# Create a match result column (Home Win, Away Win, Draw)
results <- results %>%
  mutate(match_result = case_when(
    home_score > away_score ~ "Home Win",
    home_score < away_score ~ "Away Win",
    home_score == away_score ~ "Draw"
  ))

# Classify venue type: Neutral or Home/Away
results <- results %>%
  mutate(venue_type = ifelse(neutral == TRUE, "Neutral", "Home/Away"))

# Count number of matches by Venue Type and Match Outcome
table2 <- results %>%
  group_by(venue_type, match_result) %>%
  summarise(num_matches = n()) %>%
  arrange(desc(venue_type), match_result)
# English: Count the number of matches for each combination of venue and result

# Add percentage column
table2 <- table2 %>%
  mutate(percentage = round(100 * num_matches / sum(num_matches), 1))


# View the output
print(table2)

# Summarise venue type counts
venue_summary <- results %>%
  mutate(venue_type = ifelse(neutral == TRUE, "Neutral Venue", "Home/Away Matches")) %>%
  group_by(venue_type) %>%
  summarise(count = n()) %>%
  mutate(percentage = round(100 * count / sum(count), 2),
         label = paste0(venue_type, "\n", percentage, "%"))

# Plot pie chart
ggplot(venue_summary, aes(x = "", y = count, fill = venue_type)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) +
  geom_text(aes(label = label), position = position_stack(vjust = 0.5), size = 5) +
  scale_fill_manual(values = c("skyblue", "lightcoral")) +
  theme_void() +
  ggtitle("Figure 2: Proportional Distribution of Matches by Venue Type")

# Prepare home win rate by year
yearly_summary <- results %>%
  filter(neutral == FALSE) %>%  # exclude neutral matches
  mutate(year = as.numeric(substr(date, 1, 4)),
         match_result = case_when(
           home_score > away_score ~ "Home Win",
           home_score < away_score ~ "Away Win",
           home_score == away_score ~ "Draw"
         )) %>%
  group_by(year) %>%
  summarise(
    total = n(),
    home_wins = sum(match_result == "Home Win"),
    home_win_rate = 100 * home_wins / total
  )

# Plot with historical era lines and labels
ggplot(yearly_summary, aes(x = year, y = home_win_rate)) +
  geom_point(color = "red", alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, color = "blue", size = 1) +
  geom_vline(xintercept = c(1900, 1913, 1918, 1945, 1994, 2001), 
             linetype = "dashed", color = "gray40") +
  annotate("text", x = 1875, y = 95, label = "Early Rules\n(1872–1900)", color = "purple") +
  annotate("text", x = 1905, y = 90, label = "Modern Rules\n(1901–1913)", color = "purple") +
  annotate("text", x = 1916, y = 75, label = "WWI\n(1914–1918)", color = "purple") +
  annotate("text", x = 1930, y = 30, label = "WWII\n(1939–1945)", color = "purple") +
  annotate("text", x = 1965, y = 70, label = "Broadcast Era\n(1951–1994)", color = "purple") +
  annotate("text", x = 1995, y = 70, label = "Bosman Ruling\n(1995)", color = "purple") +
  annotate("text", x = 2015, y = 35, label = "Global Era\n(2001–2017)", color = "purple") +
  labs(
    title = "Figure 3: Trends in Home Win Rates Across Historical Eras",
    x = "Year",
    y = "Home Win Rate (%)"
  ) +
  theme_minimal(base_size = 14)

# Extract home and away goals separately
home_goals <- results$home_score
away_goals <- results$away_score

# Compare average goals
mean_home_goals <- mean(home_goals, na.rm = TRUE)
mean_away_goals <- mean(away_goals, na.rm = TRUE)

# Two-sample t-test
t_test_result <- t.test(home_goals, away_goals, var.equal = FALSE)

# View results
cat("Mean Home Goals: ", round(mean_home_goals, 2), "\n")
cat("Mean Away Goals: ", round(mean_away_goals, 2), "\n")
print(t_test_result)



# Derive match result outcome (home win, draw, away win)
results <- results %>%
  mutate(match_result = case_when(
    home_score > away_score ~ "Home Win",
    home_score < away_score ~ "Away Win",
    TRUE ~ "Draw"
  ))

# Tag venue type
results <- results %>%
  mutate(venue_type = ifelse(neutral == TRUE, "Neutral", "Home/Away"))

# Calculate win rates per venue type and outcome
win_rate_table <- results %>%
  group_by(venue_type, match_result) %>%
  summarise(num_matches = n()) %>%
  group_by(venue_type) %>%
  mutate(percentage = round(100 * num_matches / sum(num_matches), 1))

# compare the outcome
ggplot(win_rate_table, aes(x = venue_type, y = percentage, fill = match_result)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8), width = 0.7) +
  geom_text(aes(label = paste0(percentage, "%")), 
            position = position_dodge(width = 0.8), 
            vjust = -0.5, size = 4) +
  scale_fill_manual(values = c("Home Win" = "gold", 
                               "Away Win" = "blue", 
                               "Draw" = "red")) +
  labs(title = "Comparative Win Rates Across Match Venues",
       x = "Match Venue",
       y = "Win Rate (%)",
       fill = "Outcome Type") +
  theme_minimal(base_size = 14)

# Create a summary table of penalty and own goals by match location
summary_table <- goalscorers %>%
  mutate(location = ifelse(team == home_team, "Home", "Away")) %>%  # Classify goal as Home or Away
  group_by(location) %>%
  summarise(
    total_goals = n(),                          # Total number of goals
    penalty_goals = sum(penalty == TRUE),       # Number of penalties
    own_goals = sum(own_goal == TRUE)           # Number of own goals
  ) %>%
  mutate(
    penalty_rate = round(100 * penalty_goals / total_goals, 3),     # Penalty rate (%)
    own_goal_rate = round(100 * own_goals / total_goals, 3)         # Own goal rate (%)
  )

# Display the summary table 
print(summary_table)

# Reshape data to long format for plotting
plot_data <- summary_table %>%
  select(location, penalty_rate, own_goal_rate) %>%
  pivot_longer(cols = c(penalty_rate, own_goal_rate),
               names_to = "type",
               values_to = "rate")

# Rename types for better x-axis labels
plot_data$type <- factor(plot_data$type,
                         levels = c("penalty_rate", "own_goal_rate"),
                         labels = c("Penalty Rate (%)", "Own Goal Rate (%)"))

# Create bar plot
ggplot(plot_data, aes(x = location, y = rate, fill = location)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.6) +
  geom_text(aes(label = round(rate, 2)), vjust = -0.5, size = 5) +
  facet_wrap(~type, scales = "free_y") +
  labs(x = "Location", y = "Rate (%)",
       title = "Figure 5: Comparative Penalty and Own Goal Rates Across Locations") +
  scale_fill_manual(values = c("Home" = "gold", "Away" = "skyblue")) +
  theme_minimal(base_size = 14)

# Add match outcome column
results <- results %>%
  mutate(result = case_when(
    home_score > away_score ~ "Home Win",
    home_score < away_score ~ "Away Win",
    TRUE ~ "Draw"
  ))

# Add venue type (Home/Away or Neutral)
results <- results %>%
  mutate(venue_type = ifelse(neutral == TRUE, "Neutral", "Home/Away"))

# Summarise match outcomes by tournament and venue type
summary_table <- results %>%
  group_by(tournament, venue_type, result) %>%
  summarise(count = n(), .groups = "drop") %>%
  group_by(tournament, venue_type) %>%
  mutate(total_matches = sum(count)) %>%
  pivot_wider(names_from = result, values_from = count, values_fill = 0) %>%
  mutate(
    `Home Win Rate (%)` = round(`Home Win` / total_matches * 100, 2),
    `Away Win Rate (%)` = round(`Away Win` / total_matches * 100, 2),
    `Draw Rate (%)` = round(Draw / total_matches * 100, 2)
  ) %>%
  arrange(desc(total_matches))
print(summary_table)

# Count the number of matches for each result type
overall_outcomes <- results %>%
  count(result) %>%
  mutate(result = factor(result, levels = c("Away Win", "Draw", "Home Win")))

# Plot the overall match outcome distribution
ggplot(overall_outcomes, aes(x = result, y = n, fill = result)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = n), vjust = -0.3, size = 5) +
  scale_fill_manual(values = c("Away Win" = "blue", "Draw" = "red", "Home Win" = "gold")) +
  labs(x = "Outcome Type", y = "Number of Matches",
       title = "Figure 6: Match Outcomes by Venue") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))

# create table
team_confed <- tibble::tibble(
  country = c("England", "Scotland", "Germany", "France", "Brazil", "Argentina", "Nigeria", "Egypt", "USA", "Mexico", "Japan", "South Korea", "New Zealand", "Australia", "Spain", "Italy"),
  confederation = c("UEFA", "UEFA", "UEFA", "UEFA", "CONMEBOL", "CONMEBOL", "CAF", "CAF", "CONCACAF", "CONCACAF", "AFC", "AFC", "OFC", "OFC", "UEFA", "UEFA")
)

# reate match outcome result（Home Win, Away Win, Draw）
results <- results %>%
  mutate(result = case_when(
    home_score > away_score ~ "Home Win",
    home_score < away_score ~ "Away Win",
    TRUE ~ "Draw"
  ))

# Join confederation info based on home_team
results <- results %>%
  left_join(team_confed, by = c("home_team" = "country"))

# Summarize result counts by confederation
table4 <- results %>%
  group_by(confederation, result) %>%
  summarise(count = n(), .groups = "drop") %>%
  tidyr::pivot_wider(names_from = result, values_from = count, values_fill = 0) %>%
  mutate(
    total_matches = `Home Win` + `Away Win` + Draw,
    `Home Win Rate (%)` = round(`Home Win` / total_matches * 100, 2),
    `Away Win Rate (%)` = round(`Away Win` / total_matches * 100, 2),
    `Draw Rate (%)`     = round(Draw / total_matches * 100, 2)
  ) %>%
  select(
    Confederation = confederation,
    `Home Win Rate (%)`,
    `Away Win Rate (%)`,
    `Draw Rate (%)`
  )

# display result
print(table4)

# Convert table4 to long format
table4_long <- table4 %>%
  pivot_longer(cols = c(`Home Win Rate (%)`, `Away Win Rate (%)`, `Draw Rate (%)`),
               names_to = "Outcome Type", values_to = "Rate (%)")

# Optional: Rename Outcome Types for cleaner axis labels
table4_long$`Outcome Type` <- recode(table4_long$`Outcome Type`,
                                     "Home Win Rate (%)" = "HomeWinRate",
                                     "Away Win Rate (%)" = "AwayWinRate",
                                     "Draw Rate (%)" = "DrawRate")

# Create heatmap plot
ggplot(table4_long, aes(x = `Outcome Type`, y = Confederation, fill = `Rate (%)`)) +
  geom_tile(color = "white") +
  geom_text(aes(label = `Rate (%)`), color = "black", size = 4.5) +
  scale_fill_gradient(low = "yellow", high = "gold") +
  labs(
    x = "Outcome Type",
    y = "Confederation",
    fill = "Rate (%)",
    title = "Figure 7: Confederation-Wise Match Outcome Rates"
  ) +
  theme_minimal(base_size = 14)

# Step 1: Create goal_difference column
results <- results %>%
  mutate(goal_difference = home_score - away_score)

# Step 2: Categorize goal difference into groups for Table 6
table6 <- results %>%
  mutate(diff_group = case_when(
    goal_difference < -4 ~ "<-4 (Away team dominates)",
    goal_difference == -4 ~ "-4",
    goal_difference == -3 ~ "-3",
    goal_difference == -2 ~ "-2",
    goal_difference == -1 ~ "-1",
    goal_difference == 0 ~ "0 (Draws)",
    goal_difference == 1 ~ "1",
    goal_difference == 2 ~ "2",
    goal_difference == 3 ~ "3",
    goal_difference == 4 ~ "4",
    goal_difference > 4 ~ ">4 (Home team dominates)"
  )) %>%
  count(diff_group, name = "Number of Matches") %>%
  mutate(Percentage = round(`Number of Matches` / sum(`Number of Matches`) * 100, 2)) %>%
  arrange(factor(diff_group, levels = c(
    "<-4 (Away team dominates)", "-4", "-3", "-2", "-1", 
    "0 (Draws)", "1", "2", "3", "4", 
    ">4 (Home team dominates)"
  )))

# View Table 6
print(table6)

#Calculate goal difference
results <- results %>%
  mutate(goal_difference = home_score - away_score)

#Filter out extreme values
filtered_data <- results %>%
  filter(goal_difference >= -10 & goal_difference <= 10)

#Count frequency
goal_diff_counts <- filtered_data %>%
  count(goal_difference) %>%
  arrange(goal_difference)

# Step 4: Draw the bar chart
ggplot(goal_diff_counts, aes(x = goal_difference, y = n)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_text(aes(label = n), vjust = -0.5, size = 3) +
  labs(
    title = "Figure 8: Goal Difference (Home - Away)",
    x = "Goal Difference (Home - Away)",
    y = "Frequency"
  ) +
  theme_minimal()

library(dplyr)

# Extract the first goal from each match
first_goal <- goal_scorers %>%
  arrange(date, minute) %>%
  group_by(date, home_team, away_team) %>%
  slice_head(n = 1) %>%
  ungroup()

# Add match result information
match_results <- results %>%
  mutate(result = case_when(
    home_score > away_score ~ "Home Team",
    home_score < away_score ~ "Away Team",
    TRUE ~ "None (Draw)"
  )) %>%
  select(date, home_team, away_team, result)

# Combine and generate 'First Shooter' and 'Winner' columns
table7_data <- first_goal %>%
  mutate(first_shooter = case_when(
    team == home_team ~ "Home Team",
    team == away_team ~ "Away Team",
    TRUE ~ "Unknown"
  )) %>%
  select(date, home_team, away_team, first_shooter) %>%
  left_join(match_results, by = c("date", "home_team", "away_team")) %>%
  rename(winner = result)

# Include matches with no goals (i.e., not present in goal_scorers)
no_first_goal <- results %>%
  anti_join(first_goal, by = c("date", "home_team", "away_team")) %>%
  mutate(first_shooter = "None") %>%
  mutate(winner = case_when(
    home_score > away_score ~ "Home Team",
    away_score > home_score ~ "Away Team",
    TRUE ~ "None (Draw)"
  )) %>%
  select(date, home_team, away_team, first_shooter, winner)

# Combine all match information
combined <- bind_rows(table7_data, no_first_goal)

# Generate frequency and percentage table
summary_table7 <- combined %>%
  count(first_shooter, winner, name = "Frequency") %>%
  mutate(Percentage = round(Frequency / sum(Frequency) * 100, 2)) %>%
  arrange(desc(Frequency))

# Display the final summary table
print(summary_table7)


#Extract the first goal for each match
first_goal <- goalscorers %>%
  arrange(date, minute) %>%
  group_by(date, home_team, away_team) %>%
  slice_head(n = 1) %>%
  ungroup()

# Merge first goal data with match results
combined_data <- first_goal %>%
  left_join(results, by = c("date", "home_team", "away_team"))

# Determine match winner
combined_data <- combined_data %>%
  mutate(
    winner = case_when(
      home_score > away_score ~ "Home Team",
      home_score < away_score ~ "Away Team",
      TRUE ~ "None (Draw)"
    ),
    first_shooter = case_when(
      team == home_team ~ "Home Team",
      team == away_team ~ "Away Team",
      TRUE ~ "None"
    )
  )

# Create summary table for first shooter vs match outcome (Table 7)
table7 <- combined_data %>%
  count(first_shooter, winner, name = "Frequency") %>%
  group_by(first_shooter) %>%
  mutate(`Percentage (%)` = round(Frequency / sum(Frequency) * 100, 2)) %>%
  ungroup() %>%
  arrange(first_shooter, desc(Frequency))

# View Table 7
print(table7)

# Create 5-minute interval groups (0–5, 5–10, ..., 90–95)
goalscorers <- goalscorers %>%
  mutate(minute_group = cut(
    minute,
    breaks = seq(0, 95, by = 5),
    include.lowest = TRUE,
    right = FALSE,
    labels = paste0("[", seq(0, 90, by = 5), ",", seq(5, 95, by = 5), ")")
  ))

# Count number of goals in each 5-minute group
minute_summary <- goalscorers %>%
  count(minute_group, name = "Goal_Count")

# Plot bar chart (Figure 9)
ggplot(minute_summary, aes(x = minute_group, y = Goal_Count)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  geom_text(aes(label = Goal_Count), vjust = -0.3, size = 3) +
  labs(
    title = "Figure 9: Goal Distribution by Minute Group (5-Minute Intervals)",
    x = "Minute Group",
    y = "Number of Goals"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(face = "bold", size = 12)
  )

# Create 5-minute interval groups for each goal
goalscorers <- goalscorers %>%
  mutate(minute_group = cut(
    minute,
    breaks = seq(0, 95, by = 5),
    include.lowest = TRUE,
    right = FALSE,
    labels = paste0("[", seq(0, 90, by = 5), ",", seq(5, 95, by = 5), ")")
  ))

# Classify each goal as Home or Away
goalscorers <- goalscorers %>%
  mutate(goal_type = case_when(
    team == home_team ~ "Home",
    team == away_team ~ "Away",
    TRUE ~ "Unknown"
  ))

# Count number of goals by minute group and goal type
goal_summary <- goalscorers %>%
  filter(goal_type %in% c("Home", "Away")) %>%
  count(minute_group, goal_type, name = "Goal_Count")

# Plot Figure 10: Stacked bar chart
ggplot(goal_summary, aes(x = Goal_Count, y = minute_group, fill = goal_type)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = Goal_Count), 
            position = position_stack(vjust = 0.5), 
            size = 3, color = "black") +
  labs(
    title = "Figure 10: Comparison of Home and Away Goals by Minute Group",
    x = "Number of Goals",
    y = "Minute Group",
    fill = "Goal Type"
  ) +
  scale_fill_manual(values = c("Home" = "#00BFC4", "Away" = "#F8766D")) +
  theme_minimal() +
  theme(
    legend.position = "right",
    plot.title = element_text(face = "bold", size = 12)
  )


# Analyzing Influencing Factors and Match Outcomes in International Football

## Overview

This project explores international football match trends and dynamics using a dataset of over 47,000 matches spanning from 1872 to 2017. The research focuses on uncovering insights into home advantage, temporal scoring patterns, confederation-wise performance, and match outcomes. It incorporates a distributional approach, statistical testing, and predictive modeling techniques using R and Python.

The project is structured to support both exploratory data analysis (EDA) and machine learning modeling. Key components include data preprocessing, descriptive and inferential statistics, and classification modeling to predict match results.

## Dataset

**Dataset Name:** International Football Results  
**Source:** [Kaggle](https://www.kaggle.com/datasets/martj42/international-football-results-from-1872-to-2017)  
**Description:** A dataset of international football matches with detailed records on scores, venues, and match types.  
Three primary files:
- `results.csv`: match-level outcomes
- `goalscorers.csv`: player-level goal information
- `shootouts.csv`: penalty shootout results

These provide a robust foundation for match trend analysis and classification modeling.

---

## Key Analyses and Visualizations

### 1. Venue-Based Outcome Analysis
- Classified matches into "Neutral" or "Home/Away" venues.
- Compared win rates by venue using bar charts and summary tables.

### 2. Home Win Rate Across History
- Analyzed annual home win rates excluding neutral venues.
- Visualized trends with historical era annotations and linear regression.

### 3. Goal Scoring Comparison
- Compared average goals scored by home and away teams.
- Conducted two-sample t-test for statistical significance.

### 4. Penalty and Own Goal Rate
- Calculated and visualized penalty and own goal rates for home vs away goals using grouped bar charts.

### 5. Tournament and Venue Outcome Rates
- Aggregated match outcomes by tournament type and venue.
- Generated summary tables with win/draw percentages.

### 6. Outcome Distribution and Confederation Comparison
- Bar charts for overall match result distribution.
- Heatmap comparing win/draw rates across confederations.

### 7. Score Difference Trends
- Grouped and visualized match score differences using bar charts.
- Created a histogram-like plot for range [-10, 10].

### 8. First Goal Impact
- Linked first scorer team to final match outcomes.
- Analyzed influence of scoring first using summary tables.

### 9. Goal Timing Patterns
- Counted goals by 5-minute intervals.
- Produced two figures:
  - Total goal distribution by minute group.
  - Stacked bar chart comparing home vs away goals across time.

---

## How to Run

### 1. Environment Requirements

- R version 4.0+
- Required packages:
  - `dplyr`
  - `ggplot2`
  - `tidyr`
  - `tibble`

Install missing packages:

```r
install.packages(c("dplyr", "ggplot2", "tidyr", "tibble"))
```

### 2. File Structure

```
project_root/
├── data/
│ ├── goalscorers.csv
│ ├── results.csv
│ ├── shootouts.csv
│ └── results_summary_classified.csv
├── scripts/
│ ├── confederation_match_outcome_rates_table_heatmap.R
│ ├── first_shooter_analysis.R
│ ├── goal_difference_analysis.R
│ ├── goal_time_distribution.R
│ ├── home_advantage_analysis.R
│ ├── home_win_rate_analysis.R
│ ├── match_outcome_distribution.R
│ ├── match_outcomes_by_venue.R
│ └── penalty_own_goal_analysis.R
├── ml/
│ ├── train_model.py
│ └── train_model.R
├── outputs/
│ ├── visuals/
│ │ ├── Match Outcome Distribution.png
│ │ ├── Summary of Penalty and Own Goals.png
│ │ └── more_visuals...
│ └── tables/
│ ├── match_outcomes_by_venue.csv
│ ├── summary_penalty_own_goals.csv
│ └── more_tables...
└── README.md
```

### 3. Execution

In R:

```r
source("INF6027 Introduction data science.R")
```

Visualizations will be displayed in the default R plot window. Tables will be printed in the console.

---

## Results Summary

- **Visualizations**: 
  - Venue-based win rate bar charts  
  - Temporal home win rate line plots  
  - Score difference distribution bars  
  - Confederation-wise heatmaps  
- **Statistical Methods**: 
  - Welch t-tests (goal scoring differences)  
  - Win-rate percentage computation  
- **Insights**: 
  - Confirmed home advantage persists across venues  
  - First scorer has predictive impact on match result  
  - Confed. like CONMEBOL show strongest home-field bias


---

## License

This project is licensed under the MIT License – you are free to use, adapt, and share it.

---

## Acknowledgments

Thanks to the dataset providers and the R community for essential open-source packages.

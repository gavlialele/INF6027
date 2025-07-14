# International Football Match Insights (INF6027 – Introduction to Data Science)

## Overview

This project explores trends and statistical insights in international football matches using R and various visualization techniques. The analysis includes match outcomes, venue effects, historical patterns, goal scoring behavior, confederation comparisons, and time-based scoring trends.

---

## Dataset

**Dataset Files:**

- `results.csv`: Match metadata including scores, venues, and dates.
- `goalscorers.csv`: Details of goal scorers and timing.
- `shootouts.csv`: Records of penalty shootouts.

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
├── INF6027 Introduction data science.R   # Main analysis script
├── goalscorers.csv                       # Goal details
├── results.csv                           # Match metadata
├── shootouts.csv                         # Penalty shootout data
```

### 3. Execution

In R:

```r
source("INF6027 Introduction data science.R")
```

Visualizations will be displayed in the default R plot window. Tables will be printed in the console.

---

## Results Summary

- Charts: Pie charts, bar plots, line graphs, stacked plots, and heatmaps.
- Statistical tests: T-test for goal comparisons, win rate computations.
- Insights: Venue effects, first scorer advantage, confederation performance patterns.

---

## License

This project is licensed under the MIT License – you are free to use, adapt, and share it.

---

## Acknowledgments

Thanks to the dataset providers and the R community for essential open-source packages.
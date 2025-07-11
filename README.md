# International Football Match Analysis (Demo Project: 240206055)

## Overview

This project presents a comprehensive analysis of international football match data, focusing on various influential factors such as home advantage, tournament types, geographic distribution, temporal scoring trends, and high-scoring match prediction. The project utilizes data visualization, descriptive statistics, and logistic regression modeling to uncover meaningful insights.

---

## Dataset

**Dataset Files:**

- `results.csv`: Match-level data including date, teams, venue, and scores.
- `goalscorers.csv`: Player-level goal information.
- `shootouts.csv`: Data on matches decided by penalty shootouts.

> 💾 All data files are placed in the project root directory and loaded directly in the script.

---

## Project Analysis Topics

### 1. Home Advantage Analysis

**Key Tasks:**

- Computed score difference between home and away teams.
- Visualized impact of neutral venues using boxplots.
- Conducted correlation and linear regression between venue neutrality and score difference.
- Assessed effect on total goals scored.

### 2. Tournament Type Analysis

**Key Tasks:**

- Analyzed match count and average total goals by tournament type.
- Used bar charts to highlight differences across events.
- Applied ANOVA to test tournament effect on total score.

### 3. Geographic Analysis

**Key Tasks:**

- Ranked countries by match frequency.
- Visualized top 10 countries by number of matches and average goals.

### 4. Temporal Trends in Scoring

**Key Tasks:**

- Tracked scoring patterns over time.
- Compared goal distributions in World Cup years using boxplots.

### 5. High-Scoring Match Prediction

**Key Tasks:**

- Defined high-scoring matches (total score > 5).
- Built a logistic regression model with predictors such as neutral venue, tournament, and team scores.
- Visualized predicted probabilities of high-scoring outcomes.

---

## How to Run

### 1. Environment Requirements

- R version 4.0+
- Recommended packages:
  - `dplyr`
  - `ggplot2`

### 2. File Structure
```
project_root/
├── 240206055.R               # Main R script with full analysis
├── goalscorers.csv           # Dataset: Goal scorer details
├── results.csv               # Dataset: Match results
├── shootouts.csv             # Dataset: Penalty shootout info
```

### 3. Running the Script

Make sure all CSV files are in the same directory as the script. In R:

```r
source("240206055.R")
```

All visualizations will be rendered during script execution, and results printed to the R console.

---

## Results

- **Visualizations:** Boxplots, bar charts, and trend lines generated with `ggplot2`.
- **Statistical Models:** Linear regression and logistic regression used for inference and classification.
- **Key Insight:** Neutral venues, tournament types, and country location significantly affect match outcomes and scoring patterns.

---

## Future Work

1. Incorporate additional variables like player ratings or weather conditions.
2. Expand analysis with time-series forecasting models.
3. Compare international vs. club football patterns.

---

## License

This project is licensed under the MIT License – feel free to reuse or adapt.

---

## Acknowledgments

Thanks to the providers of international football match datasets and R open-source contributors.
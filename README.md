
# Film and Emotions: Positive Affect Analysis

## Overview

A reproducible secondary analysis of the `affect` dataset from the R package `psychTools`, examining associations between film category and changes in positive affect.

The analysis includes 330 observations from two studies.

## Research Question

Do changes in positive affect differ across film categories, and do these associations remain after adjusting for baseline positive affect?

## Methods

The outcome was calculated as:

PA_change = PA2 - PA1

Three linear regression models were examined:

- Model 1: Study + Film
- Model 2: Study × Film interaction
- Model 3: Baseline positive affect (PA1) + Study + Film

Additional analyses included:
- HC3 heteroskedasticity-robust standard errors
- Regression diagnostics
- Outlier and influence assessment
- Sensitivity analysis excluding four flagged observations
- Baseline positive affect × Film interaction assessment

## Key Findings

- All three film contrasts with Frontline were statistically significant in Models 1 and 3.
- HC3 robust standard errors did not change these significance conclusions.
- The Study × Film interaction did not significantly improve model fit (p = 0.095).
- The PA1 × Film interaction did not significantly improve Model 3 (p = 0.816).
- Baseline-adjusted Model 3 explained approximately 31.2% of the observed variation in positive-affect change.

These findings describe statistical associations and do not independently establish causal effects.


## Data Source and Attribution

This project is an independent secondary analysis of the
`affect` dataset included in the `psychTools` R package,
maintained by William Revelle.

The original data were collected at the Personality,
Motivation, and Cognition Laboratory at Northwestern
University.

The dataset includes 330 participants from two studies
involving experimentally assigned film-viewing conditions.

Original dataset documentation:
https://search.r-project.org/CRAN/refmans/psychTools/html/affect.html

R package:
https://doi.org/10.32614/CRAN.package.psychTools

All analyses, visualizations, and interpretations in this
repository represent the author's independent analytical work.


## Reproducibility

Required R packages:

- psychTools
- lmtest
- sandwich

Install them using:

`install.packages(c("psychTools", "lmtest", "sandwich"))`

Open the RStudio Project and execute:

`source("film_emotions_analysis.R")`

The script reproduces the models and generates the results and figures.

## Repository Contents

- `film_emotions_analysis.R`: Complete analysis script
- `figures/`: Research visualizations
- `results/`: Regression, interaction, and sensitivity results

## Author

Mohammad Sabzian Molaei, MD

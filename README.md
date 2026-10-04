# U.S. GDP Expenditure Analysis in R

## Overview

This project analyzes the major expenditure components of U.S. real GDP using quarterly data from 1947 through 2026.

The analysis was conducted in R and examines both the level of major expenditure components and how their shares of real GDP have changed over time.

## Research Question

How has the composition of U.S. real GDP changed over time?

## Components Analyzed

The analysis focuses on:

- Consumption
- Investment
- Government expenditure
- Exports
- Imports
- Net exports

## Tools and Skills

- R
- tidyverse
- ggplot2
- readxl
- janitor
- Data cleaning
- Data transformation
- Economic time-series analysis
- Data visualization
- Git and GitHub

## Data Processing

The original data were imported from an Excel workbook into R.

The R workflow:

1. Imports the original dataset.
2. Cleans variable names and removes non-data rows.
3. Converts economic variables to numeric format.
4. Calculates expenditure shares of real GDP.
5. Calculates net exports.
6. Creates a cleaned dataset for analysis.
7. Produces reproducible visualizations.

## Expenditure Components

The figure below shows the long-run evolution of consumption, investment, government expenditure, exports, and imports.

![U.S. Real GDP Expenditure Components](figures/expenditure_components.png)

## Expenditure Shares of Real GDP

The second figure examines how the relative importance of each expenditure component has changed over time.

![U.S. Expenditure Components as Shares of Real GDP](figures/expenditure_shares.png)

## Key Findings

- Consumption is the largest component of U.S. real GDP throughout the sample period.
- Consumption's share of real GDP generally increased over the long run.
- Investment displays considerably more cyclical variation than consumption.
- Government expenditure accounted for a relatively large share of GDP during the earlier part of the sample and generally declined as a share over time.
- Exports and imports became increasingly important relative to GDP, reflecting greater integration of the U.S. economy with international trade.
- Imports have often exceeded exports, resulting in negative net exports during many recent periods.

## Repository Structure

```text
US-GDP-expenditure-analysis/
│
├── README.md
├── gdp_analysis.R
│
├── data/
│   ├── gdp_source.xlsx
│   └── gdp_processed.csv
│
├── figures/
│   ├── expenditure_components.png
│   └── expenditure_shares.png
│
└── report/
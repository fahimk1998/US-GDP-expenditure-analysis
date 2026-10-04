# U.S. GDP Expenditure Analysis
# Author: Fahim Khan

# Load required packages
library(tidyverse)
library(readxl)
library(janitor)
library(scales)
# Check the worksheets in the Excel file
excel_sheets("data/gdp_source.xlsx")
# Import the GDP dataset
gdp <- read_excel(
  "data/gdp_source.xlsx",
  sheet = "Data"
)
glimpse(gdp)

names(gdp)

head(gdp)
View(gdp)
# Clean column names and remove non-data rows
gdp <- gdp |>
  clean_names() |>
  filter(!is.na(date)) |>
  mutate(
    date = as.Date(date),
    across(-date, as.numeric)
  )
glimpse(gdp)

names(gdp)
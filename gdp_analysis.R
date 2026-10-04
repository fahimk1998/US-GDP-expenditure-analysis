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

# Keep the raw expenditure variables
gdp <- gdp |>
  select(
    date,
    real_gdp,
    consumption_c,
    investment_i,
    government_g,
    exports_x,
    imports_m
  )

# Calculate expenditure shares of Real GDP
gdp <- gdp |>
  mutate(
    c_share_percent = consumption_c / real_gdp * 100,
    i_share_percent = investment_i / real_gdp * 100,
    g_share_percent = government_g / real_gdp * 100,
    x_share_percent = exports_x / real_gdp * 100,
    m_share_percent = imports_m / real_gdp * 100,
    net_exports = exports_x - imports_m,
    net_exports_share_percent = net_exports / real_gdp * 100
  )

glimpse(gdp)

head(gdp)

# Save cleaned and processed dataset
write_csv(
  gdp,
  "data/gdp_processed.csv"
)

# Reshape expenditure components for visualization
components_long <- gdp |>
  select(
    date,
    consumption_c,
    investment_i,
    government_g,
    exports_x,
    imports_m
  ) |>
  pivot_longer(
    cols = -date,
    names_to = "component",
    values_to = "value"
  ) |>
  mutate(
    component = recode(
      component,
      consumption_c = "Consumption",
      investment_i = "Investment",
      government_g = "Government",
      exports_x = "Exports",
      imports_m = "Imports"
    )
  )

# Set legend order
components_long <- components_long |>
  mutate(
    component = factor(
      component,
      levels = c(
        "Consumption",
        "Investment",
        "Government",
        "Exports",
        "Imports"
      )
    )
  )

# Create expenditure components graph
p1 <- ggplot(
  components_long,
  aes(
    x = date,
    y = value,
    color = component
  )
) +
  geom_line(linewidth = 0.9) +
  labs(
    title = "U.S. Real GDP Expenditure Components, 1947–2026",
    subtitle = "Quarterly expenditure components of real GDP",
    x = NULL,
    y = "Real Expenditure",
    color = NULL,
    caption = "Analysis conducted in R"
  ) +
  scale_x_date(
    breaks = as.Date(c(
      paste0(seq(1950, 2020, 10), "-01-01"),
      "2026-01-01"
    )),
    date_labels = "%Y",
    expand = expansion(mult = c(0.01, 0.02))
  ) +
  scale_y_continuous(
    labels = comma,
    expand = expansion(mult = c(0, 0.05))
  ) +
  
 
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(
      face = "bold",
      size = 15
    ),
    plot.subtitle = element_text(
      size = 11
    ),
    axis.title.y = element_text(
      face = "bold"
    ),
    legend.position = "bottom",
    legend.direction = "horizontal",
    panel.grid.minor = element_blank(),
    plot.caption = element_text(
      hjust = 0
    )
  )

p1


# Save expenditure components graph
ggsave(
  filename = "figures/expenditure_components.png",
  plot = p1,
  width = 10,
  height = 6,
  dpi = 300
)


# Reshape expenditure shares for visualization
shares_long <- gdp |>
  select(
    date,
    c_share_percent,
    i_share_percent,
    g_share_percent,
    x_share_percent,
    m_share_percent
  ) |>
  pivot_longer(
    cols = -date,
    names_to = "component",
    values_to = "share"
  ) |>
  mutate(
    component = recode(
      component,
      c_share_percent = "Consumption",
      i_share_percent = "Investment",
      g_share_percent = "Government",
      x_share_percent = "Exports",
      m_share_percent = "Imports"
    ),
    component = factor(
      component,
      levels = c(
        "Consumption",
        "Investment",
        "Government",
        "Exports",
        "Imports"
      )
    )
  )


# Create expenditure shares graph
p2 <- ggplot(
  shares_long,
  aes(
    x = date,
    y = share,
    color = component
  )
) +
  geom_line(linewidth = 0.9) +
  labs(
    title = "U.S. Expenditure Components as Shares of Real GDP, 1947–2026",
    subtitle = "Quarterly expenditure components as percentages of real GDP",
    x = NULL,
    y = "Percent of Real GDP",
    color = NULL,
    caption = "Analysis conducted in R"
  ) +
  scale_x_date(
    breaks = as.Date(c(
      paste0(seq(1950, 2020, 10), "-01-01"),
      "2026-01-01"
    )),
    date_labels = "%Y",
    expand = expansion(mult = c(0.01, 0.02))
  ) +
  
  scale_y_continuous(
    breaks = seq(0, 70, 10),
    labels = label_number(suffix = "%")
  ) +
  
  
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(
      face = "bold",
      size = 15
    ),
    plot.subtitle = element_text(
      size = 11
    ),
    axis.title.y = element_text(
      face = "bold"
    ),
    legend.position = "bottom",
    legend.direction = "horizontal",
    panel.grid.minor = element_blank(),
    plot.caption = element_text(
      hjust = 0
    )
  )

p2



ggsave(
  filename = "figures/expenditure_shares.png",
  plot = p2,
  width = 10,
  height = 6,
  dpi = 300
)
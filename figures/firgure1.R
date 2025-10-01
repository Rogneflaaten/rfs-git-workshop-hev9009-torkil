# Script to make Figure 1

# load required packages
library(tidyverse)
library(readxl)
library(Hmisc)
library(png)
library(grid)

# import the raw-data and wrangle to long format
data <- read_excel("data/raw-data/rawdata.xlsx") |>
  pivot_longer(names_to = "group",
               values_to = "value",
               cols = c(y, z))

# import the statistics
stats <- readRDS("data/derived-data/stats.RDS")

# save t test results in text form
test_results <- paste0(
  "t = ", round(stats$statistic, 2),
  "\np = ", format.pval(stats$p.value, digits = 3),
  "\nMean diff = ", round(diff(stats$estimate), 2)
)

# read logo image (update with your logo path)
logo <- readPNG("resources/logo-eng.png")

# make plot with green theme and logo background
figure1 <- ggplot(data, aes(group, value)) +
  # Add logo as background
  annotation_custom(
    rasterGrob(logo, 
               width = unit(1, "npc"),
               height = unit(1, "npc"),
               interpolate = TRUE),
    xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf
  ) +
  # Add semi-transparent white background for better readability
  annotate("rect", 
           xmin = -Inf, xmax = Inf, 
           ymin = -Inf, ymax = Inf,
           fill = "white", alpha = 0.7) +
  # Data points
  geom_point(position = position_jitter(width = 0.1, seed = 1),
             size = 2,
             alpha = 0.5,
             color = "#2d5f3f") +  # dark green points
  # Mean crossbar
  stat_summary(fun = mean,
               geom = "crossbar", 
               width = 0.5, 
               color = "#1a3d2b",  # darker green
               linewidth = 1) +
  # Statistics text
  annotate("text", 
           x = 1.5,
           y = max(data$value) * 0.95, 
           label = test_results, 
           size = 4, 
           hjust = 0.5,
           color = "#1a3d2b",  # dark green text
           fontface = "bold") +
  # Labels
  labs(x = "",
       y = "Arbitrary value") +
  # Green theme
  theme_minimal() +
  theme(
    plot.background = element_rect(fill = "#e8f5e9", color = NA),  # light green background
    panel.background = element_rect(fill = "transparent", color = NA),
    panel.grid.major = element_line(color = "#a5d6a7", linewidth = 0.5),  # medium green grid
    panel.grid.minor = element_line(color = "#c8e6c9", linewidth = 0.25), # lighter green grid
    axis.text = element_text(color = "#1b5e20", size = 11),  # dark green text
    axis.title = element_text(color = "#1b5e20", size = 12, face = "bold"),
    plot.margin = margin(20, 20, 20, 20)
  )



# save plot as an RDS object
saveRDS(figure1, "./figures/figure1.RDS")

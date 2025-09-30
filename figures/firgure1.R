# Script to make Figure 1

# load tidyverse and readxl
library(tidyverse)
library(readxl)

# load hmisc
library(Hmisc)

# import the raw-data and wrangle to long format
data <- read_excel("data/raw-data/rawdata.xlsx") |>
  pivot_longer(names_to = "group",
               values_to = "value",
               cols = c(y, z))


# import the statistics
stats <- readRDS("data/derived-data/stats.RDS")

#save t test results in text form
test_results <- paste0(
  "t = ", round(stats$statistic, 2),
  "\np = ", format.pval(stats$p.value, digits = 3),
  "\nMean diff = ", round(diff(stats$estimate), 2)
)


# make plot 1
figure1 <- ggplot(data, aes(group, value)) +
  geom_point(position = position_jitter(width = 0.1,
                                        seed = 1),
             size = 1,
             alpha = 0.3) +
  stat_summary(fun = mean,
               geom = "crossbar", 
               width = 0.5, 
               color = "red") +
  theme_classic() +
  labs(x = "Group",
       y = "Value") +
  annotate("text", 
           x = 1.5,
           y = max(data$value) * 0.95, 
           label = test_results, 
           size = 4, 
           hjust = 0.5)



# save plot as an RDS object
saveRDS(figure1, "./figures/figure1.RDS")

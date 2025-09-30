# Script to analyse the statistical difference between y and z

# load tidyverse and readxl
library(tidyverse)
library(readxl)


# import the raw-data
data <- read_excel("data/raw-data/rawdata.xlsx") |>
  pivot_longer(names_to = "group",
               values_to = "value",
               cols = c(y, z))


# perform independent t-test
stats <- t.test(value ~ group, data = data)


saveRDS(stats, "data/derived-data/stats.RDS")

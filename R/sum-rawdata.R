## Script to summarize raw-data


# load tidyverse and readxl
library(tidyverse)
library(readxl)


# import and summarize the raw-data
sum.data <- read_excel("data/raw-data/rawdata.xlsx") |>
  summarise(mean_y = mean(y),
            sd_y = sd(y),
            mean_z = mean(z),
            sd_z = sd(z))


# save sum.data
saveRDS(sum.data, file = "data/derived-data/sum.data.RDS")

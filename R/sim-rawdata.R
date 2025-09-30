## Script to simulate rawdata


# set seed to ensure reproducibility of result
set.seed(1)

# simulating a dataset
rawdata <- data.frame(x = c("group1", "group2"),
                      y = rnorm(100, mean = 5, sd = 2),
                      z = rnorm(100, mean = 10, sd = 3))





# load the writexl package
library(writexl)

# save the dataset as an Excel file
write_xlsx(rawdata, "data/raw-data/rawdata.xlsx")

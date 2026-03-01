#properly importing dataset
readLines("~/Desktop/Bocconi/Time Series/Assignment 04:03/gistemp.csv", n = 10)

library(readr)

gistemp <- read_csv(
  "~/Desktop/Bocconi/Time Series/Assignment 04:03/gistemp.csv",
  skip = 1
)

View(gistemp)




# ---- 0) Make missing values explicit ----
# Turn "***" into NA everywhere
gistemp[gistemp == "***"] <- NA

# ---- 1) Extract Year + monthly matrix (cols 2:13) ----
year <- gistemp$Year
mon_mat <- gistemp[, 2:13]

# Force monthly columns to numeric (after NA conversion)
mon_mat[] <- lapply(mon_mat, function(x) as.numeric(as.character(x)))

# ---- 2) Flatten into a single monthly vector in correct order ----
# (Year1 Jan..Dec, Year2 Jan..Dec, ...)
mon_vec <- as.vector(t(as.matrix(mon_mat)))

# ---- 3) Create monthly ts object ----
x_ts <- ts(mon_vec, start = c(min(year), 1), frequency = 12)

# Quick checks
summary(x_ts)
plot(x_ts)


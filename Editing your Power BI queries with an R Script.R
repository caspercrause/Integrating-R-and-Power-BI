# 'dataset' holds the input data for this script
library(data.table)
setDT(dataset)


# Merge only the column names that have contain digits "\\d" into one column called 'year' and merge the values to a column called 'sensus.result'
melt(dataset,measure.vars = patterns("\\d"),variable.name = 'year',value.name = 'sensus.result'
)[, sensus.result := ifelse(test = is.na(sensus.result),yes = 0,no = sensus.result)] -> output
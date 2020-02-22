
library(tidyverse)
# Absolute path to data: Make sure this is the absolute path to your file otherwise Power Bi will not be able to locate the file
path.to.file         <- 'Ex_Files_Microsoft_PowerBI_Desktop/Exercise Files/Chapter 03/CustomColumns.xlsx'

# List all sheet names
sheet.names          <- readxl::excel_sheets(path = path.to.file) 
# Give the sheet names not containing "Population" in the name 
filtered.sheet.names <-  sheet.names[!grepl('Population',sheet.names)] 


# Import all sheets at once and
raw.list             <-  map(filtered.sheet.names, ~ readxl::read_xlsx(path = path.to.file,sheet = .)) %>% 
    set_names(filtered.sheet.names) 
# Iterate through all the sheets and drop the columns "Flag" and "Status"
new.list             <-  raw.list %>% 
    map(~ select(., -c(Flag, Status))) 

# For every sheet, create a new column "Continent" that adds the name of the continent
for (i in seq_along(names(new.list))) {
    
    new.list[[i]]$Continent <- names(new.list[i])
}

# Combine all 7 sheets into one data frame and export to Power BI
`Countries and Capitals by Continent` <- do.call(rbind, new.list) 

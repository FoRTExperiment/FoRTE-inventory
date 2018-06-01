# Produce summary statistics of the tree inventory data (sample script)
# FoRTE June 2018  
# Ben Bond-Lamberty

library(readr)
library(ggplot2)
theme_set(theme_bw())
library(dplyr)
library(lubridate)

# Read the inventory data file
cat("Reading the inventory data file...\n")
trees <- read_csv("data-inventory/dummy_inventory.csv", col_types = "ccccdcTc")
cat("Merging with the plot-subplot design file...\n")
read_csv("design/plot-subplot.csv", col_types = "ccdddcic") %>% 
  left_join(trees, ., by = "Subplot") ->
  inventory

# Histogram of trees by DBH
p1 <- ggplot(inventory, aes(DBH_cm, fill = Species)) + 
  geom_histogram(position = "stack", binwidth = 5) + 
  facet_grid(Landform ~ Disturbance_level)
print(p1)

# Compute basal area and stocking
cat("Computing basal area and stocking...")
inventory %>% 
  mutate(Year = year(Date),
         BA_m2 = (DBH_cm / 100 / 2) ^ 2 * pi) %>% 
  group_by(Site, Year, Plot, Subplot) %>% 
  summarise(Subplot_area_m2 = mean(Subplot_area_m2),
            `Trees (/ha)` = n() / Subplot_area_m2 * 10000,
            `BA (m2/ha)` = sum(BA_m2, na.rm = TRUE) / Subplot_area_m2 * 10000) %>% 
  print

cat("All done.\n")

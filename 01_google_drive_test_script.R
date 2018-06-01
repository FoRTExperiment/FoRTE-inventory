# 
# 
# 
#

#package dependencies
require(tidyverse)
require(googledrive)
require(ggplot2)

#check drives
# drive_find(pattern = "FoRTE", n_max = 50)
# 

#Direct Google Drive link to "FoRTE/data"
x <- as_id("https://drive.google.com/drive/folders/1YULT4fx50b1MXZNOywgEeosW0GkrUe9c?usp=sharing")

# Uses x to "get" drive
drive_get(as_id(x))

# lists what is in drive
files <- drive_ls(x)

for(f in files$name) {
  cat("Downloading", f, "...\n")
  drive_download(f, overwrite = TRUE)
}

# Downloads file, but only one.
drive_download("dummy_data", type = "csv", path = "./data/dummy_data.csv", overwrite = TRUE)


# y <- drive_find(q = "name contains 'dummy'")
# 
# for (i in 1:length(y)){
#   file <- y[1][i]
# drive_download(file, path = "./data/", overwrite = TRUE)
# }


# bring in data
df <- read.csv("./data/dummy_data.CSV")

# plot
ggplot(df, aes(x = leafN, y = leafC, color = as.factor(disturbance)))+
  geom_point(size = 4)+
  theme_classic()+
  xlab("Nitrogen (%)")+
  ylab("Carbon (%)")+
  ggtitle("Leaf Chemistry by Disturbance Level")

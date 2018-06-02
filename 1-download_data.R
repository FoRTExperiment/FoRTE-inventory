# Download data from Google drive
# FoRTE June 2018  
# Ben Bond-Lamberty

library(googledrive)

# Google Drive link to "FoRTE/data/inventory"
x <- as_id("https://drive.google.com/drive/folders/1uD8EP-C902qB5wYYzgRl_7JHPBzGZ-YQ?usp=sharing")
files <- drive_ls(x)

for(f in files$name) {
  cat("Downloading", f, "...\n")
  drive_download(f, path = file.path("./data", files$name), overwrite = TRUE)
}

cat("Downloading plot-subplot information...\n")
x <- as_id("https://drive.google.com/open?id=1kZhBJBViSs0udcr-ZlxtBZmDp0z2T4cF")
drive_download(x, path = "./data/plot-subplot.csv", overwrite = TRUE)

cat("All done.\n")

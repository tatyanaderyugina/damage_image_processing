# Set directory to location of pre and post imagery
# Change name of hurricane as appropriate
setwd("~/Downloads/clipped_delta")

library(tiff)
library(raster)
library(rgdal)
library(RStoolbox)
library(dplyr)
library(stringr)

# Add post images into raster list
rastlist <- list.files(path = "~/Downloads/clipped_delta", pattern='_post_disaster.tif$', all.files=TRUE, full.names=FALSE)

# Perform histogram matching on post imagery
for(img in rastlist) {
  # rasterize post and pre images
  post <- brick(img)
  prename <- str_replace(img, "_post_disaster", "_pre_disaster")
  pre <- brick(prename)
  
  # perform histMatch on post image
  matched <- histMatch(post[[1:3]], pre[[1:3]])
  outputname <- str_replace(img, "_post_disaster", "_new_post_disaster")
  tiff(outputname, width = 1024, height = 1024, units = "px", compression = "jpeg")
  plotRGB(matched, asp = 0)
  dev.off()
}
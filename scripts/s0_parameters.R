####################################################################################################
####################################################################################################
## Set environment variables
## Contact remi.dannunzio@fao.org 
## 2018/05/04
####################################################################################################
####################################################################################################
####################################################################################################

### Read all external files with TEXT as TEXT
options(stringsAsFactors = FALSE)

### Create a function that checks if a package is installed and installs it otherwise
packages <- function(x){
  x <- as.character(match.call()[[2]])
  if (!require(x,character.only=TRUE)){
    install.packages(pkgs=x,repos="http://cran.r-project.org")
    require(x,character.only=TRUE)
  }
}

### Install (if necessary) two missing packages in your local SEPAL environment
packages(Hmisc)
packages(lubridate)
#packages(devtools)
#install_github('yfinegold/gfcanalysis')
#packages(gfcanalysis)

### Load necessary packages
packages(raster)
packages(rgeos)
packages(rgdal)

## Set download directory
# gfcstore_dir  <- "~/downloads/gfc_2017/"
# dir.create(gfcstore_dir,showWarnings = F)

## Set the working directory
rootdir       <- "~/kaza/"

## Go to the root directory
setwd(rootdir)
rootdir  <- paste0(getwd(),"/")
username <- unlist(strsplit(rootdir,"/"))[3]

scriptdir <- paste0(rootdir,"scripts/")
doc_dir   <- paste0(rootdir,"docs/")
data_dir  <- paste0(rootdir,"data/")
aoi_dir   <- paste0(rootdir,"data/aoi/")
tile_dir  <- paste0(rootdir,"data/tiling/")

dir.create(tile_dir,showWarnings = F)


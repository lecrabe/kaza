####################################################################################################
####################################################################################################
## Tiling of an AOI (shapefile defined)
## Contact remi.dannunzio@fao.org 
## 2019/03/11
####################################################################################################
####################################################################################################

### Select a vector from location of another vector
aoi <- readOGR(paste0(aoi_dir,"kaza_2017_aeac.shp"))

### What grid size do we need ? 
grid_size <- 20000          ## in meters

generate_grid <- function(aoi,size){
### Create a set of regular SpatialPoints on the extent of the created polygons  
sqr <- SpatialPoints(makegrid(aoi,offset=c(0.5,0.5),cellsize = size))

### Convert points to a square grid
grid <- points2grid(sqr)

### Convert the grid to SpatialPolygonDataFrame
SpP_grd <- as.SpatialPolygons.GridTopology(grid)

sqr_df <- SpatialPolygonsDataFrame(Sr=SpP_grd,
                                   data=data.frame(rep(1,length(SpP_grd))),
                                   match.ID=F)

### Assign the right projection
proj4string(sqr_df) <- proj4string(aoi)
sqr_df
}

sqr_df <- generate_grid(aoi,grid_size)

nrow(sqr_df)


### Select a vector from location of another vector
sqr_df_selected <- sqr_df[aoi,]
nrow(sqr_df_selected)

### Plot the results
plot(sqr_df_selected)
plot(aoi,add=T,border="blue")

### Give the output a decent name, with unique ID
names(sqr_df_selected@data) <- "tileID" 
sqr_df_selected@data$tileID <- row(sqr_df_selected@data)[,1]


### Export X random tiles TILE as KML
x <- 5
ex_tile <- sqr_df_selected[sample(1:nrow(sqr_df_selected@data),1)+seq(1,x,1),]
plot(ex_tile,add=T,col="red")

export_name <- paste0("ex_",x,"tiles_")
writeOGR(obj=   ex_tile,
         dsn=   paste(tile_dir,export_name,".kml",sep=""),
         layer= export_name,
         driver = "KML",
         overwrite_layer = T)

##############################################################################
### CONVERT TO A FUSION TABLE
### For example:    1tHlR85UF9sos9iuSCgD8FLiDaN07abQPn7uZazfh
##############################################################################

### Export ALL TILES as KML
export_name <- paste0("tiling_system_all")

writeOGR(obj=sqr_df_selected,
         dsn=paste(tile_dir,export_name,".kml",sep=""),
         layer= export_name,
         driver = "KML",
         overwrite_layer = T)


##############################################################################
### CONVERT TO A FUSION TABLE
### For example:    1pYQIgheGU7iyBRqgVB1MWkTXjHblK-aroZDi1Lux
##############################################################################

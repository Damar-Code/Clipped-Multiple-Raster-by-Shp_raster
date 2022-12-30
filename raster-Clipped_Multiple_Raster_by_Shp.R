lapply(c("raster","sf","rgdal"), require,character.only=TRUE)

shp <- st_read("//kerapremc01/Geo_Spatial/2.0.Projects/Fiber/FOLDER MANAGEMENT PROGRESS/Development Project/RnD Growth Modeling using LiDAR/CSI/Shapefile/TEEE065/Border TEEE065.shp")
origin_folder = "//kerapremc01/Geo_Spatial/2.0.Projects/Fiber/FOLDER MANAGEMENT PROGRESS/Development Project/RnD Growth Modeling using LiDAR/CSI/Raster/ADP3505/Spatial Parameter"
OutputPath = "//kerapremc01/Geo_Spatial/5.0.Others/Damar/R/Function/Try/Ras/"


Mask.Multi.Raster.by.Shp <- function(shp, origin_folder, OutputPath) {
  file_list <- list.files(path = origin_folder, pattern = ".tif$")
  file_list
  raster_stack <- raster::stack(file_list)
  for (i in 1:nlayers(raster_stack)) {
    #try to finish all loop ignoring the error
    tryCatch({
      crs <- proj4string(raster_stack[[i]])
      shp <- st_transform(shp, crs)
      a<-crop(raster_stack[[i]], shp)
      a<-mask(a,shp, filename = paste0(OutputPath, names(raster_stack)[i], ".tif"))
      print(paste(i,"Raster already Created",sep=" "))
      
    }, 
    #Print error if any 
    error=function(e){cat(i,conditionMessage(e), "/n")})
  }
}
Mask.Multi.Raster.by.Shp(shp,origin_folder,OutputPath)

raster_stack <- raster::stack(file_list)
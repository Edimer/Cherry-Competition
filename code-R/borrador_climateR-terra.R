

# Datos especies ----------------------------------------------------------

library(rgbif)

cherry_CA <- 
  occ_search(
    scientificName = "Prunus L.",
    return = "data",
    hasCoordinate = TRUE,
    country = "CA"
  )

cherry_JP <- 
  occ_search(
    scientificName = "Prunus L.",
    return = "data",
    hasCoordinate = TRUE,
    country = "JP"
  )

cherry_SW <- 
  occ_search(
    scientificName = "Prunus L.",
    return = "data",
    hasCoordinate = TRUE,
    country = "CH"
  )

cherry_US <- 
  occ_search(
    scientificName = "Prunus L.",
    return = "data",
    hasCoordinate = TRUE,
    country = "US"
  )


cherry_US$data %>% View


minLat <- min(cherry_US$data$decimalLatitude)
maxLat <- max(cherry_US$data$decimalLatitude)
minLon <- min(cherry_US$data$decimalLongitude)
maxLon <- max(cherry_US$data$decimalLongitude)


# Prueba `climateR` -------------------------------------------------------

library(AOI)
library(climateR)
library(sf)
library(raster)
library(rasterVis)

AOI <- aoi_get(state = "Washington")

plot(AOI$geometry)

WDC_coord <- 
  st_bbox(c(xmin = minLon, xmax = maxLon, ymin = minLat, ymax = maxLat),
          crs = 4326) %>%
  getTerraClim(startDate = "2000-01-01",
               endDate = "2000-12-31",
               param = "tmin")

WDC_sinCoord <- 
  getTerraClim(aoi_get(state = "Washington"),
               param = "tmin",
               startDate = "1958-01-01",
               endDate = "2019-12-31")

WDC_coord$terraclim_tmin[1:5,]



# descarga datos ----------------------------------------------------------


library(tidyverse)

datos <- read_csv("data/processed/cherry_bioclim_soilgrids.csv")

prueba_sf <- 
  datos %>% 
  st_as_sf(coords = c(3, 2),
           crs = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0")


variables <- c("aet", "water_deficit", "palmer", "soilm", "tmax",
               "tmin")


raster::extract(WDC_sinCoord$terraclim_tmin, prueba_sf) %>% 
  as_tibble() %>% 
  set_names(c(str_c("tmin_", names(.))))




raster::extract(.$terraclim_tmin, prueba_sf) %>% 
  as_tibble() %>% 
  set_names(c(str_c("tmin_", names(.))))



library(AOI)
library(climateR)
library(sf)
library(raster)
library(rasterVis)


source("code-R/functions/limits_function.R")

limits_function(data_sf = prueba_sf)


terra_climate <- 
  st_bbox(c(xmin = -9142312, xmax = 13574453, ymin = 2709145, ymax = 5300518),
          crs = 4326) %>%
  getTerraClim(startDate = "1958-01-01",
               endDate = "2019-12-31",
               param = variables)



# descarga final ----------------------------------------------------------

library(AOI)
library(climateR)
library(sf)
library(raster)
library(rasterVis)
library(tidyverse)


variables <- c("aet", "water_deficit", "palmer", "soilm", "tmax",
               "tmin")

wdc_TC <-
  getTerraClim(
    aoi_get(state = "Washington"),
    param = "palmer",
    startDate = "1958-01-01",
    endDate = "2019-12-31"
  )

japan_TC <-
  getTerraClim(
    aoi_get(country = "japan"),
    param = "palmer",
    startDate = "1958-01-01",
    endDate = "2019-12-31"
  )

suiza_TC <-
  getTerraClim(
    aoi_get(country = "switzerland"),
    param = "palmer",
    startDate = "1958-01-01",
    endDate = "2019-12-31"
  )

canada_TC <-
  getTerraClim(
    aoi_get(country = "canada"),
    param = "palmer",
    startDate = "1958-01-01",
    endDate = "2019-12-31"
  )




david <- 
  raster::extract(wdc_TC$terraclim_palmer, prueba_sf) %>% 
  as_tibble() %>% 
  set_names(c(str_c("palmer_", names(.)))) %>% 
  bind_cols(datos, .)


david %>% View












labels_terra <- function(x) {
  res = x %>% 
    set_names(c(str_c(names_TC, names(x))))
}



wdc_TC %>% 
  map(.f = as.data.frame)

names_TC <- wdc_TC %>% names
attributes(wdc_TC)

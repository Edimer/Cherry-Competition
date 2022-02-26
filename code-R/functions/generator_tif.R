generator_tif <- function(x, data, location) {
  # Translate to tif
  res = gdal_translate(
    x,
    names_tif(x, location),
    tr = c(250, 250),
    projwin = limits_function(data_sf = data),
    projwin_srs = '+proj=igh +lat_0=0 +lon_0=0 +datum=WGS84 +units=m +no_defs',
    verbose = TRUE
  )
  
  # Return
  return(res)
}
limits_function <- function(data_sf) {
  # Homolosine
  igh = '+proj=igh +lat_0=0 +lon_0=0 +datum=WGS84 +units=m +no_defs'
  
  # Transform
  data_new = st_transform(data_sf, igh)
  
  # Limits
  area = st_bbox(data_new)
  ulx = area$xmin
  uly = area$ymax
  lrx = area$xmax
  lry = area$ymin
  limits = c(ulx, uly, lrx, lry) * c(1, 1.05, 1.05, 1)
  
  # Return
  return(limits)
}
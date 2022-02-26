all_tif <- function(x, data_sf, list_vrt) {
  data_filter <- list()
  
  for (i in 1:length(x)) {
    # Data filtered by location
    data_filter[[i]] = data_sf %>%
      filter(new_location == x[i])
    
    # Generation tif
    list_vrt %>%
      map(.f = generator_tif,
          data = data_filter[[i]],
          location = x[i])
  }
}
extract_values <- function(file, data) {
  file_raster = raster(file)
  nombre  = file %>%
    str_split(pattern = "/") %>%
    as.data.frame() %>%
    slice(4) %>%
    pull() %>%
    str_remove(pattern = ".tif")
  
  res1 = extract(file_raster, data) %>%
    as_tibble() %>% 
    dplyr::select(value)
  
  res2 = res1 %>% 
    set_names(nombre)
  
  return(res2)
}
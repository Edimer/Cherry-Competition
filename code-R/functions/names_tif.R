names_tif <- function(x, location) {
  name_tif = x %>%
    str_split(pattern = "/") %>%
    as.data.frame() %>%
    slice(10) %>%
    pull() %>%
    str_replace(pattern = ".vrt", replacement = ".tif") %>%
    str_c("../data/processed/", location, "_", .)
  
  return(name_tif)
}
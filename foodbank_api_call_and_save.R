library(httr)
library(jsonlite)

# This file gets the API data call response and saves it in the directory

foodbank <- httr::GET("https://www.givefood.org.uk/api/2/foodbanks/",write_disk("raw_data/foodbank"))

response <- readLines("raw_data/foodbank")

foodbankJSON <- jsonlite::fromJSON(response)

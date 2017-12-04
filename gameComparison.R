library(httr)
library(jsonlite)
library(dplyr)
library(magrittr)
key <- '240369357eb62e10e6d8cffc39b8eef5'

#Function that takes field (endpoint in API) to compare with, the fielId, and
#a game limit. Returns a dataframe containing the id, name, and field value of the
#top *limit* games for that specified field based on total_rating
compareField <- function(field, fieldId, limit) {
  url <- paste0("https://api-2445582011268.apicast.io/games/?fields=name,total_rating&order=total_rating:desc&filter[", 
                field, "][eq]=", fieldId, "&limit=", limit)
  response <- GET(url, add_headers(.headers = c("user-key" = key, "Accept" = "application/json")))
  body <- content(response, "text")
  return(fromJSON(body))
}
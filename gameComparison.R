library(httr)
library(jsonlite)
library(dplyr)
library(magrittr)
key <- '1e77be878f94bcb2dd00528efadc4d5a'
#function that takes in a game name and category and returns
#the top 5 games related to that game and category (e.g. top 5 games made by the company of
#game X)
compareDev <- function(id) {
  url <- paste0("https://api-2445582011268.apicast.io/games/", id, "?fields=developers,popularity")
  response <- GET(url, add_headers(.headers = c("user-key" = key, "Accept" = "application/json")))
  body <- content(response, "text")
  data <- fromJSON(body)
  #Above is getting the developer ID and putting it in data
  
  url <- paste0("https://api-2445582011268.apicast.io/companies/", data$developers[[1]], "?&fields=developed")
  response <- GET(url, add_headers(.headers = c("user-key" = key, "Accept" = "application/json")))
  body <- content(response, "text")
  devedIds <- fromJSON(body)
  print(devedIds[[1]])
  gameList <- findGameNames(devedIds[[1]])
  gameList <- arrange(gameList$popularity) %>% filter(popularity >= gameList$popularity[5])
  return(gameList)
}


#given a list of ids, gives back a data frame with names and popularity
findGameNames <- function(gameList){
  df <- data.frame()
  for(id in gameList){
    url <- paste0("https://api-2445582011268.apicast.io/games/", id, "?fields=name,popularity")
    response <- GET(url, add_headers(.headers = c("user-key" = key, "Accept" = "application/json")))
    body <- content(response, "text")
    data <- fromJSON(body)
    df <- rbind(df, c(data$name,data$popularity))
  }
  return(df)
}

#devData <- compareDev(8173)

#Function that takes field (endpoint in API) to compare with, the fielId, and
#a game limit. Returns a dataframe containing the id, name, and field value of the
#top *limit* games for that specified field based on total_rating
compareField <- function(field, fieldId, limit) {
  url <- paste0("https://api-2445582011268.apicast.io/games/?fields=name,total_rating&order=total_rating:desc&filter[", 
                field, "]=", fieldId, "&limit=", limit)
  response <- GET(url, add_headers(.headers = c("user-key" = key, "Accept" = "application/json")))
  body <- content(response, "text")
  data <- fromJSON(body)
  
}
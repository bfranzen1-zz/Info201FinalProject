library(httr)
library(jsonlite)
library(dplyr)
library(magrittr)
key <- '240369357eb62e10e6d8cffc39b8eef5'
#function that takes in a game name and category and returns
#the top 5 games related to that game and category (e.g. top 5 games made by the company of
#game X)
compareDev <- function(id) {
  url <- paste0("https://api-2445582011268.apicast.io/games/", id, "?fields=developers,popularity")
  response <- GET(url, add_headers(.headers = c("user-key" = key, "Accept" = "application/json")))
  body <- content(response, "text")
  data <- fromJSON(body)
  #Above is getting the developer ID and putting it in data
  
  url <- paste0("https://api-2445582011268.apicast.io/companies/", data$companies[1], "?&fields=developed")
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


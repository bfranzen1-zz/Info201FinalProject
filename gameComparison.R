library(httr)
library(jsonlite)
key <- '240369357eb62e10e6d8cffc39b8eef5'
#function that takes in a game name and category and returns
#the top 5 games related to that game and category (e.g. top 5 games made by the company of
#game X)
compareDev <- function(gameId) {
  game <- gsub(" ", "-", game)
  url <- paste0("https://api-2445582011268.apicast.io/games/", gameId, "&fields=developers,popularity")
  response <- GET(url, add_headers(.headers = c("user-key" = key, "Accept" = "application/json")))
  body <- content(response, "text")
  data <- fromJSON(body)
  #Above is getting the developer ID and putting it in data
  
  url <- paste0("https://api-2445582011268.apicast.io/companies/", data$companies)
  response <- GET(url, add_headers(.headers = c("user-key" = key, "Accept" = "application/json")))
  body <- content(response, "text")
  data <- fromJSON(body)
}
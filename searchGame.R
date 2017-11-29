library(httr)
library(jsonlite)
key <- '240369357eb62e10e6d8cffc39b8eef5'
#function that returns list of id's of games
#related to game parameter
games <- function(game) {
  game <- gsub(" ", "-", game)
  url <- paste0("https://api-2445582011268.apicast.io/games/?search=", game)
  response <- GET(url, add_headers(.headers = c("user-key" = key, "Accept" = "application/json")))
  body <- content(response, "text")
  data <- fromJSON(body)
  return(data[[1]])
}

#function that returns name of game
#based on id given
gameName <- function(id) {
  url <- paste0("https://api-2445582011268.apicast.io/games/", id)
  response <- GET(url, add_headers(.headers = c("user-key" = key, "Accept" = "application/json")))
  body <- content(response, "text")
  data <- fromJSON(body)
  return(data$name)
}

#returns list of name/id pairs given list of id's
nameList <- function(idList) {
  names <- list()
  for(id in idList) {
    name <- gameName(id)
    names[name] <- id
  }
  names <- as.data.frame(names)
  return(names)
}
library(httr)
library(jsonlite)
key <- '240369357eb62e10e6d8cffc39b8eef5'

#function that returns game data
gameData <- function(id) {
  url <- paste0("https://api-2445582011268.apicast.io/games/", id)
  response <- GET(url, add_headers(.headers = c("user-key" = key, "Accept" = "application/json")))
  body <- content(response, "text")
  data <- fromJSON(body)
  return(data)
}

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
  data <- gameData(id)
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
  colnames(names) <- gsub('\\.', ' ', colnames(names))
  return(names)
}

#function that takes in list of id's and a desired field with '/'
#and returns the names associated with those id's
idToName <- function(idList, type) {
  param <- idList[1]
  if(length(idList) > 1) {
    for(id in idList[2:length(idList)]) {
      param <- paste0(param, ",", id)
    }
  }
  url <- paste0("https://api-2445582011268.apicast.io/", type, param, "?fields=name")
  response <- GET(url, add_headers(.headers = c("user-key" = key, "Accept" = "application/json")))
  body <- content(response, "text")
  data <- fromJSON(body)
  names <- ""
  if (!is.null(data)) {
    names <- data$name[1]
    if(length(data$name) > 1) {
      for (s in data$name[2:length(data$name)]) {
        names <- paste(names, s, sep=", ")
      }
    }
  } 
  return(names)
}
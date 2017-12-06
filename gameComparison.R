library(httr)
library(jsonlite)
library(dplyr)
library(magrittr)

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

#function that takes in field, fieldName, gameValue, and gameData and 
#returns a plot that contains the top five games from that field
#compared to the game from gameData and the field that equals gameValue
plotData <- function(field, gameValue, gameData, fieldName, field2) {
  data <- compareField(field, gameValue, 5)
  name <- idToName(gameValue, field2)
  ggplot(data) + geom_bar(aes(x=name, y=total_rating), stat="identity", fill="gray8") + 
    geom_bar(data=gameData, aes(x=name, y=total_rating), stat="identity", fill="red4") + 
    coord_flip() + theme(legend.position="none") + ggtitle(paste0("Comparison with the top five games for ", name, " ", fieldName)) +
    ylab("Rating(%)") + xlab("Name of Game")
}
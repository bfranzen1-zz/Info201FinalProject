library(httr)
library(jsonlite)
library(dplyr)
library(magrittr)
key <- '240369357eb62e10e6d8cffc39b8eef5'

getCategoryIds <- function(category) {
  category <- gsub(" ", "_", category)
  url <- paste0("https://api-2445582011268.apicast.io/", category,"/?fields=name&limit=50")
  response <- GET(url, add_headers(.headers = c("user-key" = key, "Accept" = "application/json")))
  body <- content(response, "text")
  data <- fromJSON(body)
  return(data)
}

plotDataTop <- function(field, id, fieldName, field2) {
  data <- compareField(field, id, 5)
  name <- idToName(id, field2)
  ggplot(data) + geom_bar(aes(x=name, y=total_rating), stat="identity", fill="gray8") + 
    coord_flip() + theme(legend.position="none") + ggtitle(paste0("Comparison with the top five games for ", fieldName)) +
    ylab("Rating(%)") + xlab("Name of Game")
}

platformData <- function() {
  platforms <- data.frame(name = c("iOS",
                                   "Mac",
                                   "Nintendo 64",
                                   "Nintendo Gamecube",
                                   "Wii",
                                   "Wii U",
                                   "Nintendo DS",
                                   "Nintendo 3DS",
                                   "PlayStation",
                                   "PlayStation 2",
                                   "PlayStation 3",
                                   "PlayStation 4",
                                   "PC (Microsoft Windows)",
                                   "Xbox",
                                   "Xbox 360",
                                   "Xbox One"),
                          value = c("39", "14", "4", "21", "5", "41", "20", "37", 
                                    "7", "8", "9", "48", "6", "11", "12", "49"))
  return(platforms)
}

categoryData <- function() {
  category <- data.frame(name = c("Genre", "Year", "Company", "Game Engine", "Platform", "Theme"),
                          value = c("genres", "release_dates.y", "companies", "game_engines", "release_dates.platform", "themes"))
  return(category)
}
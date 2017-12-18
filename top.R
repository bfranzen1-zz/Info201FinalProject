library(httr)
library(jsonlite)
library(dplyr)
library(magrittr)
library(ggplot2)
key <- '240369357eb62e10e6d8cffc39b8eef5'

topData <- function(field, fieldId, year, limit) {
  url <- paste0("https://api-2445582011268.apicast.io/games/?fields=name,total_rating&order=total_rating:desc&filter[", 
                field, "][eq]=", fieldId, "&filter[release_dates.y][gte]=", year[1], 
                "&filter[release_dates.y][lte]=", year[2],"&limit=", limit)
  response <- GET(url, add_headers(.headers = c("user-key" = key, "Accept" = "application/json")))
  body <- content(response, "text")
  return(fromJSON(body))
}

#gets 50 names of given category (e.g. themes, genres, etc.)
getCategoryIds <- function(category) {
  category <- gsub(" ", "_", category)
  url <- paste0("https://api-2445582011268.apicast.io/", category,"/?fields=name&limit=50")
  response <- GET(url, add_headers(.headers = c("user-key" = key, "Accept" = "application/json")))
  body <- content(response, "text")
  data <- fromJSON(body)
  return(data)
}

#plots top 5 games based on field, id, fieldName, and secondary field name *field2*
plotDataTop <- function(field, id, fieldName, field2, year, limit) {
  dataCat <- topData(field, id, year, limit)
  name <- idToName(id, field2)
  plot_ly(data = dataCat, x = dataCat$name, y = dataCat$total_rating, type = 'bar',
          marker = list(color = "rgb(106,227, 0)", line = list(color = 'rgb(8,48,107)', width = 1.5)), 
          text = paste0("Rating of, ", dataCat$name, ": ", round(dataCat$total_rating, digits = 2))) %>% 
          layout(xaxis = list(title = paste("Top", limit, "games")), 
                 yaxis = list(title ="Total rating(%)"), margin = list(b = 200), title = paste0(name, "- Top Rated Games"))
}

#data frame containing category names and their API names
categoryData <- function() {
  category <- data.frame(name = c("Genre", "Company", "Game Engine", "Platform", "Theme"),
                         value = c("genres", "companies", "game_engines", "platforms", "themes"))
  return(category)
}

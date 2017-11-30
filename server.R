#get data using key 
library(httr)
library(jsonlite)
source('searchGame.R')
#add endpoint you want before running this code i.e.io/games/1942
#this gives info on Witcher 3 
url <- "https://api-2445582011268.apicast.io/"
#response <- GET(url, add_headers(.headers = c("user-key" = key, "Accept" = "application/json")))
#body <- content(response, "text")
#data <- fromJSON(body)
server <- function(input, output) {
  names <- data.frame()
  output$game <- renderPrint({ 
    gameList <- games(input$game)
    names <- nameList(gameList)
    nameList <- gsub('\\.', ' ', colnames(names))
    output$choice <- renderUI({
      selectInput("choices", "Choices", nameList)
    })
  })
  
}
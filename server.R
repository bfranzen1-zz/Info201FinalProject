#get data using key 
library(httr)
library(jsonlite)
source('searchGame.R')
source("gameComparison.R")
#add endpoint you want before running this code i.e.io/games/1942
#this gives info on Witcher 3 
url <- "https://api-2445582011268.apicast.io/"
#response <- GET(url, add_headers(.headers = c("user-key" = key, "Accept" = "application/json")))
#body <- content(response, "text")
#data <- fromJSON(body)
server <- function(input, output) {
  data <- reactive({
    if(input$search==0) return(NULL)
    isolate({
      gameList <- games(input$game)
      names <- nameList(gameList)
    })
  })
<<<<<<< HEAD
  output$choice <- renderUI({
    names <- data()
    selectInput("choices", "Choices", colnames(names))
=======
  output$comparisons <- renderPlot({
    
>>>>>>> 4b01503ee9bc6fb071e704e0360102dcab6685c2
  })
  
  output$page <- renderUI({
    names <- data()
    choice <- input$choices
    id <- names[choice][[1]]
    gameInfo <- gameData(id)
    if (!is.null(gameInfo$rating)) {
      gameInfo$rating <- paste0(round(as.numeric(gameInfo$rating)), "%") 
    }
    if (!is.null(gameInfo$release_dates)) {
      gameInfo$release_dates[[1]][[5]][[1]] <- paste0("Release Date: ", gameInfo$release_dates[[1]][[5]][[1]])  
    }
    withTags({
      div(class = "header", checked=NA,
        h1(gameInfo$name),
        h4(gameInfo$rating),
        h4(gameInfo$release_dates[[1]][[5]][[1]]),
        img(src=gameInfo$screenshots[[1]][[1]][[1]]),
        p(gameInfo$summary)
      )
    })
  })
}
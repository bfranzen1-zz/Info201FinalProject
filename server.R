#get data using key 
library(httr)
library(jsonlite)
source('searchGame.R')
source("gameComparison.R")

server <- function(input, output) {
  data <- reactive({
    if(input$search==0) return(NULL)
    isolate({
      gameList <- games(input$game)
      names <- nameList(gameList)
    })
  })
  
  output$choice <- renderUI({
    names <- data()
    selectInput("choices", "Choices", colnames(names))
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
    if (!is.null(gameInfo$rating_count)) {
      gameInfo$rating_count <- paste0("based on ", gameInfo$rating_count, " reviews")
    }
    withTags({
      div(
        h1(gameInfo$name),
        h3(paste(gameInfo$rating, gameInfo$rating_count)),
        h4(gameInfo$release_dates[[1]][[5]][[1]]),
        img(src=gameInfo$screenshots[[1]][[1]][[1]]),
        p(gameInfo$summary)
      )
    })
  })
  
  output$comparisons <- renderPlot({
    
  })
}
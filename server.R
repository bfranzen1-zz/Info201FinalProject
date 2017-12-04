#get data using key 
library(httr)
library(jsonlite)
library(ggplot2)
source('searchGame.R')
source("gameComparison.R")
# published url https://bfranzen.shinyapps.io/videogamedb/
server <- function(input, output) {
  data <- reactive({
    if(input$search==0) {
      return(NULL)
    } else {
      isolate({
        gameList <- games(input$game)
        names <- nameList(gameList)
      }) 
    }
  })
  game <- reactive({
    names <- data()
    choice <- input$choices
    id <- names[choice][[1]]
    return(gameData(id))
  })
  output$choice <- renderUI({
    names <- data()
    selectInput("choices", "Choices", colnames(names))
  })
  
  output$page <- renderUI({
    gameInfo <- game()
    if(!is.null(gameInfo$summary)) {
      if (!is.null(gameInfo$total_rating)) {
        gameInfo$total_rating <- paste0(round(as.numeric(gameInfo$total_rating)), "%") 
      }
      if (!is.null(gameInfo$release_dates)) {
        gameInfo$release_dates[[1]][[5]][[1]] <- paste0("Release Date: ", gameInfo$release_dates[[1]][[5]][[1]])  
      }
      if (!is.null(gameInfo$total_rating_count)) {
        gameInfo$total_rating_count <- paste0("based on ", gameInfo$total_rating_count, " reviews")
      }
      if (!is.null(gameInfo$platforms)) {
        gameInfo$platforms <- idToName(gameInfo$platforms[[1]], "platforms/")
      }
      if (!is.null(gameInfo$themes)) {
        gameInfo$themes <- idToName(gameInfo$themes[[1]], "themes/")
      }
      gameInfo$screenshots[[1]][[1]][[1]] <- gsub("t_thumb", "t_screenshot_big", gameInfo$screenshots[[1]][[1]][[1]])
      withTags({
        div(
          h1(gameInfo$name),
          h3(paste(gameInfo$total_rating, gameInfo$total_rating_count)),
          h4(gameInfo$release_dates[[1]][[5]][[1]]),
          h5(gameInfo$platforms),
          h5(gameInfo$themes),
          img(src=gameInfo$screenshots[[1]][[1]][[1]]),
          p(gameInfo$summary),
          p(gameInfo$storyline),
          a(href=gameInfo$url, "More Information here!")
        )
      })
    } else {
      print("No Information to Display")
    }
    
    #renderPlot({
    #  devData <- compareField("developers", gameInfo$developers[[1]], 5)
    #  ggplot(devData) + geom_bar(aes(x=name, y=total_rating), stat="identity", fill="gray8") + 
    #   geom_bar(data=gameInfo, aes(x=test$name, y=test$total_rating), stat="identity", fill="red4") + 
    #    coord_flip() + theme(legend.position="none")
    #})
  })
  
  output$comparisons <- renderPlot({
    gameInfo <- game()
    #plot for company/developer
    if(!is.null(gameInfo$developers) & input$compareField == "Developer") {
      devData <- compareField("developers", gameInfo$developers[[1]][1],5)
      devName <- idToName(gameInfo$developers[[1]], "companies/")
      ggplot(devData) + geom_bar(aes(x=name, y=total_rating), stat="identity", fill="gray8") + 
       geom_bar(data=gameInfo, aes(x=name, y=total_rating), stat="identity", fill="red4") + 
        coord_flip() + theme(legend.position="none") + ggtitle(paste0("Comparison against top five games from ", devName)) +
         ylab("Rating(%)") + xlab("Name of Game")
    }
    #plot for genres
    else if(!is.null(gameInfo$genres) & input$compareField == "Genre") {
      genreData <- compareField("genres", gameInfo$genres[[1]][1],5)
      genreName <- idToName(gameInfo$genres[[1]][1], "genres/")
      ggplot(genreData) + geom_bar(aes(x=name, y=total_rating), stat="identity", fill="gray8") + 
        geom_bar(data=gameInfo, aes(x=name, y=total_rating), stat="identity", fill="red4") + 
        coord_flip() + theme(legend.position="none") + ggtitle(paste0("Comparison against top five games from the genre ", genreName)) +
        ylab("Rating(%)") + xlab("Name of Game")
    }
    #plot for themes
    #if(!is.null(gameInfo$themes)) {
      
    #}
  })
}
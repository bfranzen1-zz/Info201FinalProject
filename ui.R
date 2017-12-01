library(shiny)
source('searchGame.R')
ui <- fluidPage(
  titlePanel('Video Game Application'),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      tabsetPanel(
        tabPanel('Search for Game',
          textInput("game", "Game"),
          actionButton("search", "Search"),
          uiOutput("game"),
          uiOutput("choice"),
          uiOutput("page")
        ),
          
        tabPanel('Game Comparison', 
                textInput("compare", "Game to Compare"),
                textOutput("comparisons")
                
                  ),
        
        tabPanel('Tab3', 'This is Tab 3'),
        tabPanel('Tab4', 'This is Tab 4')
      )
      
    )
  )
)

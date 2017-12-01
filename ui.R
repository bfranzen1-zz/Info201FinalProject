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
          submitButton("Search", icon("Submit")),
          textOutput("game"),
          uiOutput("choice")
        ),
          
        tabPanel('Game Comparison', 
                textInput("compare", "Game to Compare"),
                submitButton("compSearch", icon("Search")),
                textOutput("comparisons"),
                
                  ),
        
        tabPanel('Tab3', 'This is Tab 3'),
        tabPanel('Tab4', 'This is Tab 4')
      )
      
    )
  )
)

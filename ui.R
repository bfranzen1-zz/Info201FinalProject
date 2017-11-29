library(shiny)
source('searchGame.R')
ui <- fluidPage(
  titlePanel('Video Game Application'),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      tabsetPanel(
        tabPanel('Search for Game',
          textInput("game", "Game", "Search for Game"),
          submitButton("Search", icon("Submit")),
          verbatimTextOutput("game")
        ),
          
        tabPanel('Tab2', 'This is Tab 2'),
        tabPanel('Tab3', 'This is Tab 3'),
        tabPanel('Tab4', 'This is Tab 4')
      )
      
    )
  )
)

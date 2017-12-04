library(shiny)
source('searchGame.R')

ui <- fluidPage(
  titlePanel('Video Game Application'),
    tabsetPanel(
      tabPanel('Search for Game',
        sidebarLayout(
          sidebarPanel(
            radioButtons("compareField", "Compare By:", 
                         c("Developer", "Genre", "Theme"))
          ),
          mainPanel(
            textInput("game", "Game"),
            actionButton("search", "Search"),
            uiOutput("choice"),
            uiOutput("page"),
            plotOutput("comparisons")
          )
        )
        
      ),
        
      #tabPanel('Game Comparison', 
              #textInput("compare", "Game to Compare"),
              #textOutput("comparisons")
              
      #          ),
      
      tabPanel('Tab3', 'This is Tab 3'),
      tabPanel('Tab4', 'This is Tab 4')
    )
    
)

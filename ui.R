library(shiny)
source('searchGame.R')

ui <- fluidPage(
  titlePanel('Video Game Application'),
    tabsetPanel(
      tabPanel('Search for Game',
        sidebarLayout(
          sidebarPanel(
            radioButtons("compareField", "Compare By:", 
                         c("Developer", "Genre", "Theme", "Year", "Platform", "Franchise"))
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
        
      #tabPanel('Top', 
              #uiOutput("category"),
              #plotOutput("categoryPlot")
              
               #),
      
      tabPanel('Tab3', 'This is Tab 3'),
      tabPanel('Tab4', 'This is Tab 4')
    )
    
)

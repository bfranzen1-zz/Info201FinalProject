library(shiny)
source('searchGame.R')

ui <- fluidPage(
  titlePanel('Video Game Application'),
    tabsetPanel(
      tabPanel('Search for Game',
        fluidRow(
          column(width = 3,
            textInput("game", "Game"),
            actionButton("search", "Search"),
            uiOutput("choice"),
            radioButtons("compareField", "Compare By:", 
                         c("Developer", "Genre", "Theme", "Year", "Platform", "Franchise"))
          ),
          column(width = 8, offset = 1,
             plotOutput("comparisons")
          )
        ),
        fluidRow(
            uiOutput("page")
        )
      ),
        
      tabPanel('Search Top Games',
               sidebarLayout(
                 sidebarPanel(
                   radioButtons("category", "Categories:", c("Genre", 
                                                             "Year", 
                                                             "Company", 
                                                             "Game Engine", 
                                                             "Platform", 
                                                             "Theme"))
                 ),
                 mainPanel(
                   uiOutput("categoryChoices"),
                   plotOutput("categoryPlot"))
               )
      ),
      
      tabPanel('Tab3', 'This is Tab 3'),
      tabPanel('Tab4', 'This is Tab 4')
    )
)

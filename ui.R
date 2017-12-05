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
                   radioButtons("categoryField", "Categories:", c("Genre", 
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
      
      tabPanel('About', h3("What is this?"),'Our application is aimed to give game enthusiasts a simple tool to search basic information about a video game. In addition, we provide several filters that allow
               users to compare top rated games through the use of several categories. We hope you enjoy this app!',h5("Source Code:"), 'https://github.com/bfranzen1/Info201FinalProject',
               h5("Api Courtesy of:"), 'IGDB.com'
      ),

      
      tabPanel('Tab4', 'This is Tab 4')
    )
)

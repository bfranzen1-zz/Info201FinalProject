library(shiny)
library(plotly)

ui <- fluidPage(
  titlePanel('Video Game Application'),
    tabsetPanel(
      #gives information about application
      tabPanel('About', 
               h3("What is this?"),
               'Our application is aimed to give game enthusiasts a simple tool to search basic information about a video game.
                In addition, we provide several filters that allow
                users to compare top rated games through the use of several categories.
                We hope you enjoy this app!',h5("Source Code:"), a(href='https://github.com/bfranzen1/Info201FinalProject', 'Github Repo'),
                h5("Big Thanks to 8 Dudes in a Garage for giving us Open Source access to the api from:"), a(href='https://api.igdb.com/', 'IGDB')
      ),
      
      #displays ui that lets user search for a game 
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
      #displays ui that lets user search for top games from a category  
      tabPanel('Search Top Games',
               sidebarLayout(
                 sidebarPanel(
                   radioButtons("categoryField", "Categories:", c("Genre",
                                                                  "Company", 
                                                                  "Game Engine", 
                                                                  "Platform", 
                                                                  "Theme")),
                   sliderInput("yearSlider",
                               "Year:",
                               min = 1972,
                               max = 2017,
                               value = c(1972,2017),
                               step = 1),
                   sliderInput("countSlider",
                               "Number of Games:",
                               min = 1,
                               max = 50,
                               value = 5,
                               step = 1)
                 ),
                 mainPanel(
                   uiOutput("categoryChoices"),
                   plotlyOutput("categoryPlot", width = "100%", height = "500px")
                   )
<<<<<<< Updated upstream
               )
      )
=======
             )
        )
>>>>>>> Stashed changes
    )
)

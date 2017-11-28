library(shiny)
ui <- fluidPage(
  titlePanel('Video Game Application'),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      tabsetPanel(
        tabPanel('Tab1', 'This is Tab 1'),
        tabPanel('Tab2', 'This is Tab 2'),
        tabPanel('Tab3', 'This is Tab 3')
      )
      
    )
  )
)

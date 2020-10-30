# Import Packages:
library(shiny)
library(shinydashboard)

server <- function(input, output, session) {
  output$file <- renderTable({
    input$chooseFile
  })
}
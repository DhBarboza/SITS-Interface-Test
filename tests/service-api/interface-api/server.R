library(shiny)
library(kohonen)
library(httr)

shinyServer(function(input, output){
  
  output$table <- renderTable({
    
    req(input$file)
    
    read.csv(
      input$file$datapath,
      header = TRUE,
      sep = ",",
      quote = '"'
    )
    
  })
  
})
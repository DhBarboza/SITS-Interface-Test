# Import Packages:
library(shiny)
library(shinydashboard)
library(ggsom)
library(kohonen)
library(tidyverse)

server <- function(input, output, session) {
  
  output$view_file <- renderTable({
    
    req(input$chooseFile)
    
    tryCatch({
      
      df <- read.csv(
        input$chooseFile$datapath,
        header = input$header,
        sep = input$separator,
        quote = input$quote
      )
      
      updateCheckboxGroupInput(session, "columns", "Select Columns", choices = names(df), selected = names(df))
      
      output$column_view <- renderTable({
        
        df <- subset(df, select = input$columns)
        
        v_som <- kohonen::som(scale(df), grid = somgrid(6,4, "rectangular"))
        
        v_plot <- eventReactive(input$showPlot, {
          switch(
            input$visualization,
            "Line" = ggsom::ggsom_line(aes_som(model_som), input$change_color),
            "Ribbon" = ggsom::ggsom_ribbon(aes_som(
              model_som, cutree_value=input$slider_cluster_ribbon), TRUE),
            "Rect" = ggsom::ggsom_rect(
              aes_som(model_som, cutree_value=input$slider_cluster_rect),
              input$neurons_grid
            )
          )# <- /switch
          
        })# <- /v_plot
        
        output$plot <- renderPlot({
          v_plot()
        })
        
        head(df, 10)
        
      })# <- /renderTable: column_view
      
    },
    error = function(e) {
      
      stop(safeError(e))
      
    })#<- /Try Catch
    
    if (input$display == "head") {
      return(head(df))
    }
    
    else {
      return(df)
    }
    
  })# <- /renderTable: view_file
  
}# <- /function
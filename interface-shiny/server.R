
library(shiny)
library(shinydashboard)
library(ggsom)
library(kohonen)
library(tidyverse)

###############
# LOAD SERVER #
###############

shinyServer(
  function(input, output, session) {
    
    output$fileUpload <- renderTable({
      
      req(input$chooseFile)
      
      tryCatch({
        df <- read.csv(
          
          input$chooseFile$datapath,
          header = input$header,
          sep = input$separator,
          quote = input$quote
        )
        
        updateCheckboxGroupInput(session, "columns",
                                 "Select Columns",
                                 choices = names(df),
                                 selected = names(df))
        
        df <- subset(df, select = input$columns)
        
        som_model <- kohonen::som(scale(df), grid = somgrid(6, 4, "retangular"))
        
        plot_v <- eventReactive(input$showPlot, {
          switch(
            input$visualization,
            
            "Line"= ggsom::ggsom_line(aes_som(som_model), input$change_color),
            
            "Ribbon" = ggsom::ggsom_ribbon(aes_som(som_model, cutree_value=input$slider_cluster_ribbon), TRUE),
            
            "Rect" = ggsom::ggsom_rect(aes_som(model_som, cutree_value=input$slider_cluster_rect), input$neurons_grid))
          ##End-switch
          
        })##End-plot_v
        
        output$plot <- renderPlot({ plot_v() })
        
        head(df, 10)
        
      },
        error = function(e) {
          
          stop(safeError(e))
          
      })##End-tryCatch
      
      if (input$display == "head") {
        return(head(df))
      }
      else {
        return(df)
      }
      
    })##End-renderTable

  }##End-funtion-main
  
)##End-Shiny-Server

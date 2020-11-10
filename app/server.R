# Import Packages:
library(shiny)
library(shinydashboard)
library(kohonen)
library(tidyverse)
library(httr)


server <- function(input, output, session) {
  
# <---------------------- IMPORT ---------------------------->  
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
        
        ## Test API:
        # url <- httr::modify_url(url   = "http://127.0.0.1:8888/",
        #                         path  = "clustering/som/obj",
        #                         query = list(xdim  = 6,
        #                                      ydim  = 4,
        #                                      rlen  = 1,
        #                                      alpha = 0.5))
        # request_som <- httr::POST(
        #   url  = url,
        #   body = tibble::as_tibble(df),
        #   encode = "json",
        #   httr::verbose())
        # 
        # v_som <- unserialize(httr::content(request_som, as = "raw"))
        
        v_plot <- eventReactive(input$showPlot, {
          switch(
            input$visualization,
            "Codes"   = plot(v_som, type = "codes"),
            "Counts"  = plot(v_som, type = "counts"),
            "Mapping" = plot(v_som, type = "mapping"),
            
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
# <---------------------- /IMPORT ---------------------------->  
  
# <---------------------- API - Request ------------------------>
  ## Request from url:
  ## Creating url:
  # url <- httr::modify_url(url   = "http://127.0.0.1:8888",
  #                         path  = "clustering/som/obj",
  #                         query = list(xdim  = input$Xdim,
  #                                      ydim  = input$Ydim,
  #                                      rlen  = input$len,
  #                                      alpha = input$alpha))
  # request_som <- httr::POST(
  #   url  = url,
  #   body = input$chooseFile,
  #   encode = "json")
  # 
  # # kohonen object from "kohonen package"
  # kobj <- unserialize(httr::content(request_som, as = "raw"))
  # 
  # output$plot_api <- renderPlot({
  #   kobj
  # })
  
# <---------------------- /API - Request ------------------------>
  
  
}# <- /function
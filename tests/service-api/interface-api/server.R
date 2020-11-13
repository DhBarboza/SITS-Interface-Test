library(shiny)
library(kohonen)
library(httr)

shinyServer(function(input, output){
  
  output$table <- renderTable({
    
    req(input$file)
    
    file_import <- read.csv(
      input$file$datapath,
      header = TRUE,
      sep = ",",
      quote = '"'
    )
    
  # API request: 
    
    # output$plot <- renderPlot({
    #   
    #   url_config <- httr::modify_url(url = "http://127.0.0.1:8888/",
    #                           path = "clustering/som/obj",
    #                           query = list(xdim = 6,
    #                                        ydim = 4,
    #                                        rlen= 1,
    #                                        alpha = 0.5))
    #   
    #   request_som <- httr::POST(url = url_config,
    #                             body = file_import,
    #                             encode = "json",
    #                             httr::verbose())
    #   
    #   kohonen_obj <- unserialize(httr::content(request_som, as = "raw"))
    #   
    # })# <- output: Plot
  
  })# <- /output: Table
  
})
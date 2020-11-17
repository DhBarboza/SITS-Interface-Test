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
  
  })# <- /output: Table
  
  # API request:
  
  output$plot <- renderPlot({
    
    url_config <- httr::modify_url(url = "http://127.0.0.1:8181/",
                                   path = "clustering/som/obj",
                                   query = list(xdim  = input$x,
                                                ydim  = input$y,
                                                rlen  = input$len))
    
    request_som <- httr::POST(url = url_config,
                              body = input$file,
                              encode = "json")
    
    kohonen_obj <- unserialize(httr::content(request_som, as = "raw"))
    
  })# <- output: Plot
  
})
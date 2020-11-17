library(shiny)
library(kohonen)
library(httr)

shinyServer(function(input, output, session){
  
  output$table <- renderTable({
    
    req(input$file)
    
    tryCatch({
      
      file_import <- read.csv(
        input$file$datapath,
        header = TRUE,
        sep = ",",
        quote = '"')
      
      updateCheckboxGroupInput(session, "columns", "Select Columns", choices = names(file_import), selected = names(file_import))
      
      output$column_select <- renderTable({
        
        file_import <- subset(file_import, select = input$columns)
        
        url_config <- httr::modify_url(url = "http://127.0.0.1:8181/",
                                       path = "clustering/som/obj",
                                       query = list(xdim  = 5,
                                                    ydim  = 5))
        
        request_som <- httr::POST(url = url_config,
                                  body = file_import,
                                  encode = "json")
        
        kohonen_obj <- unserialize(httr::content(request_som, as = "raw"))
        
        v_plot <- eventReactive(input$showPlot, {
          switch(input$visualization,
                 "Codes"  = plot(kohonen_obj, type = "codes"),
                 "Counts" = plot(kohonen_obj, type = "counts"),
                 "Mapping" = plot(kohonen_obj, type = "mapping")
          )# </switch>
          
        })# </v_plot>
        
        output$plot <- renderPlot({
          v_plot()
        })
        
        head(file_import, 10)
        
      })# </output: Column_Select>
      
    },
    error = function(e) {
      
      stop(safeError(e))
      
    })# </Try Catch>
    
    if (input$display == "head") {
      
      return(head(file_import))
      
    } else {return(file_import)}
  
  })# </output: Table>
  
})
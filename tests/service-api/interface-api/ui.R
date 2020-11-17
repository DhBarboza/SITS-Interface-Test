library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("cerulean"),
  navbarPage(title = "Test-API",
             
     tabPanel("Upload",
              
              sidebarLayout(
                
                sidebarPanel(
                  
                  fileInput("file", "Import your file:", multiple = FALSE),
                  
                  checkboxInput("header", "Header", TRUE),
                  
                  radioButtons("separator", "Separator:",
                               choices = c(Comma = ",", Semicolon = ";", Tab = "\t"),
                               selected = ","),
                  
                  radioButtons("quote", "Quote:", 
                               choices = c(None = "", "Double Quote" = '"', "Single Quote" = "'"),
                               selected = '"'),
                  
                  radioButtons("display", "Display:",
                               choices = c(Head = "head", All = "all"),
                               selected = "head")
                  
                  
                  
                ), 
                
                mainPanel(tableOutput("table"))
                
              )# </sidebarLayout>
              
            ), # </TabPanel:Upload>
     
     tabPanel("Select Colunms",
              sidebarLayout(
                
                sidebarPanel(
                  
                  checkboxGroupInput("columns", "Select Columns:", choices = NULL)
                  
                ),# </sidebarPanel>
                
                mainPanel(tableOutput("column_select"))
                
              ) # </sidebarLayout>
      ),
     
     tabPanel("Plot",
              
              sidebarLayout(
                
                sidebarPanel(
                  
                  selectInput("visualization", "Chosse a type of visualization:",
                              choices = c("Codes", "Counts", "Mapping")),
                  
                  actionButton("showPlot", "Plot")
                  
                ),
                
                mainPanel(plotOutput("plot"))
                
              )#<- /sidebarLayout
            )
             
  )#<- /navbarPage
))

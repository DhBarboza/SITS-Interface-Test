library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("cerulean"),
  navbarPage(title = "Test-API",
             
     tabPanel("Upload",
              
              sidebarLayout(
                
                sidebarPanel(
                  
                  fileInput("file", "Import your file:")
                  
                ), 
                
                mainPanel(tableOutput("table"))
                
              )# <- /sidebarLayout
            ),
     
     tabPanel("Plot",
              
              sidebarLayout(
                
                sidebarPanel(
                  
                ),
                
                mainPanel(plotOutput("plot"))
                
              )#<- /sidebarLayout
            )
             
  )#<- /navbarPage
))

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
                  
                  numericInput("x", "X-dim:", value = 1),
                  
                  numericInput("y", "y-dim:", value = 1),
                  
                  numericInput("len", "Len:", value = 1),
                  
                  numericInput("alpha", "Alpha:", value = 0.5),
                  
                ),
                
                mainPanel(plotOutput("plot"))
                
              )#<- /sidebarLayout
            )
             
  )#<- /navbarPage
))

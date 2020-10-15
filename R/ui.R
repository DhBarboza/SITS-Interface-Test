## Input Packages:
library(shiny)
library(shinythemes)
library(shinydashboard)
library(shinycssloaders)
library(shinyjs)
library(shinyBS)

## Build you ui.R:
shinyUI(fluidPage(
    
    ## load custom styles:
    ##includeCSS("www/style.css")
    
    ## Remove warning menssages on GUI from shiny:
    ## tags$style(type="text/css",
    ##          ".shiny-output-error { visibility: hidden; }",
    ##           ".shiny-output-error:before { visibility: hidden; }"
    ## ),
    
    ## Layout Page congif:
    dashboardPage(
        
        ## SElect your color preference (optional):
        skin = "blue",
        
        ## Define your Header with size:
        dashboardHeader(title = "Satellite Image Time Series Analysis", titleWidth = 300),
        
        ## Layout Sidebar 
        dashboardSidebar(width = 300,
                         
            sidebarMenu(
                
                ## Define your options and organize in sectors separated by each type of tool:
                menuItem("Quality Control Samples", tabName = "quality", icon = icon("chart-bar")),
                menuItem("ST-analysis", tabName = "analysis", icon = icon("analytics")),

                             
            )## End sidebarMenu!
                         
        ),## End dashboardSidebar!
        
    ## Layout to Main Panel:
        dashboardBody(
            
        )## End dashboardBody
        
        
        
    )## End dashboardPage!!
    
))

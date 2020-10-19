## Install Packages:
library(shiny)
library(shinydashboard)
library(shinycssloaders)
library(shinyjs)
library(shinyBS)

############
#  LOAD UI #
############

shinyUI(fluidPage(
  
  ## load custom styles:
  ##includeCSS("www/style.css")
  
  ## Remove warning menssages on GUI from shiny:
  ## tags$style(type="text/css",
  ##          ".shiny-output-error { visibility: hidden; }",
  ##           ".shiny-output-error:before { visibility: hidden; }"
  ## ),
  
  
  ## LOAD PAGE LAYOUT:
  dashboardPage(
    
    ## <!-- HEAD -->
    dashboardHeader(title = "Satelite Image Time Series Analysis", titleWidth = 300),##End-dashboardHeader
    
    ##<!-- SIDEBAR -->
    dashboardSidebar(width = 300,
                     sidebarMenu(
                       menuItem("Quality Control Samples", tabName = "quality", icon = icon("chart-bar")),
                       menuItem("ST-Analysis", tabName = "analysis", icon = icon("th"))
                     )##End-sidebarMenu
    ),##End-dashboardSidebar
    
    ## <!-- BODY -->
    dashboardBody(
      tabItems(
        # Tab-01:
        tabItem(tabName = "quality",
                fluidRow(
                  ## Input Parameters Box
                  # 01
                  box(width = 3,
                      title = h2("Input Parameters"),
                      
                      fileInput("File", h3("Choose File")),
                      
                      numericInput("gridX", "Grid-X:", value = 1),
                      
                      numericInput("gridY", "Grid-Y:", value = 1),
                      
                      numericInput("learningRate", "Learning Rate", value = 1),
                      
                      numericInput("len", "Len:", value = 1),
                      
                      selectInput("selectDistance",
                                  "Distance:",
                                  choices = c("Euclidean",
                                              "Other"))
                      
                  ),##End-Box-01
                  
                  ## Output SOM Grid
                  # 02:
                  box(width = 9,
                      title = h2("SOM Grid"),
                      
                      selectInput("vegetationIndex",
                                  "Vegetation Index",
                                  choices = c("NDVI",
                                              "Other",
                                              "Other2")),
                      
                      selectInput("typePlot",
                                  "Type Plot",
                                  choices = c("Patterns",
                                              "Other",
                                              "Other2")),
                      
                  ),##End-Box-02
                  
                ),##End-fluidRow
                
                ##FluidRow Cluster:
                fluidRow(
                  box(width = 15,
                      title = h2("Confusion Between Cluster"),
                  ),##End-Box
                ),##End-fluidRow-Cluster
                
        ),##End-tabItem-01
        
        # Tab-02:
        tabItem(tabName = "analysis",
                
        )##End-tabItem-02
      )##End-tabItems
    )##End-dashboardBody
  )##End-dashboardPage
  
))## ShinyUI & FluidPage


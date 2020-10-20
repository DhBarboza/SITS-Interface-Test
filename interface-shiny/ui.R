## Install Packages:
library(shiny)
library(shinydashboard)
library(shinycssloaders)
library(shinyjs)
library(shinyBS)

############
#  LOAD UI #
############

shinyUI(
  
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
                       
                       menuItem("Quality Control Samples", icon = icon("chart-bar"),
                                
                                fileInput("File", "Choose File"),
                                
                                menuSubItem("Assess Quality",
                                            tabName = "quality",
                                            icon = icon("line-chart")
                                ),##End-menuSubItem-Assess-Quality
                                
                                menuSubItem("Data Table",
                                            tabName = "dataTable",
                                            icon = icon("table")
                                )##End-menuSubItem-Data-Table
                                
                       ),##End-menuItem-Quality-control-samples
                       
                       menuItem("ST-Analysis", tabName = "analysis", icon = icon("th"))
                       
                     )##End-sidebarMenu
                     
    ),##End-dashboardSidebar
    
    ## <!-- BODY -->
    dashboardBody(
      tabItems(
        # Tab-01-Quality:
        tabItem(tabName = "quality",
                fluidRow(
                  ## Input Parameters Box
                  # 01
                  box(width = 4,
                      title = h3("Input Parameters"),
                      
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
                  box(width = 8,
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
                
        ),##End-tabItem-01-Quality
        
        ##Tab-Item-DataTable
        tabItem(tabName = "dataTable",
                
                fluidRow(
                  
                  box(
                    title = h2("Define the Sample Quality"),
                    
                    numericInput("conditional", "Conditional", value = 50),
                    
                    numericInput("posterior", "Posterior", value = 50),
                  ),##End-Box
                  
                  box(
                    title = h2("Summary"),
                    
                    helpText("X% samples will be kept"),
                    
                    helpText("Y% samples will be removed"),
                    
                    helpText("Z% samples must be analyzed"),
                  ),##End-Box
                ),##End-fluidRow-Configs-Sample-Quality
                
                fluidRow(
                  
                  column(2, actionButton("inputSamples", "Input Samples")),
                  
                  column(2, actionButton("samplesStatus", "Samples Status")),
                  
                  column(2, actionButton("subclasses", "Subclasses")),
                  
                  column(2, actionButton("outputSamples", "Output Samples")),
                  
                ),##End-fluidRow-Visualization
                
                fluidRow(
                  
                  box(
                    width = 15,
                    title = h3("Output"),
                  ),#End-Box
                  
                ),##End-fluidRow-Output
        ),##End-tabItem-DataTable
        
        # Tab-02:
        tabItem(tabName = "analysis",
                
        )##End-tabItem-02
      )##End-tabItems
    )##End-dashboardBody
  )##End-dashboardPage
  
)## ShinyUI


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
                       
                       menuItem("Input File", icon = icon("list-ul"),
                                
                                menuSubItem("Upload File", tabName = "file", icon = icon("angle-right")),
                                
                                menuSubItem("Data Visualization Config.", tabName = "data", icon = icon("angle-right")),
                                
                                menuSubItem("Plot", tabName = "plot", icon = icon("angle-right"))

                                ),##End-menuItem-Files
                       
                       menuItem("Quality Control Samples", icon = icon("chart-bar"),
                                
                                menuSubItem("Assess Quality", tabName = "quality", icon = icon("null")),
                                ##End-menuSubItem-Assess-Quality
                                
                                menuSubItem("Data Table", tabName = "dataTable", icon = icon("null"))
                                ##End-menuSubItem-Data-Table
                                
                       ),##End-menuItem-Quality-control-samples
                       
                       menuItem("ST-Analysis", icon = icon("th"),
                                
                                menuSubItem("Analytic Simple", tabName = "analyticSimples", icon = icon("simple")),
                                ##End-menuSubItem
                                
                                menuSubItem("Analytic Explore Subclasses", tabName = "exploreSubclasses", icon = icon("explore"))
                                ##End-menuSubItem
                              
                       )##End-menuItem
                       
                     )##End-sidebarMenu
                     
    ),##End-dashboardSidebar
    
    ## <!-- BODY -->
    dashboardBody(
      tabItems(
        
        # tab-Uplod-File:
        tabItem(tabName = "file",
          fluidRow(
            box(width = 4,
              
              fileInput("chooseFile", "Choose File", multiple = FALSE),
              
              checkboxInput("header", "Header:", TRUE),
              
              radioButtons("separator", "Separator:", 
                           choices = c(Comma = ",", Semicolon = ";", Tab = "\t"), 
                           selected = ","),
              
              radioButtons("quote", "Quote:",
                           choices = c(None = "", "Double Quote" = '"', "Single Quote" = "'"),
                           selected = '"'),
              
              radioButtons("display", "Display:",
                           choices = c(Head = "head", All = "all"),
                           selected = "head"),
              
            ),##End-box
            
            box(title = "Output"
            ),##End-box
            
          ),##End-fluidRow
        ),##End-tabItem
        
        # tab-dataVisualization:
        tabItem(tabName = "data",
          fluidRow(
            box(
              
              checkboxGroupInput("columns", "Select Columns", choices = NULL),
                    
            ),##End-box
                  
          ),##End-fluidRow
                
        ),##End-tabItem
        
        tabItem(tabName = "plot",
                
        ),##End-tabItem
        
        
        # Tab-01-Quality:
        tabItem(tabName = "quality",
                fluidRow(
                  ## Input Parameters Box
                  # 01
                  box(width = 4, title = h3("Input Parameters"),
                      
                      numericInput("gridX", "Grid-X:", value = 1),
                      
                      numericInput("gridY", "Grid-Y:", value = 1),
                      
                      numericInput("learningRate", "Learning Rate", value = 1),
                      
                      numericInput("len", "Len:", value = 1),
                      
                      selectInput("selectDistance", "Distance:", choices = c("Euclidean","Other"))
                      
                  ),##End-Box-01
                  
                  ## Output SOM Grid
                  # 02:
                  box(width = 8, title = h2("SOM Grid"),
                      
                      selectInput("vegetationIndex", "Vegetation Index", choices = c("NDVI", "Other", "Other2")),
                      
                      selectInput("typePlot", "Type Plot", choices = c("Patterns", "Other", "Other2")),
                      
                  ),##End-Box-02
                  
                ),##End-fluidRow
                
                ##FluidRow Cluster:
                fluidRow(
                  
                  box(width = 12, title = h2("Confusion Between Cluster"),
                      
                  ),##End-Box
                  
                ),##End-fluidRow-Cluster
                
        ),##End-tabItem-01-Quality
        
        ##Tab-Item-DataTable
        tabItem(tabName = "dataTable",
                
                fluidRow(
                  
                  box(title = h2("Define the Sample Quality"),
                    
                    numericInput("conditional", "Conditional", value = 50),
                    
                    numericInput("posterior", "Posterior", value = 50),
                    
                  ),##End-Box
                  
                  box(title = h2("Summary"),
                    
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
                  
                  box(width = 12, title = h3("Output"),
                    
                  ),#End-Box
                  
                ),##End-fluidRow-Output
                
        ),##End-tabItem-DataTable
        
        # Tab-02:
        tabItem(tabName = "analyticSimples",
            
            fluidRow(
              
              box(title = "Choose class be analyzed:",
                
                selectInput("class", "", choices = c("Class01", "Class02", "Class03"), selected = NULL),
                
              ),##End-box
              
              box(title = "Choose Year", selectInput("year", "",
                            choices = c("2000","2001", "2002", "2003","2004", "2005","2006", "2007", "2008", "2009", 
                                         "2010","2011", "2012", "2013", "2014", "2015", "2016", "2017","2018","2019")),
              ),##End-box
              
            ),##End-fluidRow: Choose class be analyzed
            
            fluidRow(
              
              box(width = 12, title = 'Output',
                
                actionButton("removeFilters", "Remove All Filters"),
                
              ),##End-box
              
            ),##End-fluidRow
            
            fluidRow(
              
              box(width = 12, title = "Plot Samples",
                
                selectInput("index", "Index:", choices = c("NDVI", "other", "other"), selected = "NDVI"),
                
              ),##End-box
              
            ),##End-fluidRow
            
        ),##End-tabItem-02
        
        tabItem(tabName = "exploreSubclasses",
                
                fluidRow(
                  
                  box(title = "HClust:", selectInput("class", "Input data: Weigth vectors",
                                choices = c("Class01", "Class02", "Class03"), selected = NULL),
                  ),##End-box
                  
                  box(title = "Cluster Dendogram",
                    
                    numericInput("numberCluster", "Define Number of cluster:", value = 1),
                    
                    numericInput("height","Height:", value = 1),
                    
                  ),##End-box
                  
                ),##End-fluidRow
                
                fluidRow(
                  
                  box(width = 3, title = "Choose Year",
                    
                    selectInput("year", "", 
                                choices = c("2000","2001", "2002", "2003","2004", "2005","2006", "2007", "2008", "2009", 
                                            "2010","2011", "2012", "2013", "2014", "2015", "2016", "2017","2018","2019")),
                  ),##End-box
                  
                  box(width = 9, title = 'Output',
                    
                    actionButton("removeFilters", "Remove All Filters"),
                    
                  ),##End-box
                  
                ),##End-fluidRow
                
                fluidRow(
                  
                  box(width = 12, title = "Plot Samples",
                    
                    selectInput("index", "Index:", choices = c("NDVI", "other1", "other2"),selected = "NDVI"),
                    
                  ),##End-box
                  
                ),##End-fluidRow
                
        )##End-tabItem
      )##End-tabItems
    )##End-dashboardBody
  )##End-dashboardPage
  
)## ShinyUI


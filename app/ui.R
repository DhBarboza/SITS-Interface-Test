# Import Packages:
library(shiny)
library(shinydashboard)

# <-------UI Page------------> 

header <- dashboardHeader(title = "Satelite Image Time Series Analysis", titleWidth = 250)

sidebar <- dashboardSidebar(width = 250,
                            
                            sidebarMenu(
                              
                              menuItem("Import", tabName = "import", icon = icon("folder-open")),
                              
                              menuItem("Quality Control Samples", icon = icon("chart-bar"),
                                       
                                       menuSubItem("Assess Quality", tabName = "quality", icon = icon("angle-right")),
                                       
                                       menuSubItem("Data Table", tabName = "dataTable", icon = icon("angle-right"))
                                       
                                    ),# <- /menuItem: Quality Control Samples
                              
                              menuItem("ST-Analysis", icon = icon("th"),
                                       
                                       menuSubItem("Analytic Simple", tabName = "analyticSimple", icon = icon("angle-right")),
                                       
                                       menuSubItem("Analytic Explore Subclasses", tabName = "exploreSubclasses", icon = icon("angle-right"))
                                       
                                    )# <- menuItem: ST-Analysis
                              
                            )# <- /Sidebar Menu
                            
            )
            # <--- /SIDEBAR --->

body <- dashboardBody(
  tabItems(
  # <--------------------- <SIDEBAR TABS CONFIGURATION> -------------------------->  
  # <--------------------- <TAB IMPORT> -------------------------->  
    tabItem(tabName = "import",
                tabBox(width = 13, 
                       
                       tabPanel("File Config",
                                
                                fluidRow(
                                  
                                  column(3, fileInput("chooseFile", "Choose File", multiple = FALSE),
                                         
                                                checkboxInput("header", "Header", TRUE)),
                                         
                                  column(1),
                                         
                                  column(3, radioButtons("separator", "Separator:", 
                                                                choices = c(Comma = ",", Semicolon = ";", Tab = "\t"), 
                                                                selected = ",")),
                                         
                                  column(3, radioButtons("quote", "Quote:", 
                                                                choices = c(None = "", "Double Quote" = '"', "Single Quote" = "'"),
                                                                selected = '"')),
                                         
                                  column(2, radioButtons("display", "Display:",
                                                                choices = c(Head = "head", All = "all"),
                                                                selected = "head"))
                                  ),#<- /Fluid Row
                                
                                fluidRow( tableOutput("view_file"))
                                
                       ),#<- /Tab Panel: File Config
                       
                       
                       
                       tabPanel("Column View",
                                fluidRow(
                                  column(4, checkboxGroupInput("columns", "Select Columns:", choices = NULL))
                                ),
                                
                                fluidRow(tableOutput("column_view"))
                                
                       ),#<- /Tab Panel: Column View
                       
                       tabPanel("Plot",
                                fluidRow(
                                  column(4,
                                      
                                      selectInput("visualization", "Choose a type of visualization",
                                                  choices = c("Line", "Ribbon", "Rect")),
                                      
                                      conditionalPanel(condition = "input.visualization == 'Line'",
                                                       checkboxInput("change_color", strong("Show color"), value = TRUE)),
                                      
                                      conditionalPanel(condition = "input.visualization == 'Ribbon'",
                                                       sliderInput("slider_cluster_ribbon", "Choose the numbers of cluster:",
                                                                   min = 1, max = 4, value = 2, step = 1)),
                                      
                                      conditionalPanel(condition = "input.visualization == 'Rect'",
                                                       sliderInput("slider_cluster_rect", "Choose the number of cluster",
                                                                   min = 1, max = 4, value = 2, step = 1),
                                                       
                                                       checkboxInput("neurons_grid", strong("Make neurons per grid"), value = TRUE)),
                                      
                                      actionButton("showPlot", "Plot")
                                    
                                  ),# <- column: Visualization
                                ),# <- /Fluid Row
                                
                                fluidRow(plotOutput("plot"))
                       )# <- /Tab Panel: Plot
                       
              ),#<- /Tab Box
  
    ),#<- /Tab Item: Import 
    # <--------------------- </TAB IMPORT> -------------------------->
    
    # <--------------------- <TAB QUALITY CONTROL SAMPLES> -------------------------->
    tabItem(tabName = "quality",
            fluidRow(
              box(width = 4, title = "Input Parameters", solidHeader = TRUE, status = "primary",
                  numericInput("gridX", "Grid-X:", value = 1),
                  
                  numericInput("gridY", "Grid-Y:", value = 1),
                  
                  numericInput("learningRate", "Learning Rate", value = 1),
                  
                  numericInput("len", "Len:", value = 1),
                  
                  selectInput("selectDistance", "Distance:", choices = c("Euclidean","Other"))
              ),#<- /Box: Input Parameters
              
              box(width = 8, title = "SOM Grid", solidHeader = TRUE, status = "primary",
                  fluidRow(
                    column(3, offset = 2, selectInput("vegetationIndex", "Vegetation Index", choices = c("NDVI", "Other", "Other2"))),
                    
                    column(3, offset = 2, selectInput("typePlot", "Type Plot", choices = c("Patterns", "Other", "Other2")))
                  )# <- /fluidRow
              )# <- /Box: Som Grid
            ),#<- /fluidRow
            
            fluidRow(box(width = 12, title = "Confusion Between Cluster", status = "primary"))
             
    ),# <- /tabItem: Quality
    
    tabItem(tabName = "dataTable",
            fluidRow(
              box(title = "Define the Sample Quality", solidHeader = TRUE, status = "primary",
                  
                  column(4, offset = 1, numericInput("conditional", "Conditional", value = 50)),
                  
                  column(4, offset = 1, numericInput("posterior", "Posterior", value = 50))

              ),#<- /Box
              
              box(title = "Summary", solidHeader = TRUE, status = "primary",
                  
                  helpText("X% samples will be kept", br(), 
                           "Y% samples will be removed", br(),
                           "Z% samples must be analyzed")
              ),#<- /Box
            ),#<- /fluiRow
            
            fluidRow(
              tabBox(width = 12,
                tabPanel("Input Samples", "Output"),
                tabPanel("Samples Status", "Output"),
                tabPanel("Subclasses", "Output"),
                tabPanel("Output Samples", "Output")
              )
            )#<- /fluidRow
    ),#<- /TabItem: Data Table
    # <--------------------- </TAB QUALITY CONTROL SAMPLES> -------------------------->
    
    # <--------------------- <TAB ST-ANALYSIS> -------------------------->
    tabItem(tabName = "analyticSimple",
            fluidRow(
              box(title = "Choose class be analyzed:", solidHeader = TRUE, status = "primary",
                  selectInput("class", "", choices = c("Class01", "Class02", "Class03"), selected = NULL)),
              
              box(title = "Choose Year", solidHeader = TRUE, status = "primary",
                  selectInput("year", "",
                              choices = c("2000","2001", "2002", "2003","2004", "2005","2006", "2007", "2008", "2009", 
                                          "2010","2011", "2012", "2013", "2014", "2015", "2016", "2017","2018","2019")))
            ),#<- /fluidRow
            
            fluidRow(
              box(width = 12, title = 'Output', status = "primary",
                  actionButton("removeFilters", "Remove All Filters"))
            ),#<- /fluidRow
            
            fluidRow(
              box(width = 12, title = "Plot Samples", status = "primary",
                  selectInput("index", "Index:", choices = c("NDVI", "other", "other"), selected = "NDVI"))
            )#<- /fluidRow
     ),#<- /tabItem: Analytic Simple
    
    tabItem(tabName = "exploreSubclasses",
            fluidRow(
              box(title = "HClust:", status = "primary", selectInput("class", "Input data: Weigth vectors",
                                                                      choices = c("Class01", "Class02", "Class03"), selected = NULL)),
              
              box(title = "Cluster Dendogram", status = "primary",
                  
                  numericInput("numberCluster", "Define Number of cluster:", value = 1),
                  
                  numericInput("height","Height:", value = 1))
            ),#<- /fluidRow
            
            fluidRow(
              box(width = 3, title = "Choose Year", status = "primary",
                  selectInput("year", "", 
                              choices = c("2000","2001", "2002", "2003","2004", "2005","2006", "2007", "2008", "2009", 
                                          "2010","2011", "2012", "2013", "2014", "2015", "2016", "2017","2018","2019"))),
              
              box(width = 9, title = 'Output', status = "primary", actionButton("removeFilters", "Remove All Filters"))
            ),#<- /fluidRow
            
            fluidRow(
              box(width = 12, title = "Plot Samples", status = "primary",
                  selectInput("index", "Index:", choices = c("NDVI", "other1", "other2"),selected = "NDVI"))
            )#<- /fluidRow
     )#<- tabName: Analytic Explore Subclasses
    
    # <--------------------- </TAB ST-ANALYSIS> -------------------------->
    
    # <----------------------------- </SIDEBAR TABS CONFIGURATION> ------------------------------------> 
    
  )# <- /Tab Items
          
)
#<---------  /BODY ------------>

dashboardPage(header, sidebar, body)
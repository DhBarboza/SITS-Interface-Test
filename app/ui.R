# Import Packages:
library(shiny)
library(shinydashboard)

# <-------UI Page------------> 

header <- dashboardHeader(title = "Satelite Image Time Series Analysis", titleWidth = 250)

sidebar <- dashboardSidebar(width = 250,
                            
                            sidebarMenu(
                              
                              menuItem("Import", tabName = "import", icon = icon("folder-open"))
                              
                            )# <- /Sidebar Menu
                            
            )
            # <--- /SIDEBAR --->

body <- dashboardBody(
          tabItems(
            
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
                                        
                                        fluidRow( tableOutput("file"))
                                        
                               ),#<- /Tab Panel: File Config
                               
                               
                               
                               tabPanel("Column View",
                                        
                                        fluidRow(
                                          column(4, checkboxGroupInput("columns", "Select Columns:", choices = NULL))
                                          ),
                                        
                               )#<- /Tab Panel: Column View
                               
                      ),#<- /Tab Box

            )#<- /Tab Item: Import 
            
          )# <- /Tab Items
          
        )
        #<----  /BODY ---->

dashboardPage(header, sidebar, body)
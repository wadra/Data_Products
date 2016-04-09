library(shiny)
library(shinyjs)

source("DataProd.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
          
          shinyjs::useShinyjs(),
          
          # Application title
          titlePanel("World Oil Production Data - by Abdul Wadood"),
          
          sidebarLayout(position = c("left","right"),
                        
                        # Show a plot of the generated distribution
                        mainPanel( 
                                  fluidRow(
                                            
                                            column(8,  align ="center", 
                                                   sliderInput("Year","Select Year:", min = as.numeric(colnames(my_data3)[3]),max = as.numeric(colnames(my_data3)[36]), value = 1,width = "100%"))),    
                                  h1('Oil Production Plot',align ="center"),
                                  plotOutput("distPlot"),
                                  
                                  verbatimTextOutput("row")
                                  #verbatimTextOutput("col"),
                                  #verbatimTextOutput("vec")
                        ),
                        
                        
                        
                        fluidRow(
                                  
                                  # Sidebar with a slider input for number of bins 
                                  
                                  sidebarPanel(
                                            
                                            # action button that displays checkbox with all countriy choices
                                            actionButton("SelectWorld",label = "All Countries"),
                                            
                                            # action buttons to display dynamic checkboxes with default selection for each unique world region(continet)
                                            # separate button choices in the side bar panel
                                            actionButton("SelectNorthAmerica", label = "North America"),
                                            actionButton("SelectCentralSouthAmerica", label = "Central South America"),
                                            actionButton("SelectEurope", label = "Europe"),
                                            actionButton("SelectEurasia", label = "Eurasia"),
                                            actionButton("SelectMiddleEast", label = "MiddleEast"),
                                            actionButton("SelectAfrica", label = "Africa"),
                                            actionButton("SelectAsiaOceania", label = "Asia Oceania"),
                                            
                                            # action button to that initaites server.ui function for selcting all world countries for all selectworld checkbox 
                                            actionButton("selectall", label="Select/Deselect All Countries"),
                                            
                                            
                                            # For displaying the defaul world checkbox with 2 selected countries by default
                                            checkboxGroupInput("Country","Select Country(s)",
                                                               choice =c_names[,1],
                                                               select = list("United States", "Saudi Arabia"))
                                            
                                            # Rendered output displayed from server.ui initating the indivdual checkbox group NOT USED.
                                            # uiOutput('WorldBox'),
                                            # uiOutput('NorthAmericaBox'),
                                            # uiOutput('CentralSouthAmericaBox'),
                                            # uiOutput('EuropeBox'),
                                            # uiOutput('EurasiaBox'),
                                            # uiOutput('MiddleEastBox'),
                                            # uiOutput('AfricaBox'),
                                            # uiOutput('AsiaOceaniaBox')
                                            #)
                                            
                                            
                                  )
                                  
                        )
          )
))

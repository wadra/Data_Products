#Data Source
#http://www.eia.gov/cfapps/ipdbproject/iedindex3.cfm?tid=5&pid=53&aid=1&cid=regions,&syid=1980&eyid=2014&unit=TBPD
library(shiny)
library(shinyjs)
library(xlsx)

# my_data <- read.xlsx(file = 'Consumptiondata.xlsx',header = TRUE,1)
# country <- read.xlsx("country.xlsx",header = TRUE,1,stringsAsFactors=FALSE)


if (exists('my_data3'))
{
source("DataProd.R")   
}
   


# Define server logic required to draw a barplot
shinyServer(function(input, output,session) {
          
          ###############################
        
          ###############################
          
          
          ###
          # Series of ObserveEvents checking for changes in country selections for updateCheckboxGroupInput 
          
          # This ObserveEvents function is for all countries action button that updates CheckboxGroupInput with all countries selection
          observeEvent(input$SelectWorld,
                       {
                                 updateCheckboxGroupInput(session=session,inputId="Country",
                                                          choices= c_names[,1],
                                                          selected = c("United States"))
                       })
          
          observeEvent(input$selectall,
                       {
                                 
                                 if(input$selectall > 0){
                                           if(input$selectall %% 2 != 0)
                                           {
                                                     
                                                     updateCheckboxGroupInput(session=session,inputId="Country",
                                                                              choices = c_names[,1],
                                                                              #choices = data.frame(my_data3[,2]),
                                                                              selected = c_names[,1])
                                                     #selected = data.frame(my_data3[,2])
                                           }
                                           else
                                           {
                                                     updateCheckboxGroupInput(session=session,inputId="Country",
                                                                              #choices =as.matrix(c_names[1,],1),
                                                                              choices = c_names[,1],
                                                                              selected = c())
                                           }
                                           
                                 }
                       })
          
          # This ObserveEvents function is for North America action button that updates CheckboxGroupInput with North American countries
          observeEvent(input$SelectNorthAmerica,
                       {
                                 updateCheckboxGroupInput(session=session,inputId="Country",
                                                          choices= as.matrix(country[c(1:which(is.na(country[,1]))[1] - 1),1]),
                                                          selected = c("United States"))
                                 
                                 
                       })
          
          # This ObserveEvents function is for SelectCentralSouthAmerica action button that updates CheckboxGroupInput with SelectCentralSouthAmerica
          observeEvent(input$SelectCentralSouthAmerica,
                       
                       {
                                 updateCheckboxGroupInput(session=session,inputId="Country",
                                                          choices= as.matrix(country[c(1:which(is.na(country[,2]))[1] - 1),2]),
                                                          selected = c("Aruba"))
                                 
                       })
          
          observeEvent(input$SelectEurope,
                       
                       {
                                 updateCheckboxGroupInput(session=session,inputId="Country",
                                                          choices= as.matrix(country[c(1:which(is.na(country[,3]))[1] - 1),3]),
                                                          selected = c("Albania"))
                                 
                       })
          
          observeEvent(input$SelectEurasia,
                       
                       {
                                 updateCheckboxGroupInput(session=session,inputId="Country",
                                                          choices= as.matrix(country[c(1:which(is.na(country[,4]))[1] - 1),4]),
                                                          selected = c("Armenia"))
                       })
          
          observeEvent(input$SelectMiddleEast,
                       
                       {
                                 updateCheckboxGroupInput(session=session,inputId="Country",
                                                          choices= as.matrix(country[c(1:which(is.na(country[,5]))[1] - 1),5]),
                                                          selected = c("Bahrain"))
                       })
          
          observeEvent(input$SelectAfrica,
                       
                       {
                                 updateCheckboxGroupInput(session=session,inputId="Country",
                                                          choices= as.matrix(country[c(1:which(is.na(country[,6]))[1] - 1),6]),
                                                          selected = c("Algeria"))
                       })
          
          observeEvent(input$SelectAsiaOceania,
                       
                       {
                                 updateCheckboxGroupInput(session=session,inputId="Country",
                                                          choices= as.matrix(country[c(1:which(is.na(country[,7]))[1] - 1),7]),
                                                          selected = c("Afghanistan"))
                       })
          
          
          
          
          
          #for plot rendering                          
          output$distPlot <- renderPlot({
                    
                    
                    #generate countries based on action button groupchecl box choices and selection
                    rows<- as.matrix(0,nrow =1:1000,ncol =1:100)
                    
                    # length of loop to run based on updated country selected so that fresh values with old values inclusive are selected
                    l <- length(input$Country)
                    
                    
                    # Loop to store data set row(s) for Country(s) selected from checkbox group.
                    for ( i in 1:l)
                    {
                              rows[i] <- which(my_data3[,2] == input$Country[i],arr.ind = TRUE)
                    }
                    # providing to x (to be used by barplot) matrice's row (country(s)) and y (specfic year from slider) values ot be plotted 
                    x <- my_data3[rows,as.character(input$Year)]
                    
                    
                    # draw the histogram with the specified number of countries, selected from checkbox
                    barplot(x,xlab = "Country",ylab = "Oil produced 1,000 bbl/day",horiz = FALSE, beside = TRUE,names.arg = input$Country)
                    
                    #reactive statements, displaying selected country
                    output$row <- renderPrint({input$Country})
                    
          })  
          
})





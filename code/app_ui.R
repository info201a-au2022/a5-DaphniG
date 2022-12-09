#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
navbarPage("A5: Data Applications",
           tabPanel("Introduction"),
           tabPanel("Interactive Visulizations",
                    titlePanel("CO2 Emissions Causes"),
                    
                    # Sidebar with a slider input for selecting countries
                    sidebarLayout(
                      sidebarPanel(
                        uiOutput("selectCountry"),
                        sliderInput("slider1", label = h3("Year"), min = 1850,
                                    max = 2022, value = 10, sep = ""),
                        
                        #p("This bar graph depicts the crime & safety of seventeen countries in North, South, and Central America. There is a yellow bar representing the crime rate in each of those countries. On the other hand, there is the green bar representing the safety. The lower the crime, the more safer is to live in that country. By selecting one country at a time through the selecting panel, the bar graph reveals that Venezuela in South America has the most crime rate (83.19) which means that it is 16.84 safe. It is also visible that Panama in Central America has the lowest crime rate (43.61) which means that it is 56.39 safe to live.")
                        
                      ),
                      
                      # Show a plot of the generated distribution
                      mainPanel(
                        plotlyOutput("countryPlot")
                      )
                    ),)
)
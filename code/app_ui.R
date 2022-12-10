#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(plotly)
library(readr)
library(shinythemes)

co2_data <- read_csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")


# Define UI for application that draws a histogram
ui <- navbarPage(theme = shinytheme("darkly"),"A5: Data Applications",
           tabPanel("Introduction", h1("Overview"),
                    p("This application will look into the dataset: 
                    Greenhouse Gas Emissions by Our World in Data. 
                    The application has an interactive visualization 
                    that shows the amount of  CO2 emissions by million tonnes 
                    that are emitted by different factors. Users can select the 
                    country and the years they want displayed on the line graph. 
                    The contributors of CO2 emissions the visualization looks at 
                    are cement, oil, gas and coal. The line graph plots them and 
                    allows for users to see how the emissions changed over time 
                    for each country. "),
                    
                    p("Looking at the Greenhouse Gas Emissions dataset, 
                      I decided to look at what the average value of CO2 
                      emissions emitted by oil was across all the counties 
                      in the most recent year.  The average value of CO2 
                      emissions by gas came out to be about"
                      ,avg_value(co2_data), "million tonnes.", " Next, I looked at which 
                      year had the highest CO2 emissions by coal. 
                      It turned out that", biggest(co2_data),"had the highest CO2 
                      emissions by coal. Finally I looked at how much 
                      the CO2 emissions by coal changed over the last 11 years. 
                      CO2 emissions by gas changed about", change(co2_data),
                      "million tonnes over the past 11 years.") ),
                   

           tabPanel("Interactive Visulization",
                    titlePanel("CO2 Emissions Contributers"),
                    
                    # Sidebar with a slider input for selecting countries
                    sidebarLayout(
                      sidebarPanel(
                        uiOutput("selectCountry"),
                        sliderInput("slider1", label = h3("Year"), min = 1850,
                                    max = 2022, value = 1850, sep = ""),
                       
                        
          p("This chart was included because it highlights 4 factors that 
          contribute to CO2 emissions. This chart allows countries to see 
          how much of each factor is contributing to their CO2 emissions. 
          Additionally the chart allows viewers to see how much each contributor 
          increases and decreases over time. Clicking through different countries 
          we can see that many countries don't have as much data for past years 
          compared to other countries. Additionally we are able to see that oil, 
          especially in more recent years, has a higher number of CO2 emissions 
          compared to the other contributors. However when looking at past years 
          we can see that is was coal that contributed to CO2 emissions the most. 
            ")
                      ),
                      
                      
                      # Show a plot of the generated distribution
                      mainPanel(
                        plotlyOutput("countryPlot")
                      )
                    ),)
)

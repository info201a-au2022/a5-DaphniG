library(shiny)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(plotly)
library(readr)



# dataset for CO2
co2_data <- read_csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

server <- function(input,output) {
  output$selectCountry <- renderUI({
    selectInput("country", "Choose a country:", choices = unique(co2_data$country))
    
  })
  output$selectYear <- renderUI({
    output$value <- renderPrint({ input$slider1 })
  })
  
  linePlot <- reactive({
    plotData <- co2_data %>% 
      filter(country %in% input$country) %>% 
      filter(year < input$slider1)
    
    
    
    plot_ly(plotData, x = ~year, y = ~gas_co2, type = 'scatter', mode = 'lines',name = 'gas') %>% 
      layout(yaxis = list(title = 'CO2 Emissions (million tonnes)'), title = "Contributers to CO2 emissions over Time", xaxis = list(title = 'Year'),
             legend = list(title=list(text='<b> Contributers of CO2 </b>'))) %>% 
      add_trace(y = ~coal_co2, name = 'coal')%>% add_trace(y = ~oil_co2, name = 'oil') %>% 
      add_trace(y = ~cement_co2, name = 'cement')
    
    
  })
  output$countryPlot <- renderPlotly({
    linePlot()
    
  })
}

avg_value <- function(co2_data) {
  
  avg <- co2_data %>% filter(year == max(year)) %>% summarise(mean = mean(oil_co2,na.rm=TRUE))
  return(avg)
}

val <- avg_value(co2_data)



#How much has co2 emissions by coal change over the last 11 years

change <- function(co2_data) {
  big <- co2_data %>% filter(year > 2009)%>% group_by(year) %>% summarise(sum = sum(gas_co2,na.rm=TRUE)) 
  recent <-big %>% filter(year == max(year)) %>% pull(sum)
  old <- big %>% filter(year == min(year)) %>% pull(sum)
  
  range <- recent - old
  
  
  return(range)
}

val_3 <- change(co2_data)
biggest <- function(co2_data){
  df <- co2_data %>% group_by(year) %>% summarise(sum = sum(coal_co2,na.rm=TRUE)) 
  most <- df %>% filter (sum == max(sum)) %>% pull(year)
  return(most)
  
}
val_20<- biggest(co2_data)


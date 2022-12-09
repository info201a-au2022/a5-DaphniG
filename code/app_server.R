library(shiny)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(plotly)
library(readr)

# dataset for CO2
co2_data <- read_csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

shinyServer(function(input,output) {
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
    
    
    
    plot_ly(plotData, x = ~year, y = ~gas_co2, type = 'scatter', mode = 'lines',name = 'gas') %>% layout(yaxis = list(title = 'co2 emissions')) %>% 
      add_trace(y = ~coal_co2, name = 'coal')%>% add_trace(y = ~oil_co2, name = 'oil') %>% 
      add_trace(y = ~trade_co2, name = 'trade')
    
    
  })
  output$countryPlot <- renderPlotly({
    linePlot()
    
  })
})

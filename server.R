#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

##load required library
library(dplyr)
library(data.table)
library(DT)
library(ggplot2)

carmake <- sort(unique(newdata$make)) ##get brands of cars
Drive <- sort(unique(newdata$drive))

shinyServer(function(input, output) {

  ##reactive values for makes of cars
  values_carmake <-reactiveValues()
  values_carmake$carmake <- carmake
  
  ##reactive values for types of drive
  values_drive <- reactiveValues()
  values_drive$Drive <- Drive
  
  ##Prepare for dataset
  dtTable <- reactive({
    dataByAll(newdata,input$Year,input$EPA[1],input$EPA[2],input$carmake, input$Drive)
  })
  ##output display dataset
  output$dt <-renderDataTable({
    dtTable()
  })
  
  ##Prepare dataset for graphs
  datasetByEPA <- reactive({
    dataByEPA(newdata,input$Year,input$EPA[1],input$EPA[2])
  })
  
  datasetByMake <-reactive({
    aggDataByMake(newdata,input$Year,input$EPA[1],input$EPA[2],input$carmake)
  })
  ##output display graphs
  output$plot1 <- renderPlot({
    ggplot(datasetByEPA(),aes(displ,youSaveSpend))+geom_point(aes(colour = factor(drive)),size = 4)
  })
  output$plot2 <- renderPlot({
    ggplot(datasetByMake(),aes(x=model, y=youSaveSpend,fill= drive))+geom_bar(stat="identity")+coord_flip()
  })
})

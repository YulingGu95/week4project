#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
carmake <- sort(unique(newdata$make)) ##get brands of cars
Drive <- sort(unique(newdata$drive))
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Different Models of Car's Efficiency Comparision"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("Year",
                  "Year of Car Make:", 
                  min = 2013,
                  max = 2018,
                  value = 2014),
      sliderInput("EPA",
                  "EPA Fuel Economy Score",
                  min= 1,
                  max = 10,
                  value = c(1,10)),
      selectInput("carmake", "Make of Car:", choices = carmake),
      selectInput("Drive","Drive axle type:", choices = Drive),
      helpText("Drive tab is only response to the dataset tab when you try to
               filter by different Drive axle type")
      ),
    
    # Show dataset and plots
    mainPanel(
      tabsetPanel(
        tabPanel(p(icon("plots"),"Visualize Cars' Fuel Efficiency"),
                 h5("Engine Displacement in Liters with Saving you Spend For Each Year ", align="center"),
                 plotOutput("plot1"),
                 helpText("Note: this graph can only reactive to year and EPA scale. ",
                          "displ: Engine displacement in liters. ",
                          "youSaveSpend: You save/spend over 5 years compared to an average car ($)."),
                 h5("Models of Specific Make of Car on What you Save", align="center"),
                 plotOutput("plot2"),
                 helpText("Note: this graph can only reactive to year, EPA scale and make of car. ",
                          "Some of brands of cars does not have enough data to show.")
        ),
        tabPanel(p(icon("table"),"Dataset"), dataTableOutput(outputId ="dt"))
      )
    )
    )
))

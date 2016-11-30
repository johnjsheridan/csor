# Server function for climr package shiny app

library(shiny)
library(csor)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$distPlot = renderPlot({
    data_csor = loadGDP()

    plot(data_csor, SecCode = input$sector, SeaAdj = input$seaAdj, type = input$type)
  })

})

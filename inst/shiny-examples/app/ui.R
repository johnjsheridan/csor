# Web app for the climr package

library(shiny)
library(csor)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Analysis of Irish GDP data from the Central Statistics Office"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
       selectInput("sector",
                   "Sector",
                   choices = list("All Sectors" = 0,
                                  "Agriculture Forestry and Fishing" = 1,
                                  "Industry" = 2,
                                  "Distribution Transport Software and Communication" = 3,
                                  "Public Administration and Defence" = 4,
                                  "Other Services (including Rent)" = 5,
                                  "Industry - Building and Construction" = 6,
                                  "Industry - Transportable Goods Industries and Utilities" = 7),
                   selected = 0),
       selectInput("seaAdj",
                   "Seasonally Adjusted",
                   choices = list("Yes" = TRUE,
                                  "No" = FALSE),
                   selected = FALSE),
       selectInput("type",
                   "Plot Type",
                   choices = list("Line Plot" = "l",
                                  "Scatter Plot with Fitted Line" = "lf",
                                  "Stacked Bar Chart" = "s"),
                   selected = "l")
    ),

    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
    )
  )
))

library(shiny)
library(tidyverse)

police_incident_reports<- read_delim("police-incident-reports-written.csv", delim = ";")

# Define UI for app that draws a histogram and a data table----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Homework 8"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Integer for age ----
      numericInput(inputId = "intercept",
                   label = "Age:",
                   min = 1,
                   max = 100,
                   value = 20)
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram and table----
      plotOutput(outputId = "popPlot")
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # renderPlot creates histogram and links to ui
  output$popPlot <- renderPlot({
    police_incident_reports %>% 
      ggplot(aes(x=`Victim Age`)) +
      geom_histogram() +
      geom_vline(xintercept = input$intercept) +
      labs(x = "Victim Age",
           title = "Histogram of Chapel Hill Open Data Police Incident Victim Age")
  })
}

shinyApp(ui = ui, server = server)
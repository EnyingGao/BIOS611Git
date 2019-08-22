library(shiny)
library(tidyverse)

# Read the aggregated csv file
final = read_csv('final.csv', col_names = c('Institution Name', 'Number of Collaborations', "Subject Emphases"))

# Filter out the top 10 collaborating institutions
final <-
  final %>%
  group_by(`Institution Name`) %>% 
  filter(!(`Institution Name` %in% c(NA))) %>% 
  arrange(desc(`Number of Collaborations`)) %>% 
  head(10)

# Common subject emphases among top 10 collaborating institutions
emphases <- as.tibble(unlist(str_split(final$`Subject Emphases`, " ")))

emphases <- emphases %>% 
  group_by(value) %>% 
  summarise(number= n())

# Define UI for app that draws a histogram and a data table----
ui <- fluidPage(
  
  # App title ----
  titlePanel("UNC's Top 10 Collaborating Institutions"),
    
    # Main panel for displaying outputs ----
    mainPanel(
     
      br(),
      
       # Add Interpretation
      p("The table below lists UNC's top 10 collaborating institutions based on the number of abstracts shared with UNC. The subject emphases give the most abundant words in the abstracts associated with each collaborating institution."),
      
      p("The bar chart below shows the number of times a subject emphasis being metioned among the top 10 collaborating institutions. It seems that most of the collaborations cetners on subject cancer and deals with clinical trials and therapies."),
      
      br(),
      
      # Output: Histogram and table----
      dataTableOutput(outputId = "popTable"),
      plotOutput(outputId = "popPlot")
          )
  )

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # Data table output, linked to ui
  output$popTable <- renderDataTable({final})
  
  # Histogram
  output$popPlot <- renderPlot({
    emphases %>% 
      filter(!(number == 1)) %>% 
      ggplot(aes(x=reorder(value, number), y = number)) +
      geom_bar(stat = "identity") +
      coord_flip() +
      scale_y_continuous(breaks = c(seq(1,10))) +
      labs(x = "Subject Emphases",
           y = "Frequency",
           title = "Common Subject Emphases Among Top 10 Collaborating Institutions") +
      theme_classic()
  })
}

shinyApp(ui = ui, server = server)




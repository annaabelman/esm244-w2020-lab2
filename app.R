# ------------------------
# Attach packages
# ------------------------

library(tidyverse)
library(shiny)
library(shinythemes)
library(here)

# ------------------------
# Read in spooky_data.csv
# ------------------------

spooky <- read_csv(here("data", "spooky_data.csv"))

# ------------------------
#Create my user interface
# ------------------------

ui <- fluidPage(
  theme = shinytheme("cosmo"),
  titlePanel("Awesome Title"),
  sidebarLayout(
    sidebarPanel("Widgets are here",
                 selectInput(inputId = "state_select",
                             label = "Chose a state:",
                             choices = unique(spooky$state)
                             )
                 ),
    mainPanel("Outputs are here",
              tableOutput(outputId = "candy_table"),
              )
  )
)

server <- function(input, output) {

  state_candy <- reactive({
    spooky %>%
      filter(state == input$state_select) %>%
      select(candy, pounds_candy_sold)
  })

  output$candy_table <- renderTable({
    state_candy()
  })

}

shinyApp(ui = ui, server = server)

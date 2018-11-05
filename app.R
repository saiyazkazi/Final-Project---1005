library(shiny)
library(tidyverse)
library(rsconnect)
library(readstata13)


# Define UI ----
ui <- fluidPage(
  titlePanel("Immigrant Voting Preferences by State"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Choose a State to See Immigrant Political Preferences."),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = v_temp,
                  selected = "NY")
      
      ),
    
    mainPanel(
      plotOutput("prefPlot")
    )
  )
)
# Define server logic ----
server <- function(input, output) {
  output$prefPlot <- renderPlot({
    destination <- read_rds("use_shiny")
    
    destination %>%
      group_by(V161010e) %>% 
      ggplot(aes(x=V161064x)) + geom_bar()
    
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)

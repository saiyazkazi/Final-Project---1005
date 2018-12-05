library(shiny)
library(tidyverse)
library(rsconnect)
library(readstata13)

destination <- read_rds(path = "use_shiny")

v_tempA <- unique(destination$V161010e)
v_tempA <- sort(v_tempA)

# Define UI ----
ui <- fluidPage(
  titlePanel("Immigrant Voting Preferences by State"),
  textAreaInput("caption", "Data Source", "This data comes from the 2016 ANES. 4000 respondents were asked to answer questions based on demographic, political, and social issues. The survey took place in two waves; right before and right after the 2016 general election.", width = "1000px"),
  textAreaInput("caption", "GitHub Repo", "https://github.com/saiyazkazi/Final-Project---1005"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Choose a State to See Immigrant Political Preferences."),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = v_tempA, 
                  selected = "AK")
      
      ),
    
    mainPanel(
      plotOutput("prefPlot")
    )
  )
)
# Define server logic ----
server <- function(input, output) {
  output$prefPlot <- renderPlot({
    
    destination %>%
      filter(input$var == V161010e) %>% 
      group_by(V161010e) %>% 
      ggplot(aes(x=V161064x, color = V161064x)) + geom_bar() + labs(x = "Party Vote", y = "Vote Strength") + scale_color_manual(values = c("#0000ff", "#008000","#ff0000"))
    
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)

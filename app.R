library(shiny)
library(datasets)
library(ggplot2)

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))


ui <- fluidPage(

  titlePanel("Miles Per Gallon"),

  sidebarLayout(

    sidebarPanel(

      selectInput("variable", "Variable:",
                  c("Cylinders" = "cyl",
                    "Transmission" = "am",
                    "Gears" = "gear")),
    ),
    
    mainPanel(
      h3(textOutput("caption")),
      plotOutput("mpgPlot")
      
    )
  )
)


server <- function(input, output) {
  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })
  

  output$caption <- renderText({
    formulaText()
  })
  

  output$mpgPlot <- renderPlot({
    ggplot(data = mpgData) +
      geom_histogram(color="white",fill="SteelBlue",mapping = aes(x = mpg),binwidth = 5)+facet_wrap(~mpgData[[input$variable]], nrow=3)
    
    
  })
  
}


shinyApp(ui, server)

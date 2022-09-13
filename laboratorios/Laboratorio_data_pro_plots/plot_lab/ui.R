library(shiny)


shinyUI(fluidPage(
  
  # Application title
  titlePanel("Laboratorio"),
  
  shiny::tabsetPanel(
    tabPanel("Plot Interactions",
             plotOutput("plot_click_options",
                        click = "clk",
                        dblclick = "dclk",
                        hover = 'mhover',
                        brush = 'mbrush' ),
             verbatimTextOutput("click_data"),
             tableOutput("mtcars_tbl")
    )
    
  )
))
library(shiny)
library(lubridate)


shinyUI(fluidPage(
  
  
  titlePanel("Shiny Inputs Glossary"),
  
  
  sidebarLayout(
    sidebarPanel(
      h1("Inputs"),
      numericInput("ninput","Ingrese un numero:",
                   value = 10, step =10),
      sliderInput('slinput','Seleccione un porcentaje:',
                  min = 0, max = 100, step = 1, value = 0, 
                  post='%'),
      sliderInput('slinputmulti','Seleccione Rango:',
                  value = c(10000,30000), 
                  min = 0, 
                  max = 150000, 
                  step = 1000, 
                  pre='Q',
                  sep = ','),
      sliderInput('slinputanimate','Pasos:',
                  value = 0, 
                  min = 0, 
                  max = 100,
                  step = 10,
                  animate = TRUE),
      dateInput('date_input', 'Ingrese fecha', 
                value = Sys.Date(),
                language = 'es', 
                weekstart = 1,
                format = 'dd-mm-yyyy'),
      dateRangeInput('date_range_input', 'Seleccione fechas',
                     start = today()-15,
                     end = today(),
                     max = today(),
                     min = today() - 365,
                     language = 'es',
                     separator = 'hasta'),
      selectInput('select_input', 'Seleccione estado:',
                  choices = state.name,
                  selected = state.name[sample(1:length(state.name), size = 1)]),
      selectInput('select_input_2', 'Seleccione letras',
                  choices = letters, selected = 'a', multiple = TRUE),
      checkboxInput('chkbox_input', 'Mostrar ',
                    value = FALSE),
      checkboxGroupInput('chkbox_group_input', 'Check box group',
                         choices = letters[1:3],
                         selected = NULL, inline = TRUE),
      radioButtons('radio_button', 'Seleccione nivel academico', 
                   choices = c('primaria'=1,'bachillerato'=2,'licenciatura'=3,
                               'maestria'=4, 'doctorado'=5)),
      actionButton('action_button', 'correr', icion = icon('database')),
      submitButton()
      
    ),
    
    mainPanel(
      h1("Outputs"),
      h2("numeric input"),
      verbatimTextOutput('out_numeric_input'),
      h2("slider input"),
      h3('Slider Input Simple'),
      verbatimTextOutput('out_slider_input'),
      h3('Slider Input Multiple'),
      verbatimTextOutput('out_slider_input_multi'),
      h3('Slider Input Animado'),
      verbatimTextOutput('out_slider_input_ani'),
      h2('Date Input'),
      verbatimTextOutput('out_date_inputs'),
      h2('Date range Input'),
      verbatimTextOutput('our_date_range_inputs'),
      h2('Select input'),
      verbatimTextOutput('select_input'),
      h2('Select multiple letras'),
      verbatimTextOutput('select_input_2'),
      h2('Check Box Input'),
      verbatimTextOutput('multiple_select_input'),
      h2('Check Box Group'),
      verbatimTextOutput('check_box_group_out'),
      h2('Radio bottons input'),
      verbatimTextOutput('radio_buttons_out'),
      h2('Action button'),
      verbatimTextOutput('action_button_out')
      
    )
  )
))
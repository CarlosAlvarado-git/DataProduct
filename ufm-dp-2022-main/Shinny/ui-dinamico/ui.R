
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("UI dinamico, UpdateInput"),
    
    tabsetPanel(
      tabPanel('Ejemplo 1',
               numericInput('lim_inf', label = 'Ingrese limite inferior', value = 1),
               numericInput('lim_sup', label = 'Ingrese limite superior', value = 1),
               sliderInput('sl1', label = 'Seleccione intervalo', value = 5, min = 0, max = 15)
               ),
      tabPanel('Ejemplo 2',
               sliderInput('sl2', label = 'Seleccione intervalo', value = 0, min = -10, max = 10),
               sliderInput('sl3', label = 'Seleccione intervalo', value = 0, min = -10, max = 10),
               sliderInput('sl4', label = 'Seleccione intervalo', value = 0, min = -10, max = 10),
               sliderInput('sl5', label = 'Seleccione intervalo', value = 0, min = -10, max = 10),
               sliderInput('sl6', label = 'Seleccione intervalo', value = 0, min = -10, max = 10),
               actionButton('limpiar', 'limpiar')
               ),
      tabPanel('Ejemplo 3',
               numericInput('runs', 'Cuantas corridas', value = 5),
               actionButton('correr', 'correr')
               ),
      tabPanel('Ejemplo 4', 
               numericInput('nvalue', 'valor', value = 0)
               ),
      tabPanel('Ejemplo 5',
               numericInput('celsius', 'Ingrese grados celsius', value = NULL, step = 1),
               numericInput('farenheit', 'Ingrese grados farenheit', value = NULL, step = 1)
               ),
      tabPanel('Ejemplo 6',
               selectInput('dist', 'Distribución', choices = c('normal',
                                                               'uniform',
                                                               'exponencial')),
               numericInput('nrandom', 'Numero de muestras', value = 100),
               tabsetPanel(id = 'parametros',
                           type = 'hidden',
                           tabPanel('normal',
                                    numericInput('n_media','media', value = 0),
                                    numericInput('n_sd','desviacion', value = 1),
                                    ),
                           tabPanel('uniform',
                                    numericInput('a','minimo', value = 0),
                                    numericInput('b','maximo', value = 1),
                                    ),
                           tabPanel('exponencial',
                                    numericInput('lambda','razon', value = 1, min = 0)
                                    )
                           ),
               plotOutput('plot_dist')
               )
    )
    
))

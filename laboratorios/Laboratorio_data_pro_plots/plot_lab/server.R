library(shiny)
library(ggplot2)
library(dplyr)
library(DT)

globalVar <- NULL
doble <- NULL
arr_puntos <- data.frame(matrix(ncol = 2, nrow = 0))
x <- c("x", "y")
colnames(arr_puntos) <- x
puntacos <- data.frame(matrix(ncol = 2, nrow = 1))
x <- c("x", "y")
colnames(puntacos) <- x
puntacos$x <- as.numeric(puntacos$x)
puntacos$y <- as.numeric(puntacos$y)
mi_tabla <- mtcars
mi_tabla$nombres <- row.names(mi_tabla)


shinyServer(function(input, output) {
  
  grafica <- reactive({
    plot(mtcars$wt,mtcars$mpg, xlab = "wt", ylab="millas por galon")
    df <- puntos()
    points(df$wt, df$mpg, col = "green", pch = 21)
  })

  
  output$click_data <- renderPrint({
    clk_msg <- NULL
    dclk_msg<- NULL
    mhover_msg <- NULL
    mbrush_msg <- NULL
    if(!is.null(input$clk$x) ){ #clk es el nombre de la respuesta del click
      clk_msg<-
        paste0("click cordenada x= ", round(input$clk$x,2), 
               " click coordenada y= ", round(input$clk$y,2))
    }
    if(!is.null(input$dclk$x) ){
      dclk_msg<-paste0("doble click cordenada x= ", round(input$dclk$x,2), 
                       " doble click coordenada y= ", round(input$dclk$y,2))
    }
    if(!is.null(input$mhover$x) ){
      mhover_msg<-paste0("hover cordenada x= ", round(input$mhover$x,2), 
                         " hover coordenada y= ", round(input$mhover$y,2))
    }
    
    
    if(!is.null(input$mbrush$xmin)){
      brushx <- paste0(c('(',round(input$mbrush$xmin,2),',',round(input$mbrush$xmax,2),')'),collapse = '')
      brushy <- paste0(c('(',round(input$mbrush$ymin,2),',',round(input$mbrush$ymax,2),')'),collapse = '')
      mbrush_msg <- cat('\t rango en x: ', brushx,'\n','\t rango en y: ', brushy)
    }
    
    cat(clk_msg,dclk_msg,mhover_msg,mbrush_msg,sep = '\n')
    
  })
  
  
  puntos <- reactive({
    df <- NULL
    browser()
    if(!is.null(input$clk)){
      if(is.null(globalVar)){
        globalVar <<- rbind(globalVar, df)
      }
      else{
        df <- nearPoints(mi_tabla,input$clk,xvar='wt',yvar='mpg',threshold = 2) #este es para que solo sea un punto en específico
        doble <- globalVar %>% filter_all(any_vars(. %in% c(df$nombres)))
        if(nrow(doble)==0){
          globalVar <<- rbind(globalVar, df)
        }
        if(nrow(globalVar)!=0){
          return(globalVar)
        } else {
          NULL
        }
      }
    }
    if(!is.null(input$dclk)){
      if(is.null(globalVar)){
        globalVar <<- rbind(globalVar, df)
      }
      else{
        df <- nearPoints(mi_tabla,input$dclk,xvar='wt',yvar='mpg',threshold = 2) #este es para que solo sea un punto en específico
        globalVar <- globalVar[ !(globalVar$nombres %in% c(df$nombres)), ]
        if(nrow(globalVar)!=0){
          return(globalVar)
        } else {
          NULL
        }
      }
        
    }
    if(!is.null(input$mbrush)){
      if(is.null(globalVar)){
        globalVar <<- rbind(globalVar, df)
      }
      else{
        df <- brushedPoints(mtcars,input$mbrush,xvar='wt',yvar='mpg') #los puntos seleccionados
        doble <- globalVar %>% filter_all(any_vars(. %in% c(df$nombres)))
        if(nrow(doble)==0){
          globalVar <<- rbind(globalVar, df)
        }
        if(nrow(globalVar)!=0){
          return(globalVar)
        } else {
          NULL
        }
      }
    }
    else{
      NULL
      
    }
  })
  
  
  output$mtcars_tbl <- renderTable({
    puntos()
  })
  
  
  
  
  output$plot_click_options <- renderPlot({
    grafica()
  })
  
  
})

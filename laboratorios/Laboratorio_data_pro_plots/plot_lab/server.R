library(shiny)
library(ggplot2)
library(dplyr)
library(DT)

globalVar <- NULL
globalVar2 <- NULL
doble <- NULL
mi_tabla <- mtcars
mi_tabla$nombres <- row.names(mi_tabla)


shinyServer(function(input, output) {
  
  grafica <- reactive({
    plot(mtcars$wt,mtcars$mpg, xlab = "wt", ylab="millas por galon")
    df1 <- puntos()
    #browser()
    points(df1$wt, df1$mpg, col = "green", pch = 19)
    df2 <- puntos_hover()
    points(df2$wt, df2$mpg, col = "gray", pch = 19)
    
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
      puntos()
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
  
  puntos_hover <- reactive({
    print("Entre a mhover")
    #browser()
    if(is.null(globalVar2)){
      df <- nearPoints(mi_tabla,input$mhover,xvar='wt',yvar='mpg',threshold = 5)
      globalVar2 <<- rbind(globalVar2, df)
      return(globalVar2)
    }
    else{
      df <- nearPoints(mi_tabla,input$mhover,xvar='wt',yvar='mpg',threshold = 5)#este es para que solo sea un punto en específico
      if(nrow(df)==0){
        return(globalVar2)
      }
      globalVar2 <<- NULL
      doble <- globalVar %>% filter_all(any_vars(. %in% c(df$nombres)))
      if(nrow(doble)==0){
        globalVar2 <<- rbind(globalVar2, df)
        return(globalVar2)
      }
      return(globalVar2)
    }
  })
  puntos <- reactive({
    if(!is.null(input$clk) ){
      print("Entre a clk")
      #browser()
      if(is.null(globalVar)){
        df <- nearPoints(mi_tabla,input$clk,xvar='wt',yvar='mpg',threshold = 2) #este es para que solo sea un punto en específico
        globalVar <<- rbind(globalVar, df)
        return(globalVar)
      }
      else{
        df <- nearPoints(mi_tabla,input$clk,xvar='wt',yvar='mpg',threshold = 2) #este es para que solo sea un punto en específico
        doble <- globalVar %>% filter_all(any_vars(. %in% c(df$nombres)))
        if(nrow(doble)==0){
          globalVar <<- rbind(globalVar, df)
        }
        return(globalVar)
      }
    }
    if(!is.null(input$dclk)){
      #browser()
      print("Entre a dclk")
      if(is.null(globalVar)){
        return(globalVar)
      }
      else{
        df <- nearPoints(mi_tabla,input$dclk,xvar='wt',yvar='mpg',threshold = 5) #este es para que solo sea un punto en específico
        globalVar <<- globalVar[ !(globalVar$nombres %in% c(df$nombres)), ]
        return(globalVar)
      }
        
    }
    if(!is.null(input$mbrush)){
      print("Entre a mbrush")
      if(is.null(globalVar)){
        df <- brushedPoints(mi_tabla,input$mbrush,xvar='wt',yvar='mpg') 
        globalVar <<- rbind(globalVar, df)
        return(globalVar)
      }
      else{
        #browser()
        df <- brushedPoints(mi_tabla,input$mbrush,xvar='wt',yvar='mpg') #los puntos seleccionados
        doble <- globalVar %>% filter_all(any_vars(. %in% c(df$nombres)))
        df <- df[ !(df$nombres %in% c(doble$nombres)), ]
        if(nrow(doble)==0){
          globalVar <<- rbind(globalVar, df)
        }
        else if (nrow(df)!=0){
          globalVar <<- rbind(globalVar, df)
        }
        return(globalVar)
      }
    }
    return(globalVar)
  })
  
  
  output$mtcars_tbl <- renderTable({
    #browser()
    puntos()})
  
  
  
  
  output$plot_click_options <- renderPlot({
    grafica()
  })
  
  
})

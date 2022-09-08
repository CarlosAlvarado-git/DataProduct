library(shiny)
library(ggplot2)
library(dplyr)
library(DT)

globalVar <- NULL
doble <- NULL
arr_puntos <- data_frame(NULL)
arr_puntos$x <- NULL
mi_tabla <- mtcars
mi_tabla$nombres <- row.names(mi_tabla)


shinyServer(function(input, output) {
  
  output$grafica_base_r <- renderPlot({
    plot(mtcars$wt,mtcars$mpg, xlab = "wt", ylab="millas por galon")
    
  })
  
  
  output$grafica_ggplot <- renderPlot({
    diamonds %>%
      ggplot(aes(x=carat,y=price,color=color))+
      geom_point()+
      ylab("Precio")+
      xlab("Kilates")+
      ggtitle("Precio de Diamantes por kilate")
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
  output$mtcars_tbl <- renderTable({
    
    df <- nearPoints(mi_tabla,input$clk,xvar='wt',yvar='mpg',threshold = 1) #este es para que solo sea un punto en específico
    
    #select rows where 25 appears in any column
    #browser()
    if(is.null(globalVar)){
      globalVar <<- rbind(globalVar, df)
    }
    else{
      doble <- globalVar %>% filter_all(any_vars(. %in% c(df$nombres)))
      if(nrow(doble)==0){
        globalVar <<- rbind(globalVar, df)
        browser()
        points(x=input$clk$x, y = input$clk$y,col = 'green', pch = '19')
      }
      else{
        globalVar <- globalVar[ !(globalVar$nombres %in% c(df$nombres)), ]
      }
    }
    
    
    
    #points(df,col = 'green', pch = '19')
    ##df <- brushedPoints(mtcars,input$mbrush,xvar='wt',yvar='mpg') #los puntos seleccionados
    if(nrow(globalVar)!=0){
      globalVar 
    } else {
      NULL
    }
    
  })
  
  
  
  
  output$plot_click_options <- renderPlot({
    
    plot(mtcars$wt,mtcars$mpg, xlab = "wt", ylab="millas por galon")
  })
  
  
})

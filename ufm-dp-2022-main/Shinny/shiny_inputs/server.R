library(shiny)

shinyServer(function(input, output) {
  
  output$out_numeric_input <- renderPrint({
    print(input$ninput)
  })    
  
  output$out_slider_input<- renderPrint({
    print(input$slinput)
  })
  
  output$out_slider_input_multi<- renderPrint({
    print(input$slinputmulti)
  })
  
  output$out_slider_input_ani<- renderPrint({
    print(input$slinputanimate)
  })
  
  output$out_date_inputs <- renderPrint({
    print(input$date_input)
  })
  
  output$our_date_range_inputs <- renderPrint({
    print(input$date_range_input)
  })
  
  output$select_input <- renderPrint({
    print(input$select_input)
  })
  output$select_input_2 <- renderPrint({
    print(input$select_input_2)
  })
  
  output$multiple_select_input <- renderPrint({
    print(input$chkbox_input)
  })
  
  output$check_box_group_out <- renderPrint({
    print(input$chkbox_group_input)
  })
  
  output$radio_buttons_out <- renderPrint({
    print(input$radio_button)
  })
  output$action_button_out <- renderPrint({
    print(input$action_button)
  })
})
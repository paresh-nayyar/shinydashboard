server <- function(input, output)
{
  data <- reactive({
    df <- read.csv(input$filedata$datapath,
                   header = input$header,
                   sep    = input$sep)
    
  })
  output$contents <- renderTable({
    
    req(input$filedata)
    get <- input$filedata
    
    if(is.null(input$filedata)){
      return(NULL)
    }else{
    
    if(input$disp == 'head'){
      return(head(data()))
    }
    else {
      return(data())
    }
    }    
  })
  output$summary <- renderPrint({

    if(is.null(input$filedata))
      return("Waitingforfile")
    summary(data())
    
    
    
  }
    
  )
}


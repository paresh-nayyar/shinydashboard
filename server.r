get <- NULL
server <- function(input, output)
{
    data <- eventReactive(input$submit,{
      df <- read.csv(input$filedata$datapath,sep = input$sep, header = input$header)
      
    })
   
  output$contents <- renderTable({
    
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

    if(is.null(input$submit)){
      return("Waitingforfile")
    }else{
      summary(data())
    }
    }
    
  )
  
 output$columns <- renderUI({
   df        <- data()
   col.names <- names(df)
   selectInput("columns","Select Columns",col.names,multiple = T)
 })
}


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
  
 output$line.x <- renderUI({
   df        <- data()
   col.names <- names(df)
   selectInput("x","Select X-Axis",col.names,multiple = T)
   
 })
 
 output$line.y <- renderUI({
   df        <- data()
   col.names <- names(df)
   selectInput("y","Select Y-Axis",col.names,multiple = T)
   
 })
 
 output$hist <- renderUI({
   df        <- data()
   col.names <- names(df)
   selectInput("hist","Select Column",col.names,multiple = F)
   
 })
 
 # getvalue <- reactive({
 #   output$hist
 #   print(input$hist)
 # })
 
 output$check <- renderPlot({
   
   if(is.null(input$submit)){
     return("Waitingforfile")
   }else{
     values <- as.numeric(data()[,input$hist])
    # hist(values,col='blue',main = paste('Distribution of',input$hist),xlab = input$hist)
     x<-ggplot(data=data(), aes(data()[,input$hist])) + geom_histogram() + 
       labs(x = input$hist)
     x
   }
 }
 
 )
 
 # output$check1 <- renderPrint({
 #   
 #   if(is.null(input$submit)){
 #     return("Waitingforfile")
 #   }else{
 #     values <- data()[,input$hist]
 #     print(values)
 #     
 #   }
 # }
 #)
 

 
}

